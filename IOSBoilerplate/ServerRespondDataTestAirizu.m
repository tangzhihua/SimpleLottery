//
//  ServerRespondDataTestAirizu.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "ServerRespondDataTestAirizu.h"

 
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
- (NetRequestErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String {
  NSInteger errorCode = 200;
  
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
     
  }
  
  NetRequestErrorBean *netError = [[NetRequestErrorBean alloc] init];
  netError.errorCode = errorCode;
  netError.message = errorMessage;
  return netError;
}
@end
