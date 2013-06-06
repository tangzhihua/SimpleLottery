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
    
		id jsonRootNSDictionary = [netRespondString objectFromJSONString];
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      PRPLog(@"%@-> json 解析失败!");
      break;
    }
    
    UserLoggedInfo *userLoggedInfo = [[UserLoggedInfo alloc] initWithDictionary:jsonRootNSDictionary];
    return userLoggedInfo;
  } while (NO);
  
  return nil;
}

@end