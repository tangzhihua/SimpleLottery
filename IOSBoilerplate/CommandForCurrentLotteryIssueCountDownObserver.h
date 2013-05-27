//
//  CommandForCurrentLotteryIssueCountDownObserver.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-11.
//
//

#import <Foundation/Foundation.h>
 
#import "Command.h"
@interface CommandForCurrentLotteryIssueCountDownObserver : NSObject <Command> {
  
}

+(id)commandForCurrentLotteryIssueCountDownObserver;
@end