//
//  ServerRespondDataTestAirizu.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "ServerRespondDataTestAirizu.h"
#import "NetErrorTypeEnum.h"
#import "NetErrorBean.h"
#import "JSONKit.h"
#import "NSDictionary+SafeValue.h"
 

static const NSString *const TAG = @"<ServerRespondDataTestAirizu>";

@implementation ServerRespondDataTestAirizu
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
	}
	
	return self;
}

- (void) dealloc {
	PRPLog(@"dealloc: %@ [0x%x]", TAG, [self hash]);
	
	 
}

#pragma mark 实现 IServerRespondDataTest 接口
- (NetErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String {
  NSInteger errorCode = 200;
  NetErrorTypeEnum errorType = NET_ERROR_TYPE_SUCCESS;
  NSString *errorMessage = @"OK";
  
  NSDictionary *jsonDataNSDictionary
  = [serverRespondDataOfUTF8String objectFromJSONString];
  
  ///
  NSString *errorCodeFromServer = [jsonDataNSDictionary safeStringObjectForKey:@"errorcode"];
  NSString *errorMessageFromServer = [jsonDataNSDictionary safeStringObjectForKey:@"errordes"];
  if (![NSString isEmpty:errorCodeFromServer]) {
    
    errorCode = [errorCodeFromServer integerValue];
    
    if (![NSString isEmpty:errorMessageFromServer]) {
      errorMessage = errorMessageFromServer;
    }
    
    // 服务器端返回了错误码
    errorType = NET_ERROR_TYPE_SERVER_NET_ERROR;
  }
  
  NetErrorBean *netError = [NetErrorBean netErrorBean];
  [netError setErrorCode:errorCode];
  [netError setErrorType:errorType];
  [netError setErrorMessage:errorMessage];
  return netError;
}
@end
