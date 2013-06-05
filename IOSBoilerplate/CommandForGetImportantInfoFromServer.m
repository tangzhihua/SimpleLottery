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
static CommandForGetImportantInfoFromServer *singletonInstance = nil;










@interface CommandForGetImportantInfoFromServer ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
// 从服务器获取重要的信息
@property (nonatomic, assign) NSInteger netRequestIndexForGetImportantInfoFromServer;
@end










@implementation CommandForGetImportantInfoFromServer {
	AFImageRequestOperation *_adImageRequestOperation;
}

//
typedef NS_ENUM(NSInteger, NetRequestTagEnum) {
  // 从服务器获取重要的信息
  kNetRequestTagEnum_GetImportantInfoFromServer
};

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  if (!_isExecuted) {
		_isExecuted = YES;
		
    [self importantInfoFromServerRequest];
  }
}

+(id)commandForGetImportantInfoFromServer {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandForGetImportantInfoFromServer alloc] init];
    singletonInstance.isExecuted = NO;
    singletonInstance.netRequestIndexForGetImportantInfoFromServer = IDLE_NETWORK_REQUEST_ID;
  }
  return singletonInstance;
}

#pragma mark -
#pragma mark 用户自动登录

-(void)importantInfoFromServerRequest{
  
  
  do {
    
		// 读取用户登录相关信息(用户名 + 密码 + 自动登录开关 + RandomNumber)
		[GlobalDataCacheForNeedSaveToFileSystem readUserLoginInfoToGlobalDataCacheForMemorySingleton];
		
		SoftwareUpdateNetRequestBean *softwareUpdateNetRequestBean = [SoftwareUpdateNetRequestBean softwareUpdateNetRequestBeanWithRandomNumber:[GlobalDataCacheForMemorySingleton sharedInstance].randomNumberForLastSuccessfulLogon isEmulator:nil];
		
    _netRequestIndexForGetImportantInfoFromServer
    = [[DomainProtocolNetHelperSingleton sharedInstance] requestDomainProtocolWithContext:self
                                                                     andRequestDomainBean:softwareUpdateNetRequestBean
                                                                          andRequestEvent:kNetRequestTagEnum_GetImportantInfoFromServer
                                                                       andRespondDelegate:self];
		
		
  } while (NO);
}

#pragma mark -
#pragma mark 实现 IDomainNetRespondCallback 接口

//
- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_GetImportantInfoFromServer == requestEvent) {
    _netRequestIndexForGetImportantInfoFromServer = IDLE_NETWORK_REQUEST_ID;
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
  
  if (requestEvent == kNetRequestTagEnum_GetImportantInfoFromServer) {
    
    
    SoftwareUpdateNetRespondBean *softwareUpdateNetRespondBean = (SoftwareUpdateNetRespondBean *) respondDomainBean;
    PRPLog(@"%@", softwareUpdateNetRespondBean);
    [GlobalDataCacheForMemorySingleton sharedInstance].softwareUpdateNetRespondBean = softwareUpdateNetRespondBean;
		
		
		// 用户自动登录
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
			
		  if (adImageInWelcomePageNetRespondBean.isShowAdImageFromServer) {
				if (![NSString isEmpty:adImageInWelcomePageNetRespondBean.imageUrl]
						&& ![NSString isEmpty:adImageInWelcomePageNetRespondBean.imageID]
						&& ![adImageInWelcomePageNetRespondBean.imageID isEqualToString:[GlobalDataCacheForMemorySingleton sharedInstance].adImageIDForLatest]) {
					
					// 要从服务器下载广告图片
					NSURL *url = [NSURL URLWithString:adImageInWelcomePageNetRespondBean.imageUrl];
					
					//Store this image on the same server as the weather canned files
					NSURLRequest *request = [NSURLRequest requestWithURL:url];
					
					_adImageRequestOperation
					
					= [AFImageRequestOperation imageRequestOperationWithRequest:request
																								 imageProcessingBlock:nil
																															success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
																																NSString *adImagePath = [[LocalCacheDataPathConstant importantDataCachePath] stringByAppendingPathComponent:kAdImageNameForWelcomePage];
																																
																																NSData *imageDataForPNG = UIImagePNGRepresentation(image);
																																[imageDataForPNG writeToFile:adImagePath atomically:YES];
																																
																																[GlobalDataCacheForMemorySingleton sharedInstance].adImageIDForLatest = adImageInWelcomePageNetRespondBean.imageID;
																															}
																															failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
																																PRPLog(@"下载开机广告图片失败, error=%@", error);
																															}];
					[_adImageRequestOperation start];
					
				}
			}
		}
		
		
    // 发送 从服务器获取重要信息成功
    Intent *intent = [Intent intent];
    [intent setAction:[[NSNumber numberWithUnsignedInteger:kUserNotificationEnum_GetImportantInfoFromServerSuccess] stringValue]];
    [self sendBroadcast:intent];
    
  }
  
}

@end