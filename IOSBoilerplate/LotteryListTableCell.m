//
//  LotteryListTableCell.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-3.
//
//

#import "LotteryListTableCell.h"
#import "LotteryDictionary.h"
#import "CurrentIssueCountDown.h"
#import "CurrentLotteryIssueCountDownObserver.h"
#import "LotteryIssueInfo.h"
#import "ToolsFunctionForThisProgect.h"
#import "DomainProtocolNetHelperSingleton.h"
#import "NSString+isEmpty.h"
#import "CurrentIssueCountDownDatabaseFieldsConstant.h"
#import "LotteryDictionary.h"

@implementation LotteryListTableCell

static UIImage *kLotterySaleStatusImageOfKaijiang = nil;
static UIImage *kLotterySaleStatusImageOfJiajiang = nil;
static UIImage *kLotterySaleStatusImageOfKaijiangAndJiajiang = nil;

+(void) initialize {
  kLotterySaleStatusImageOfKaijiang = [UIImage imageNamed:@"lottery_list_mark_for_kaijiang"];
  kLotterySaleStatusImageOfJiajiang = [UIImage imageNamed:@"lottery_list_mark_for_jiajiang"];
  kLotterySaleStatusImageOfKaijiangAndJiajiang = [UIImage imageNamed:@"lottery_list_mark_for_kaijiang_and_jiajiang"];
}

-(void)setLotteryOpenPrizeStatusEnum:(LotteryOpenPrizeStatusEnum)lotteryOpenPrizeStatusEnum {
	
	switch (lotteryOpenPrizeStatusEnum) {
		case kLotteryOpenPrizeStatusEnum_TodayOpenPrize: {
			_lotterySaleStatusImageView.image = kLotterySaleStatusImageOfKaijiang;
		}break;
		case kLotteryOpenPrizeStatusEnum_TodayAddAward: {
			_lotterySaleStatusImageView.image = kLotterySaleStatusImageOfJiajiang;
		}break;
		case kLotteryOpenPrizeStatusEnum_TodayOpenPrizeAndAddAward: {
			_lotterySaleStatusImageView.image = kLotterySaleStatusImageOfKaijiangAndJiajiang;
		}break;
		default:
			break;
	}
	
	if (kLotteryOpenPrizeStatusEnum_NONE == lotteryOpenPrizeStatusEnum) {
		_lotterySaleStatusImageView.hidden = YES;
		_lotterySaleStatusImageView.image = nil;
	} else {
		_lotterySaleStatusImageView.hidden = NO;
		_lotterySaleStatusImageView.alpha = 0.0f;
		[UIView animateWithDuration:3.0 animations:^{
			_lotterySaleStatusImageView.alpha = 1.0f;
		}];
	}
	
	_lotteryOpenPrizeStatusEnum = lotteryOpenPrizeStatusEnum;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
										 ofObject:(id)object
											 change:(NSDictionary *)change
											context:(void *)context {
	
	NSString *text = nil;
	CurrentIssueCountDown *currentIssueCountDown = object;
	currentIssueCountDown = [[CurrentLotteryIssueCountDownObserver sharedInstance].lotteryListOfCountDownObserver objectForKey:currentIssueCountDown.lotteryDictionary.key];
	if([keyPath isEqualToString:k_CurrentIssueCountDown_countDownSecond]) {
		
		if (currentIssueCountDown.countDownSecond > 0) {
			NSString *dateString = [ToolsFunctionForThisProgect formatSecondToDayHourMinuteSecond:[NSNumber numberWithInteger:currentIssueCountDown.countDownSecond]];
			text = [NSString stringWithFormat:@"距离%@期截止:%@", currentIssueCountDown.lotteryIssueInfo.batchcode, dateString];
		}
		
	} else if ([keyPath isEqualToString:k_CurrentIssueCountDown_isNetworkDisconnected]) {
		if (currentIssueCountDown.isNetworkDisconnected) {
			text = [NSString stringWithFormat:@"网络异常, %d秒钟重新请求.", currentIssueCountDown.countDownSecondOfRerequestNetwork];
		}
		
	} else if ([keyPath isEqualToString:k_CurrentIssueCountDown_netRequestIndex]) {
		if (currentIssueCountDown.netRequestIndex != IDLE_NETWORK_REQUEST_ID) {
			text = @"彩期获取中,请稍等...";
		}
		
	} else if ([keyPath isEqualToString:k_CurrentIssueCountDown_countDownSecondOfRerequestNetwork]) {
		if (currentIssueCountDown.isNetworkDisconnected && currentIssueCountDown.countDownSecondOfRerequestNetwork > 0) {
			text = [NSString stringWithFormat:@"网络异常, %d秒钟重新请求.", currentIssueCountDown.countDownSecondOfRerequestNetwork];
		}
	}
	
	if (![NSString isEmpty:text]) {
		self.countdownForCurrentIssueToEnd.text = text;
	}
	
}

#pragma mark -
#pragma mark 数据绑定
-(void) bind:(LotteryDictionary *)lotteryDictionaryToBeDisplayed {
  // 彩票代码
  if ([lotteryDictionaryToBeDisplayed.key isEqualToString:kLotteryKey_jingcai_basketball]) {
    self.lotteryCode = @"JC_L";
  } else if ([lotteryDictionaryToBeDisplayed.key isEqualToString:kLotteryKey_jingcai_football]) {
    self.lotteryCode = @"JC_Z";
  } else if ([lotteryDictionaryToBeDisplayed.key isEqualToString:kLotteryKey_zucai]) {
    self.lotteryCode = @"ZC";
  } else {
    self.lotteryCode = lotteryDictionaryToBeDisplayed.code;
  }
  
  // 彩票 key
  self.lotteryKey = lotteryDictionaryToBeDisplayed.key;
  
  
  // 彩票 icon
  self.iconImageView.image = lotteryDictionaryToBeDisplayed.icon;
  // 彩票 name
  self.nameLabel.text = lotteryDictionaryToBeDisplayed.name;
  // 彩票 广告
  self.adLabel.text = lotteryDictionaryToBeDisplayed.ad;
  
  // 彩票 固定信息(比如竞彩足球, 就是会固定显示 "返奖率高达69%")
  if (![NSString isEmpty:lotteryDictionaryToBeDisplayed.fixedInformation]) {
    self.countdownForCurrentIssueToEnd.text = lotteryDictionaryToBeDisplayed.fixedInformation;
  }
  
  // 彩票销售信息
  self.lotteryOpenPrizeStatusEnum = kLotteryOpenPrizeStatusEnum_NONE;
}
@end
