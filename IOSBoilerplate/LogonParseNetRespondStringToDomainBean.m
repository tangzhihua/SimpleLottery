//
//  LogonParseNetRespondStringToDomainBean.m
//  airizu
//
//  Created by 唐志华 on 13-1-1.
//
//

#import "LogonParseNetRespondStringToDomainBean.h"

#import "LogonDatabaseFieldsConstant.h"
 
#import "UserLoggedInfo.h"

#import "JSONKit.h"
 
#import "NSDictionary+SafeValue.h"

@implementation LogonParseNetRespondStringToDomainBean
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 IParseNetRespondStringToDomainBean 接口
- (id) parseNetRespondStringToDomainBean:(in NSString *) netRespondString {
  do {
    if ([NSString isEmpty:netRespondString]) {
      PRPLog(@"%@-> 入参 netRespondString 为空 !");
      break;
    }
    
		const char *jsonStringForUTF8 = [netRespondString UTF8String];
		NSError *error = [[NSError alloc] init];
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSDictionary *jsonRootNSDictionary
    = [jsonDecoder objectWithUTF8String:(const unsigned char *)jsonStringForUTF8
                                 length:(unsigned int)strlen(jsonStringForUTF8)];
    jsonDecoder = nil;
		error = nil;
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      PRPLog(@"%@-> json 解析失败!");
      break;
    }
    
		/*
    // 关键数据字段检测
    NSString *defaultValueForString = @"";
    
    NSString *message
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_message
                                  withDefaultValue:defaultValueForString];
		NSString *userno
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_userno
                                  withDefaultValue:defaultValueForString];
		NSString *certid
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_certid
                                  withDefaultValue:defaultValueForString];
		NSString *mobileid
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_mobileid
                                  withDefaultValue:defaultValueForString];
    NSString *name
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_name
                                  withDefaultValue:defaultValueForString];
		NSString *userName
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_userName
                                  withDefaultValue:defaultValueForString];
		NSString *sessionid
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_sessionid
                                  withDefaultValue:defaultValueForString];
		NSString *randomNumber
    = [jsonRootNSDictionary safeStringObjectForKey:k_Login_RespondKey_randomNumber
                                  withDefaultValue:defaultValueForString];
		
		UserLoggedInfo *userLoggedInfo = [UserLoggedInfo userLoggedInfoWithMessage:message userno:userno certid:certid mobileid:mobileid name:name userName:userName sessionid:sessionid randomNumber:randomNumber];
    */
    
    UserLoggedInfo *userLoggedInfo = [[UserLoggedInfo alloc] initWithDictionary:jsonRootNSDictionary];
    return userLoggedInfo;
  } while (NO);
  
  return nil;
}

@end