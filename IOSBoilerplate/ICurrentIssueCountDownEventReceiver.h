//
//  ICurrentIssueCountDownEvent.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-8.
//
//

#import <Foundation/Foundation.h>
@class CurrentIssueCountDown;
@protocol ICurrentIssueCountDownEventReceiver <NSObject>
-(void)currentIssueCountDownEventReceiverWithEventEnum:(NSInteger)eventEnum currentIssueCountDownBean:(CurrentIssueCountDown *)currentIssueCountDownBean;
@end
