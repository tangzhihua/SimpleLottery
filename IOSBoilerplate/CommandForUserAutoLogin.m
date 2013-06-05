//
//  CommandForUserAutoLogin.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForUserAutoLogin.h"

#import "GlobalDataCacheForMemorySingleton.h"
#import "GlobalDataCacheForNeedSaveToFileSystem.h"



#import "LogonNetRequestBean.h"
#import "UserLoggedInfo.h"














@interface CommandForUserAutoLogin ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
// 用户自动登录 网络请求
@property (nonatomic, assign) NSInteger netRequestIndexForUserLogin;
@end










@implementation CommandForUserAutoLogin

//
typedef NS_ENUM(NSInteger, NetRequestTagEnum) {
  // 用户登录
  kNetRequestTagEnum_UserLogin
};

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  if (!_isExecuted) {
		_isExecuted = YES;
		
    [self userAutoLoginRequest];
  }
}

static CommandForUserAutoLogin *singletonInstance = nil;
+(id)commandForUserAutoLogin {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandForUserAutoLogin alloc] init];
    singletonInstance.isExecuted = NO;
    singletonInstance.netRequestIndexForUserLogin = IDLE_NETWORK_REQUEST_ID;
  }
  return singletonInstance;
}

#pragma mark -
#pragma mark 用户自动登录

-(void)userAutoLoginRequest{
  [GlobalDataCacheForNeedSaveToFileSystem readUserLoginInfoToGlobalDataCacheForMemorySingleton];
  
  do {
    if (![GlobalDataCacheForMemorySingleton sharedInstance].isNeedAutologin) {
      break;
    }
    
    NSString *username = [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon;
    NSString *password = [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon;
    if ([NSString isEmpty:username] || [NSString isEmpty:password]) {
      //break;
    }
		
		
    LogonNetRequestBean *logonNetRequestBean
    = [LogonNetRequestBean logonNetRequestBeanWithPhonenum:@"18610013076" password:@"111111" isAutoLogin:YES];
    
    _netRequestIndexForUserLogin
    = [[DomainProtocolNetHelperSingleton sharedInstance] requestDomainProtocolWithContext:self
                                                                     andRequestDomainBean:logonNetRequestBean
                                                                          andRequestEvent:kNetRequestTagEnum_UserLogin
                                                                       andRespondDelegate:self];
		
		
  } while (NO);
}

#pragma mark -
#pragma mark 实现 IDomainNetRespondCallback 接口

//
- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_UserLogin == requestEvent) {
    _netRequestIndexForUserLogin = IDLE_NETWORK_REQUEST_ID;
  }
}

/**
 * 此方法处于非UI线程中
 *
 * @param requestEvent
 * @param errorBean
 * @param respondDomainBean
 */
- (void) domainNetRespondHandleInNonUIThread:(in NSUInteger) requestEvent
														 netRequestIndex:(in NSInteger) netRequestIndex
                                   errorBean:(in NetErrorBean *) errorBean
                           respondDomainBean:(in id) respondDomainBean {
  
  PRPLog(@"domainNetRespondHandleInNonUIThread --- start ! ");
  
  [self clearNetRequestIndexByRequestEvent:requestEvent];
  
  if (errorBean.errorType != NET_ERROR_TYPE_SUCCESS) {
    return;
  }
  
  if (requestEvent == kNetRequestTagEnum_UserLogin) {
    PRPLog(@"自动登录成功!");
    
    UserLoggedInfo *userLoggedInfo = (UserLoggedInfo *) respondDomainBean;
    PRPLog(@"%@", userLoggedInfo);
    
    // 如果 全局变量缓存区中已经有 "用户登录网络响应业务Bean", 证明用户再次登录了, 启动App时的自动登录不能覆盖用户自己登录的账户信息
    if ([GlobalDataCacheForMemorySingleton sharedInstance].userLoggedInfo == nil) {
			
			
      // 保存用户成功登录后的信息
			/*
      NSString *username = [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon;
      NSString *password = [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon;
      [ToolsFunctionForThisProgect noteLogonSuccessfulInfoWithUserLoggedInfo:userLoggedInfo usernameForLastSuccessfulLogon:@"18610013076" passwordForLastSuccessfulLogon:@"111111"];
			 */
      
    }
    
  }
  
}
@end
