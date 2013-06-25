//
//  NetRespondDataToNSDictionaryForRuyicai.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-25.
//
//

#import "NetRespondDataToNSDictionaryForRuyicai.h"
#import "JSONKit.h"
@implementation NetRespondDataToNSDictionaryForRuyicai
- (NSDictionary *) netRespondDataToNSDictionary:(in NSString *)serverRespondDataOfUTF8String {
  do {
    if ([NSString isEmpty:serverRespondDataOfUTF8String]) {
      PRPLog(@"%@-> 入参 serverRespondDataOfUTF8String 为空 !");
      break;
    }
    
    id jsonRootNSDictionary = [serverRespondDataOfUTF8String objectFromJSONString];
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      PRPLog(@"%@-> json 解析失败!");
      break;
    }
    
		return jsonRootNSDictionary;
	} while (NO);
  
  return nil;
}
@end
