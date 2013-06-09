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
#import "DomainProtocolNetHelperSingleton.h"



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
		_netRequestIndex = IDLE_NETWORK_REQUEST_ID;
		
		//
		_observerList = [[NSMutableSet alloc] init];
	}
}

#pragma mark -
#pragma mark 方便构造
+(id)currentIssueCountDownWithLotteryDictionary:(LotteryDictionary *)lotteryDictionary {
	CurrentIssueCountDown *newInstance = [[CurrentIssueCountDown alloc] init];
	newInstance.lotteryDictionary = lotteryDictionary;
	newInstance.netRequestIndex = IDLE_NETWORK_REQUEST_ID;
	newInstance.isNetworkDisconnected = NO;
	newInstance.countDownSecondOfRerequestNetwork = kCountDownSecondOfRerequestNetworkMax;
	newInstance.countDownSecond = 0;
	return newInstance;
}

#pragma mark -
#pragma mark 重置 网络不通时, 重新联网倒计时相关数据
-(void)resetCountDownOfNetworkDisconnected {
	self.isNetworkDisconnected = NO;
	[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_isNetworkDisconnected];
	self.countDownSecondOfRerequestNetwork = kCountDownSecondOfRerequestNetworkMax;
	[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_countDownSecondOfRerequestNetwork];
	self.netRequestIndex = IDLE_NETWORK_REQUEST_ID;
	[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_netRequestIndex];
}

#pragma mark -
#pragma mark 重置 当前彩票观察者
-(void)resetCurrentIssueCountDown {
	self.lotteryIssueInfo = nil;
	self.netRequestIndex = IDLE_NETWORK_REQUEST_ID;
	self.isNetworkDisconnected = NO;
	self.countDownSecondOfRerequestNetwork = kCountDownSecondOfRerequestNetworkMax;
	self.countDownSecond = 0;
}




// 这里是手动添加观察者的代码
-(void)setCountDownSecond:(NSInteger)newValue{
	if (_countDownSecond != newValue) {
		[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_countDownSecond];
	}
	
	_countDownSecond = newValue;
}
-(void)setNetRequestIndex:(NSInteger)newValue{
	if (_netRequestIndex != newValue) {
		[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_netRequestIndex];
	}
	
	_netRequestIndex = newValue;
}
-(void)setIsNetworkDisconnected:(BOOL)newValue{
	if (_isNetworkDisconnected != newValue) {
		[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_isNetworkDisconnected];
	}
	
	_isNetworkDisconnected = newValue;
}
-(void)setCountDownSecondOfRerequestNetwork:(NSInteger)newValue{
	if (_countDownSecondOfRerequestNetwork != newValue) {
		[self notifyObserversWithEventEnum:kCurrentIssueCountDownEventEnum_countDownSecondOfRerequestNetwork];
	}
	
	_countDownSecondOfRerequestNetwork = newValue;
}

-(void)addObserver:(id<ICurrentIssueCountDownEventReceiver>)observer {
	[self.observerList addObject:observer];
}
-(void)removeObserver:(id<ICurrentIssueCountDownEventReceiver>)observer {
	[self.observerList removeObject:observer];
}
-(void)notifyObserversWithEventEnum:(CurrentIssueCountDownEventEnum)eventEnum {
	for (id<ICurrentIssueCountDownEventReceiver> observer in self.observerList) {
    [observer currentIssueCountDownEventReceiverWithEventEnum:eventEnum currentIssueCountDownBean:self];
	}
}
@end
