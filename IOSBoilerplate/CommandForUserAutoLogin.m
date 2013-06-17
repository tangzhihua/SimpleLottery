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
  if (!self.isExecuted) {
		self.isExecuted = YES;
		
    [self userAutoLoginRequest];
  }
}

#pragma mark -
#pragma mark 单例方法群

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
    _isExecuted = NO;
		_netRequestIndexForUserLogin = NETWORK_REQUEST_ID_OF_IDLE;
  }
  
  return self;
}

+(id)commandForUserAutoLogin {
	
  static CommandForUserAutoLogin *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}


#pragma mark -
#pragma mark 用户自动登录

//
- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_UserLogin == requestEvent) {
    _netRequestIndexForUserLogin = NETWORK_REQUEST_ID_OF_IDLE;
  }
}

-(void)userAutoLoginRequest{
  [GlobalDataCacheForNeedSaveToFileSystem readUserLoginInfoToGlobalDataCacheForMemorySingleton];
  
  do {
    if (![GlobalDataCacheForMemorySingleton sharedInstance].isNeedAutologin) {
      break;
    }
    
    NSString *username = [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon;
    NSString *password = [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon;
    if ([NSString isEmpty:username] || [NSString isEmpty:password]) {
      username = @"18610013076";
			password = @"111111";
			[GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon = username;
			[GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon = password;
    }
		
		
    LogonNetRequestBean *netRequestBean
    = [LogonNetRequestBean logonNetRequestBeanWithPhonenum:@"18610013076" password:@"111111" isAutoLogin:YES];
    
    self.netRequestIndexForUserLogin
    = [[DomainBeanNetworkEngineSingleton sharedInstance] requestDomainProtocolWithRequestDomainBean:netRequestBean requestEvent:kNetRequestTagEnum_UserLogin successedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, id respondDomainBean) {
			[self clearNetRequestIndexByRequestEvent:requestEvent];
			
			if (requestEvent == kNetRequestTagEnum_UserLogin) {
				PRPLog(@"自动登录成功!");
				
				UserLoggedInfo *userLoggedInfo = (UserLoggedInfo *) respondDomainBean;
				PRPLog(@"%@", userLoggedInfo);
				
				// 如果 全局变量缓存区中已经有 "用户登录网络响应业务Bean", 证明用户再次登录了, 启动App时的自动登录不能覆盖用户自己登录的账户信息
				if ([GlobalDataCacheForMemorySingleton sharedInstance].userLoggedInfo == nil) {
					
					
					// 保存用户成功登录后的信息
					
					NSString *username = [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon;
					NSString *password = [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon;
					[ToolsFunctionForThisProgect noteLogonSuccessfulInfoWithUserLoggedInfo:userLoggedInfo usernameForLastSuccessfulLogon:username passwordForLastSuccessfulLogon:password];
					
					
				}
				
			}
			
		} failedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, NetRequestErrorBean *error) {
			[self clearNetRequestIndexByRequestEvent:requestEvent];
		}];
		
		
  } while (NO);
}




@end
