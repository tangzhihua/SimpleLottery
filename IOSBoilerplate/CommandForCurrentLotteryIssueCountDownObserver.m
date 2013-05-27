//
//  CommandForCurrentLotteryIssueCountDownObserver.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-11.
//
//

#import "CommandForCurrentLotteryIssueCountDownObserver.h"
#import "CurrentLotteryIssueCountDownObserver.h"


#import "LotteryDictionaryDatabaseFieldsConstant.h"

#import "LotteryDictionary.h"










@interface CommandForCurrentLotteryIssueCountDownObserver ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;

@end










@implementation CommandForCurrentLotteryIssueCountDownObserver


static CommandForCurrentLotteryIssueCountDownObserver *singletonInstance = nil;

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  
  if (!_isExecuted) {
    _isExecuted = YES;
		
		
		// 读取本地彩票字典
		NSString *filePathForLotteryDictionary = [[NSBundle mainBundle] pathForResource:@"lottery_list" ofType:@"plist"];
    NSArray *plistForLotteryDictionary = [[NSArray alloc] initWithContentsOfFile:filePathForLotteryDictionary];
		NSMutableArray *lotteryDictionaryList = [NSMutableArray arrayWithCapacity:20];
		for (NSDictionary *lotteryDictionary in plistForLotteryDictionary) {
			NSString *key = [lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_key];
			NSString *name = [lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_name];
			NSString *code = [lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_code];
			NSString *icon = [lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_icon];
			NSString *ad = [lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_ad];
			BOOL enable = [[lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_enable] boolValue];
			NSString *fixedInformation = [lotteryDictionary objectForKey:k_LotteryDictionary_RequestKey_fixed_information];
			if (enable) {
				LotteryDictionary *lotteryDictionary = [LotteryDictionary lotteryDictionaryWithKey:key
																																											name:name
																																											code:code
																																											icon:icon
																																												ad:ad
																																										enable:enable
																																					fixedInformation:fixedInformation];
				[lotteryDictionaryList addObject:lotteryDictionary];
			}
		}
		
		[GlobalDataCacheForMemorySingleton sharedInstance].lotteryDictionaryList = lotteryDictionaryList;
		
		
		
		
		
		
		
		// 启动 彩票当期期号到期倒计时观察者
		[[CurrentLotteryIssueCountDownObserver sharedInstance] startCountDownObserver];
		
		
  }
  
}

+(id)commandForCurrentLotteryIssueCountDownObserver {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandForCurrentLotteryIssueCountDownObserver alloc] init];
    singletonInstance.isExecuted = NO;
		
  }
  return singletonInstance;
}






@end
