//
//  CurrentLotteryIssueCountDownObserver.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-11.
//
//

#import <Foundation/Foundation.h>

@interface CurrentLotteryIssueCountDownObserver : NSObject <IDomainNetRespondCallback> {
	
}

@property (nonatomic, readonly, strong) NSDictionary *lotteryListOfCountDownObserver;

+ (CurrentLotteryIssueCountDownObserver *) sharedInstance;

-(void)startCountDownObserver;
-(void)stopCountDownObserver;


-(void)resetObserver;
@end
