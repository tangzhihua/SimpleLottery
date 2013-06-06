//
//  ServerRespondDataTestRuyicai.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import "ServerRespondDataTestRuyicai.h"
#import "NetErrorTypeEnum.h"
#import "NetErrorBean.h"
#import "JSONKit.h"
#import "NSDictionary+SafeValue.h"
 

static const NSString *const TAG = @"<ServerRespondDataTestAirizu>";

@implementation ServerRespondDataTestRuyicai
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 IServerRespondDataTest 接口
- (NetErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String {
  NSInteger errorCode = 200;
  NetErrorTypeEnum errorType = NET_ERROR_TYPE_SUCCESS;
  NSString *errorMessage = @"OK";
  
  ///
  id jsonDataNSDictionary = [serverRespondDataOfUTF8String objectFromJSONString];
  
  ///
  NSString *errorCodeFromServer = [jsonDataNSDictionary safeStringObjectForKey:@"error_code"];

  if (![NSString isEmpty:errorCodeFromServer]) {
    
		if ([errorCodeFromServer isEqualToString:@"0000"] || [errorCodeFromServer isEqualToString:@"000000"]) {
			// 服务器返回的数据有效
			errorCode = 200;
		} else {
			// 服务器返回的数据无效
			errorCode = [errorCodeFromServer integerValue];
			errorMessage = errorCodeFromServer;
			// 服务器端返回了错误码
			errorType = NET_ERROR_TYPE_SERVER_NET_ERROR;
		}
  }
  
  NetErrorBean *netError = [NetErrorBean netErrorBean];
  [netError setErrorCode:errorCode];
  [netError setErrorType:errorType];
  [netError setErrorMessage:errorMessage];
  return netError;
}
@end