//
//  SoftwareUpdateNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateNetRespondBean.h"
#import "SoftwareUpdateDatabaseFieldsConstant.h"
#import "BroadcastMessageNetReapondBean.h"
#import "AdImageInWelcomePageNetRespondBean.h"
#import "UserLoggedInfo.h"
#import "LotteryIssueInfo.h"

@interface SoftwareUpdateNetRespondBean ()
// Top新闻
@property (nonatomic, readwrite, strong) NSString *news;
// 下次通知联网时间
@property (nonatomic, readwrite, strong) NSNumber *noticetime;

// 广播消息
@property (nonatomic, readwrite, strong) BroadcastMessageNetReapondBean *broadcastMessageReapondBean;
// 所有彩票当前排期 (key:彩票ID, value:LotteryIssueInfo)
@property (nonatomic, readwrite, strong) NSMutableDictionary *lotteryCurrentIssueMap;
// 欢迎界面的广告图片
@property (nonatomic, readwrite, strong) AdImageInWelcomePageNetRespondBean *adImageInWelcomePageNetRespondBean;
// 用户自动登录
@property (nonatomic, readwrite, strong) UserLoggedInfo *userLoggedInfo;
@end




@implementation SoftwareUpdateNetRespondBean
 
-(void) setValue:(id)value forKey:(NSString *)key{
  
  
  if([key isEqualToString:k_BroadcastMessage_RespondKey_broadcastmessage]) {
    self.broadcastMessageReapondBean = [[BroadcastMessageNetReapondBean alloc] initWithDictionary:value];
    
  } else if([key isEqualToString:k_AdImage_RespondKey_image]) {
    self.adImageInWelcomePageNetRespondBean = [[AdImageInWelcomePageNetRespondBean alloc] initWithDictionary:value];
    
  } else if([key isEqualToString:k_AutoLogin_RespondKey_autoLogin]) {
    NSString *isAutoLogin = [value safeStringObjectForKey:k_AutoLogin_RespondKey_isAutoLogin withDefaultValue:@"false"];
    
    if ([isAutoLogin isEqualToString:@"true"]) {
      self.userLoggedInfo = [[UserLoggedInfo alloc] initWithDictionary:value];
    }

  } else if([key isEqualToString:k_BatchCodeInfo_RespondKey_currentBatchCode]) {
    for (NSString *lotteryCode in [value allKeys]) {
			NSDictionary *jsonDictionaryForBatchCodeInfo = [value objectForKey:lotteryCode];

			LotteryIssueInfo *lotteryIssueInfo = [[LotteryIssueInfo alloc] initWithDictionary:jsonDictionaryForBatchCodeInfo];
			
			[self.lotteryCurrentIssueMap setObject:lotteryIssueInfo forKey:lotteryCode];
		}
    
  } else {
    [super setValue:value forKey:key];
  }
}


#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  self = [super init];
  if (self) {
    // Initialization code here.
    self.lotteryCurrentIssueMap = [NSMutableDictionary dictionary];
  }
  
  return self;
}

- (NSString *)description {
  return descriptionForDebug(self);
}
@end
