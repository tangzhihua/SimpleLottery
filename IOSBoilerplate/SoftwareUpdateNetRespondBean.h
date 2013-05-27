//
//  SoftwareUpdateNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>

@class BroadcastMessageNetReapondBean;
@class LotteryCurrentIssueNetRespondBean;
@class AdImageInWelcomePageNetRespondBean;
@class UserLoggedInfo;
@interface SoftwareUpdateNetRespondBean : NSObject

// Top新闻
@property (nonatomic, readonly, strong) NSString *news;
// 下次通知联网时间
@property (nonatomic, readonly, strong) NSNumber *noticetime;

//
@property (nonatomic, readonly, strong) BroadcastMessageNetReapondBean *broadcastMessageReapondBean;
//
@property (nonatomic, readonly, strong) LotteryCurrentIssueNetRespondBean *lotteryCurrentIssueNetRespondBean;
//
@property (nonatomic, readonly, strong) AdImageInWelcomePageNetRespondBean *adImageInWelcomePageNetRespondBean;
//
@property (nonatomic, readonly, strong) UserLoggedInfo *userLoggedInfo;

#pragma mark -
#pragma mark 方便构造
+(id)softwareUpdateNetRespondBeanWithNews:(NSString *)news
															 noticetime:(NSNumber *)noticetime
							broadcastMessageReapondBean:(BroadcastMessageNetReapondBean *)broadcastMessageReapondBean
		lotteryCurrentBatchCodeNetRespondBean:(LotteryCurrentIssueNetRespondBean *)lotteryCurrentIssueNetRespondBean
			 adImageInWelcomePageNetRespondBean:(AdImageInWelcomePageNetRespondBean *)adImageInWelcomePageNetRespondBean
													 userLoggedInfo:(UserLoggedInfo *)userLoggedInfo;
@end
