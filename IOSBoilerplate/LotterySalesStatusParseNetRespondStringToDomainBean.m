//
//  TodayOpenPrizeParseNetRespondStringToDomainBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import "LotterySalesStatusParseNetRespondStringToDomainBean.h"

#import "LotterySalesStatusDatabaseFieldsConstant.h"

#import "JSONKit.h"

#import "NSDictionary+SafeValue.h"
#import "GlobalDataCacheForMemorySingleton.h"
#import "LotteryDictionary.h"
#import "LotterySalesStatus.h"
#import "LotterySalesStatusNetRespondBean.h"

@implementation LotterySalesStatusParseNetRespondStringToDomainBean
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
     
		return [[LotterySalesStatusNetRespondBean alloc] initWithDictionary:jsonRootNSDictionary];
  } while (NO);
  
  return nil;
}

@end
