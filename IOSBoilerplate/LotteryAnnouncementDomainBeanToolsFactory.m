//
//  LotteryAnnouncementDomainBeanToolsFactory.m
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "LotteryAnnouncementDomainBeanToolsFactory.h"

#import "LotteryAnnouncementParseDomainBeanToDD.h"

#import "LotteryAnnouncementNetRespondBean.h"
@implementation LotteryAnnouncementDomainBeanToolsFactory
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

/**
 * 将当前业务Bean, 解析成跟后台数据接口对应的数据字典
 * @return
 */
- (id<IParseDomainBeanToDataDictionary>) getParseDomainBeanToDDStrategy {
  return [[LotteryAnnouncementParseDomainBeanToDD alloc] init];
}

/**
 * 将网络返回的数据字符串, 解析成当前业务Bean
 * @return
 */
- (id<IParseNetRespondStringToDomainBean>) getParseNetRespondStringToDomainBeanStrategy {
  return nil;
}

/**
 * 当前业务Bean, 对应的URL地址.
 * @return
 */
- (NSString *) getURL {
  return nil;
}

/**
 * 当前网络响应业务Bean的Class
 * @return
 */
- (Class) getClassOfNetRespondBean {
  return [LotteryAnnouncementNetRespondBean class];
}
@end
