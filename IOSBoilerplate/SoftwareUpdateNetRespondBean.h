//
//  SoftwareUpdateNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@class BroadcastMessageNetReapondBean;
@class AdImageInWelcomePageNetRespondBean;
@class UserLoggedInfo;

@interface SoftwareUpdateNetRespondBean : BaseModel

// Top新闻
@property (nonatomic, readonly, strong) NSString *news;
// 下次通知联网时间
@property (nonatomic, readonly, strong) NSNumber *noticetime;

// 广播消息
@property (nonatomic, readonly, strong) BroadcastMessageNetReapondBean *broadcastMessageReapondBean;
// 所有彩票当前排期 (key:彩票ID, value:LotteryIssueInfo)
@property (nonatomic, readonly, strong) NSMutableDictionary *lotteryCurrentIssueMap;
// 欢迎界面的广告图片
@property (nonatomic, readonly, strong) AdImageInWelcomePageNetRespondBean *adImageInWelcomePageNetRespondBean;
// 用户自动登录
@property (nonatomic, readonly, strong) UserLoggedInfo *userLoggedInfo;

 
@end
