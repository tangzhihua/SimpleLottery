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
    
		
    // 关键数据字段检测
    NSNumber *defaultValueForNumber = [NSNumber numberWithBool:NO];
		NSString *defaultValueForString = @"";
		
    NSNumber *inProgressActivityCount
    = [jsonRootNSDictionary safeNumberObjectForKey:k_LotterySalesStatus_RespondKey_inProgressActivityCount
                                  withDefaultValue:defaultValueForNumber];

		NSMutableDictionary *lotterySaleInformationMap = [NSMutableDictionary dictionaryWithCapacity:20];
		
		NSArray *keysOfRootNSDictionary = [jsonRootNSDictionary allKeys];
		for (NSString *key in keysOfRootNSDictionary) {
			NSDictionary *jsonDictionaryForLotterySalesStatus = [jsonRootNSDictionary safeDictionaryObjectForKey:key];
			if (jsonDictionaryForLotterySalesStatus != nil) {
				NSString *isSaleString
				= [jsonDictionaryForLotterySalesStatus safeStringObjectForKey:k_LotterySalesStatus_RespondKey_isSale
																										 withDefaultValue:defaultValueForString];
				BOOL isSaleBool = NO;
				if ([NSString isEmpty:isSaleString] || [isSaleString isEqualToString:@"true"]) {
					isSaleBool = YES;
				}
				LotteryOpenPrizeStatusEnum lotteryOpenPrizeStatusEnum = kLotteryOpenPrizeStatusEnum_NONE;
				if (isSaleBool) {
					NSString *isTodayOpenPrizeString
					= [jsonDictionaryForLotterySalesStatus safeStringObjectForKey:k_LotterySalesStatus_RespondKey_isTodayOpenPrize
																											 withDefaultValue:defaultValueForString];
					BOOL isTodayOpenPrizeBool = NO;
					if ([isTodayOpenPrizeString isEqualToString:@"true"]) {
						isTodayOpenPrizeBool = YES;
					}
					NSString *isAddAwardString
					= [jsonDictionaryForLotterySalesStatus safeStringObjectForKey:k_LotterySalesStatus_RespondKey_isAddAward
																											 withDefaultValue:defaultValueForString];
					BOOL isAddAwardBool = NO;
					if ([isAddAwardString isEqualToString:@"true"]) {
						isAddAwardBool = YES;
					}
					
					if (isTodayOpenPrizeBool && isAddAwardBool) {
						lotteryOpenPrizeStatusEnum = kLotteryOpenPrizeStatusEnum_TodayOpenPrizeAndAddAward;
					} else if (isTodayOpenPrizeBool) {
						lotteryOpenPrizeStatusEnum = kLotteryOpenPrizeStatusEnum_TodayOpenPrize;
					} else if (isAddAwardBool) {
						lotteryOpenPrizeStatusEnum = kLotteryOpenPrizeStatusEnum_TodayAddAward;
					}
				}
				
				LotterySalesStatus *lotterySalesStatus = [LotterySalesStatus lotterySalesStatusWithIsSale:isSaleBool lotteryOpenPrizeStatusEnum:lotteryOpenPrizeStatusEnum];
				
				[lotterySaleInformationMap setObject:lotterySalesStatus forKey:key];
			}
		}
    
		
		return [LotterySalesStatusNetRespondBean lotterySalesStatusNetRespondBeanWithInProgressActivityCount:inProgressActivityCount lotterySaleInformationMap:lotterySaleInformationMap];
  } while (NO);
  
  return nil;
}

@end
