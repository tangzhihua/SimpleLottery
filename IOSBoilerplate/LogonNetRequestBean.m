//
//  LogonNetRequestBean.m
//  airizu
//
//  Created by 唐志华 on 13-1-1.
//
//

#import "LogonNetRequestBean.h"
 

@implementation LogonNetRequestBean

- (id) initWithPhonenum:(NSString *)phonenum password:(NSString *)password isAutoLogin:(BOOL)isAutoLogin {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _phonenum = [phonenum copy];
    _password = [password copy];
    _isAutoLogin = isAutoLogin;
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)logonNetRequestBeanWithPhonenum:(NSString *)phonenum password:(NSString *)password isAutoLogin:(BOOL)isAutoLogin {
  return [[LogonNetRequestBean alloc] initWithPhonenum:phonenum password:password isAutoLogin:isAutoLogin];
}

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  RNAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (NSString *)description {
	return descriptionForDebug(self);
}
@end