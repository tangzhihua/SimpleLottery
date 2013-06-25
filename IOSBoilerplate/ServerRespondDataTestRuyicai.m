//
//  ServerRespondDataTestRuyicaiNew.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-9.
//
//

#import "ServerRespondDataTestRuyicai.h"
#import "NetRequestErrorBean.h"
#import "JSONKit.h"
#import "NSDictionary+SafeValue.h"

@implementation ServerRespondDataTestRuyicai
#pragma mark 实现 IServerRespondDataTest 接口
- (NetRequestErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String {
  NSInteger errorCode = 200;
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
		}
  }
  
  NetRequestErrorBean *netError = [[NetRequestErrorBean alloc] init];
  netError.errorCode = errorCode;
  netError.message = errorMessage;
  return netError;
  
}
@end
