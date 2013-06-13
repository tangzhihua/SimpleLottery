//
//  CurrentLotteryIssueCountDownObserver.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-11.
//
//

#import <Foundation/Foundation.h>

@interface CurrentLotteryIssueCountDownManager : NSObject {
	
}

// 被观察者队列
@property (nonatomic, readonly, strong) NSDictionary *currentIssueCountDownBeanList;

+ (CurrentLotteryIssueCountDownManager *) sharedInstance;

-(void)startCountDownObserver;
-(void)stopCountDownObserver;

// 
-(void)resetObserver;
@end
