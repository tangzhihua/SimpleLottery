//
//  SoftwareUpdateNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@class BroadcastMessageNetReapondBean;
@class LotteryCurrentIssueNetRespondBean;
@class AdImageInWelcomePageNetRespondBean;
@class UserLoggedInfo;
@interface SoftwareUpdateNetRespondBean : JSONModel

// Top新闻
@property (nonatomic, readonly, strong) NSString *news;
// 下次通知联网时间
@property (nonatomic, readonly, strong) NSNumber *noticetime;

// 广播消息
@property (nonatomic, readonly, strong) BroadcastMessageNetReapondBean *broadcastMessageReapondBean;
// 彩票排期
@property (nonatomic, readonly, strong) LotteryCurrentIssueNetRespondBean *lotteryCurrentIssueNetRespondBean;
// 欢迎界面的广告图片
@property (nonatomic, readonly, strong) AdImageInWelcomePageNetRespondBean *adImageInWelcomePageNetRespondBean;
// 用户自动登录
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
