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
    
    id jsonRootNSDictionary = [netRespondString objectFromJSONString];
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      PRPLog(@"%@-> json 解析失败!");
      break;
    }
    
		SoftwareUpdateNetRespondBean *netRespondBean =  [[SoftwareUpdateNetRespondBean alloc] initWithDictionary:jsonRootNSDictionary];
		return netRespondBean;
	} while (NO);
  
  return nil;
}

@end