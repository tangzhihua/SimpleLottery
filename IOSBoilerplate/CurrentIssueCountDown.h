//
//  CurrentBatchCodeCountDown.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-11.
//
//

#import <Foundation/Foundation.h>

@class LotteryIssueInfo;
@class LotteryDictionary;
@interface CurrentIssueCountDown : NSObject {
	
}

// 彩票 字典
@property (nonatomic, readonly, strong) LotteryDictionary *lotteryDictionary;
// 当前期号信息
@property (nonatomic, strong) LotteryIssueInfo *lotteryIssueInfo;

// 当前期号剩余时间计数器 (以秒为单位)
@property (nonatomic, assign) NSInteger countDownSecond;

// 当前彩票对应的 netRequestIndex , 如果不为 IDLE_NETWORK_REQUEST_ID 证明当前正在请求网络
@property (nonatomic, assign) NSInteger netRequestIndex;

// 网络是否不通
@property (nonatomic, assign) BOOL isNetworkDisconnected;
// 当网络不通时, 每隔10秒重新进行联网请求, 这就是 10秒倒计时
@property (nonatomic, assign) NSInteger countDownSecondOfRerequestNetwork;

#pragma mark -
#pragma mark 方便构造
+(id)currentIssueCountDownWithLotteryDictionary:(LotteryDictionary *)lotteryDictionary;

#pragma mark -
#pragma mark 重置 "网络不通时, 重新联网倒计时的相关变量"
-(void)resetCountDownOfNetworkDisconnected;

#pragma mark -
#pragma mark 重置 当前彩票观察者
-(void)resetCurrentIssueCountDown;






@end
