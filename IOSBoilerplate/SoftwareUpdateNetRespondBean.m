//
//  SoftwareUpdateNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateNetRespondBean.h"

@implementation SoftwareUpdateNetRespondBean
-(id)initWithNews:(NSString *)news
			 noticetime:(NSNumber *)noticetime
broadcastMessageReapondBean:(BroadcastMessageNetReapondBean *)broadcastMessageReapondBean
lotteryCurrentBatchCodeNetRespondBean:(LotteryCurrentIssueNetRespondBean *)lotteryCurrentIssueNetRespondBean
adImageInWelcomePageNetRespondBean:(AdImageInWelcomePageNetRespondBean *)adImageInWelcomePageNetRespondBean
	 userLoggedInfo:(UserLoggedInfo *)userLoggedInfo {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _news = [news copy];
		_noticetime = [noticetime copy];
		
		//
		_broadcastMessageReapondBean = broadcastMessageReapondBean;
		//
		_lotteryCurrentIssueNetRespondBean = lotteryCurrentIssueNetRespondBean;
		//
		_adImageInWelcomePageNetRespondBean = adImageInWelcomePageNetRespondBean;
		//
		_userLoggedInfo = userLoggedInfo;
	}
  
  return self;
}


+(id)softwareUpdateNetRespondBeanWithNews:(NSString *)news
															 noticetime:(NSNumber *)noticetime
							broadcastMessageReapondBean:(BroadcastMessageNetReapondBean *)broadcastMessageReapondBean
		lotteryCurrentBatchCodeNetRespondBean:(LotteryCurrentIssueNetRespondBean *)lotteryCurrentIssueNetRespondBean
			 adImageInWelcomePageNetRespondBean:(AdImageInWelcomePageNetRespondBean *)adImageInWelcomePageNetRespondBean
													 userLoggedInfo:(UserLoggedInfo *)userLoggedInfo {
	
	return  [[SoftwareUpdateNetRespondBean alloc] initWithNews:news noticetime:noticetime broadcastMessageReapondBean:broadcastMessageReapondBean lotteryCurrentBatchCodeNetRespondBean:lotteryCurrentIssueNetRespondBean adImageInWelcomePageNetRespondBean:adImageInWelcomePageNetRespondBean userLoggedInfo:userLoggedInfo];
}



#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (NSString *)description {
  return descriptionForDebug(self);
}
@end
