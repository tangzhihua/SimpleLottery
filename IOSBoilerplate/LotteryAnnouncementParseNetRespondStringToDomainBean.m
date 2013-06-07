//
//  LotteryAnnouncementParseNetRespondStringToDomainBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "LotteryAnnouncementParseNetRespondStringToDomainBean.h"

#import "JSONKit.h"

#import "NSDictionary+SafeValue.h"

#import "LotteryAnnouncementNetRespondBean.h"


@implementation LotteryAnnouncementParseNetRespondStringToDomainBean
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
    
		return [[LotteryAnnouncementNetRespondBean alloc] initWithDictionary:jsonRootNSDictionary];
	} while (NO);
  
  return nil;
}
@end

