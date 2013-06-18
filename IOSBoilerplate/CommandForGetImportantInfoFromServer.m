//
//  CommandForGetImportantInfoFromServer.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "CommandForGetImportantInfoFromServer.h"

#import "GlobalDataCacheForMemorySingleton.h"
#import "GlobalDataCacheForNeedSaveToFileSystem.h"



#import "SoftwareUpdateNetRequestBean.h"
#import "SoftwareUpdateNetRespondBean.h"
#import "UserLoggedInfo.h"

#import "AdImageInWelcomePageNetRespondBean.h"

#import "LocalCacheDataPathConstant.h"

#import "MKNetworkEngineSingleton.h"






@interface CommandForGetImportantInfoFromServer ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
// 从服务器获取重要的信息
@property (nonatomic, assign) NSInteger netRequestIndexForGetImportantInfoFromServer;

//
@property (nonatomic, weak) MKNetworkOperation *adImageDownloadOperation;
@end










@implementation CommandForGetImportantInfoFromServer

//
typedef NS_ENUM(NSInteger, NetRequestTagEnum) {
  // 从服务器获取重要的信息
  kNetRequestTagEnum_GetImportantInfoFromServer
};

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  if (!self.isExecuted) {
		self.isExecuted = YES;
		
    [self importantInfoFromServerRequest];
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
		_netRequestIndexForGetImportantInfoFromServer = NETWORK_REQUEST_ID_OF_IDLE;
  }
  
  return self;
}

+(id)commandForGetImportantInfoFromServer {
	
  static CommandForGetImportantInfoFromServer *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark 用户自动登录

//
- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_GetImportantInfoFromServer == requestEvent) {
    _netRequestIndexForGetImportantInfoFromServer = NETWORK_REQUEST_ID_OF_IDLE;
  }
}

-(void)importantInfoFromServerRequest{
  
  
  do {
    
		// 读取用户登录相关信息(用户名 + 密码 + 自动登录开关 + RandomNumber)
		[GlobalDataCacheForNeedSaveToFileSystem readUserLoginInfoToGlobalDataCacheForMemorySingleton];
		
		SoftwareUpdateNetRequestBean *netRequestBean = [SoftwareUpdateNetRequestBean softwareUpdateNetRequestBeanWithRandomNumber:[GlobalDataCacheForMemorySingleton sharedInstance].randomNumberForLastSuccessfulLogon isEmulator:nil];
		
    self.netRequestIndexForGetImportantInfoFromServer
    = [[DomainBeanNetworkEngineSingleton sharedInstance] requestDomainProtocolWithRequestDomainBean:netRequestBean requestEvent:kNetRequestTagEnum_GetImportantInfoFromServer successedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, id respondDomainBean) {
			
			[self clearNetRequestIndexByRequestEvent:requestEvent];
			
			SoftwareUpdateNetRespondBean *softwareUpdateNetRespondBean = (SoftwareUpdateNetRespondBean *) respondDomainBean;
			PRPLog(@"%@", softwareUpdateNetRespondBean);
			[GlobalDataCacheForMemorySingleton sharedInstance].softwareUpdateNetRespondBean = softwareUpdateNetRespondBean;
			
			
			// 用户自动登录检测
			if (softwareUpdateNetRespondBean.userLoggedInfo != nil) {
				NSString *username = [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon;
				NSString *password = [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon;
				[ToolsFunctionForThisProgect noteLogonSuccessfulInfoWithUserLoggedInfo:softwareUpdateNetRespondBean.userLoggedInfo usernameForLastSuccessfulLogon:username passwordForLastSuccessfulLogon:password];
				
				// 发送 用户成功登录的广播消息
				Intent *intent = [Intent intent];
				[intent setAction:[[NSNumber numberWithUnsignedInteger:kUserNotificationEnum_UserLogonSuccess] stringValue]];
				[self sendBroadcast:intent];
			}
			
			// 查看是否需要下载 欢迎界面的广告图片
			AdImageInWelcomePageNetRespondBean *adImageInWelcomePageNetRespondBean = softwareUpdateNetRespondBean.adImageInWelcomePageNetRespondBean;
			if (adImageInWelcomePageNetRespondBean != nil) {
				[GlobalDataCacheForMemorySingleton sharedInstance].isShowAdImageFromServer = adImageInWelcomePageNetRespondBean.isShowAdImageFromServer;
				
				// 判断是否需要从服务器下载新的开机广告图片
				if (adImageInWelcomePageNetRespondBean.isShowAdImageFromServer) {
					if (![NSString isEmpty:adImageInWelcomePageNetRespondBean.imageUrl]
							&& ![NSString isEmpty:adImageInWelcomePageNetRespondBean.imageID]
							&& ![adImageInWelcomePageNetRespondBean.imageID isEqualToString:[GlobalDataCacheForMemorySingleton sharedInstance].adImageIDForLatest]) {
						
						self.adImageDownloadOperation = [[MKNetworkEngineSingleton sharedInstance] operationWithURLString:adImageInWelcomePageNetRespondBean.imageUrl];
						[self.adImageDownloadOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
							NSString *adImagePath = [[LocalCacheDataPathConstant adCachePath] stringByAppendingPathComponent:kAdImageNameForWelcomePage];
							UIImage *image = [completedOperation responseImage];
							NSData *imageDataForPNG = UIImagePNGRepresentation(image);
							[imageDataForPNG writeToFile:adImagePath atomically:YES];
							
							[GlobalDataCacheForMemorySingleton sharedInstance].adImageIDForLatest = adImageInWelcomePageNetRespondBean.imageID;
						} errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
							DLog(@"下载开机广告图片失败, error=%@", error);
							
						}];
						
						[[MKNetworkEngineSingleton sharedInstance] enqueueOperation:self.adImageDownloadOperation];
					}
				}
			}
			
			
			// 发送 从服务器获取重要信息成功 的广播消息
			Intent *intent = [Intent intent];
			[intent setAction:[[NSNumber numberWithUnsignedInteger:kUserNotificationEnum_GetImportantInfoFromServerSuccess] stringValue]];
			[self sendBroadcast:intent];
			
		} failedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, NetRequestErrorBean *error) {
			[self clearNetRequestIndexByRequestEvent:requestEvent];
		}];
		
		
  } while (NO);
}





@end