//
//  CurrentBatchCodeCountDown.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-11.
//
//

#import "CurrentIssueCountDown.h"
#import "LotteryDictionary.h"
#import "LotteryIssueInfo.h"
 



@interface CurrentIssueCountDown ()
// 彩票 字典
@property (nonatomic, readwrite, strong) LotteryDictionary *lotteryDictionary;


@end

@implementation CurrentIssueCountDown

static const int kCountDownSecondOfRerequestNetworkMax = 30;
-(void)setLotteryIssueInfo:(LotteryIssueInfo *)lotteryIssueInfo {
	if (_lotteryIssueInfo != lotteryIssueInfo) {
		_lotteryIssueInfo = lotteryIssueInfo;
		
		// 更新倒计时时间
		_countDownSecond = [lotteryIssueInfo.time_remaining integerValue];
		
		// 复位网络请求索引
		_netRequestIndex = NETWORK_REQUEST_ID_OF_IDLE;
		
 
	}
}

#pragma mark -
#pragma mark 方便构造
+(id)currentIssueCountDownWithLotteryDictionary:(LotteryDictionary *)lotteryDictionary {
	CurrentIssueCountDown *newInstance = [[CurrentIssueCountDown alloc] init];
	newInstance.lotteryDictionary = lotteryDictionary;
	newInstance.netRequestIndex = NETWORK_REQUEST_ID_OF_IDLE;
	newInstance.isNetworkDisconnected = NO;
	newInstance.countDownSecondOfRerequestNetwork = kCountDownSecondOfRerequestNetworkMax;
	newInstance.countDownSecond = 0;
	return newInstance;
}

#pragma mark -
#pragma mark 重置 网络不通时, 重新联网倒计时相关数据
-(void)resetCountDownOfNetworkDisconnected {
	self.isNetworkDisconnected = NO;
 
	self.countDownSecondOfRerequestNetwork = kCountDownSecondOfRerequestNetworkMax;
	 
	self.netRequestIndex = NETWORK_REQUEST_ID_OF_IDLE;
	 
}

#pragma mark -
#pragma mark 重置 当前彩票观察者
-(void)resetCurrentIssueCountDown {
	self.lotteryIssueInfo = nil;
	self.netRequestIndex = NETWORK_REQUEST_ID_OF_IDLE;
	self.isNetworkDisconnected = NO;
	self.countDownSecondOfRerequestNetwork = kCountDownSecondOfRerequestNetworkMax;
	self.countDownSecond = 0;
}



 
@end
