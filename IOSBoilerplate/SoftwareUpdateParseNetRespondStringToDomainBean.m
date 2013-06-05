//
//  SoftwareUpdateParseNetRespondStringToDomainBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateParseNetRespondStringToDomainBean.h"

#import "SoftwareUpdateDatabaseFieldsConstant.h"
#import "SoftwareUpdateNetRespondBean.h"

#import "JSONKit.h"

#import "NSDictionary+SafeValue.h"

#import "BroadcastMessageNetReapondBean.h"
#import "LotteryIssueInfo.h"
 
#import "UserLoggedInfo.h"
#import "AdImageInWelcomePageNetRespondBean.h"

@implementation SoftwareUpdateParseNetRespondStringToDomainBean
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
    
		return [[SoftwareUpdateNetRespondBean alloc] initWithDictionary:jsonRootNSDictionary];
	} while (NO);
  
  return nil;
}

@end