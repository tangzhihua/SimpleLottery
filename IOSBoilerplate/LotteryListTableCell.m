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


@implementation LotteryListTableCell

 

-(void)setLotteryOpenPrizeStatusEnum:(LotteryOpenPrizeStatusEnum)lotteryOpenPrizeStatusEnum {
	
	switch (lotteryOpenPrizeStatusEnum) {
		case kLotteryOpenPrizeStatusEnum_TodayOpenPrize: {
			_lotterySaleStatusImageView.image = [UIImage imageNamed:@"lottery_list_mark_for_kaijiang"];
		}break;
		case kLotteryOpenPrizeStatusEnum_TodayAddAward: {
			_lotterySaleStatusImageView.image = [UIImage imageNamed:@"lottery_list_mark_for_jiajiang"];
		}break;
		case kLotteryOpenPrizeStatusEnum_TodayOpenPrizeAndAddAward: {
			_lotterySaleStatusImageView.image = [UIImage imageNamed:@"lottery_list_mark_for_kaijiang_and_jiajiang"];
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
 
@end
