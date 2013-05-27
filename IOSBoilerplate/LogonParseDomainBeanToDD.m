//
//  LogonParseDomainBeanToDD.m
//  airizu
//
//  Created by 唐志华 on 13-1-1.
//
//

#import "LogonParseDomainBeanToDD.h"

#import "LogonDatabaseFieldsConstant.h"
#import "LogonNetRequestBean.h"

#import "MacroConstantForNetRequestCommand.h"
#import "MacroConstantForNetRequestType.h"
 

@implementation LogonParseDomainBeanToDD

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean {
  NSAssert(netRequestDomainBean != nil, @"入参为空 !");
  
  do {
    if (! [netRequestDomainBean isMemberOfClass:[LogonNetRequestBean class]]) {
      NSAssert(NO, @"传入的业务Bean的类型不符 !");
      break;
    }
    
    const LogonNetRequestBean *requestBean = netRequestDomainBean;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
		
		NSString *value = nil;
		
    /// 必须参数
		//
    [params setObject:k_NetRequestCommand_login forKey:k_NetRequestCommand_key];
		
		//
		value = requestBean.phonenum;
		if ([NSString isEmpty:value]) {
      NSAssert(NO, @"丢失关键参数 : phonenum");
      break;
		}
		[params setObject:value forKey:k_Login_RequestKey_phonenum];
    //
    value = requestBean.password;
		if ([NSString isEmpty:value]) {
      NSAssert(NO, @"丢失关键参数 : password");
      break;
		}
    [params setObject:value forKey:k_Login_RequestKey_password];
    //
		NSInteger valueForAutoLoginMark = [[NSNumber numberWithBool:requestBean.isAutoLogin] integerValue];
    value = [NSString stringWithFormat:@"%d", valueForAutoLoginMark];
    [params setObject:value forKey:k_Login_RequestKey_isAutoLogin];
    
		
    
    return params;
  } while (NO);
  
  return nil;
}
@end