//
//  SoftwareUpdateParseDomainBeanToDD.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateParseDomainBeanToDD.h"

#import "SoftwareUpdateDatabaseFieldsConstant.h"
#import "SoftwareUpdateNetRequestBean.h"

#import "MacroConstantForNetRequestCommand.h"
#import "MacroConstantForNetRequestType.h"


@implementation SoftwareUpdateParseDomainBeanToDD

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean {
  NSAssert(netRequestDomainBean != nil, @"入参为空 !");
  
  do {
    if (! [netRequestDomainBean isMemberOfClass:[SoftwareUpdateNetRequestBean class]]) {
      NSAssert(NO, @"传入的业务Bean的类型不符 !");
      break;
    }
    
    const SoftwareUpdateNetRequestBean *requestBean = netRequestDomainBean;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
		
		NSString *value = nil;
		
    /// 必须参数
		//
    [params setObject:k_NetRequestCommand_softwareupdate forKey:k_NetRequestCommand_key];
 
		//随机数 (可选)
		value = requestBean.randomNumber;
		if (![NSString isEmpty:value]) {
      [params setObject:value forKey:k_SoftwareUpdate_RequestKey_randomNumber];
		}
		
		//是模拟器 (可选)
		if (requestBean.isEmulator != nil) {
			if (requestBean.isEmulator) {
				value = @"true";
			} else {
				value = @"false";
			}
			[params setObject:value forKey:k_SoftwareUpdate_RequestKey_isemulator];
		}
		
    return params;
  } while (NO);
  
  return nil;
}
@end