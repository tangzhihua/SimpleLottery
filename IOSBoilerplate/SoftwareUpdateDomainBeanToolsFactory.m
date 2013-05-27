//
//  SoftwareUpdateDomainBeanToolsFactory.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateDomainBeanToolsFactory.h"

 
#import "SoftwareUpdateParseDomainBeanToDD.h"
#import "SoftwareUpdateParseNetRespondStringToDomainBean.h"

@implementation SoftwareUpdateDomainBeanToolsFactory
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
  return [[SoftwareUpdateParseDomainBeanToDD alloc] init];
}

/**
 * 将网络返回的数据字符串, 解析成当前业务Bean
 * @return
 */
- (id<IParseNetRespondStringToDomainBean>) getParseNetRespondStringToDomainBeanStrategy {
  return [[SoftwareUpdateParseNetRespondStringToDomainBean alloc] init];
}

/**
 * 当前业务Bean, 对应的URL地址.
 * @return
 */
- (NSString *) getURL {
  return nil;
}
@end
