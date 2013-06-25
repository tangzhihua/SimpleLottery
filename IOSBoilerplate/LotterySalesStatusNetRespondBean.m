//
//  TodayOpenPrizeNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import "LotterySalesStatusNetRespondBean.h"
#import "NSDictionary+SafeValue.h"
#import "GlobalDataCacheForMemorySingleton.h"
#import "LotteryDictionary.h"
#import "LotterySalesStatus.h"
#import "LotterySalesStatusNetRespondBean.h"
#import "LotterySalesStatusDatabaseFieldsConstant.h"



@interface LotterySalesStatusNetRespondBean()
// 正在进行的活动数量
@property (nonatomic, readwrite, assign) NSInteger inProgressActivityCount;

// 彩票销售状态 列表
@property (nonatomic, readwrite, strong) NSMutableDictionary *lotterySaleInformationMap;
@end





@implementation LotterySalesStatusNetRespondBean
-(NSMutableDictionary *)lotterySaleInformationMap{
  if (_lotterySaleInformationMap == nil) {
    _lotterySaleInformationMap = [[NSMutableDictionary alloc] initWithCapacity:20];
  }
  return _lotterySaleInformationMap;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  
  
  NSString *defaultValueForString = @"";
  
  NSString *isSaleString
  = [value safeStringObjectForKey:k_LotterySalesStatus_RespondKey_isSale
                 withDefaultValue:defaultValueForString];
  BOOL isSaleBool = NO;
  if ([NSString isEmpty:isSaleString] || [isSaleString isEqualToString:@"true"]) {
    isSaleBool = YES;
  }
  LotteryOpenPrizeStatusEnum lotteryOpenPrizeStatusEnum = kLotteryOpenPrizeStatusEnum_NONE;
  if (isSaleBool) {
    NSString *isTodayOpenPrizeString
    = [value safeStringObjectForKey:k_LotterySalesStatus_RespondKey_isTodayOpenPrize
                   withDefaultValue:defaultValueForString];
    BOOL isTodayOpenPrizeBool = NO;
    if ([isTodayOpenPrizeString isEqualToString:@"true"]) {
      isTodayOpenPrizeBool = YES;
    }
    NSString *isAddAwardString
    = [value safeStringObjectForKey:k_LotterySalesStatus_RespondKey_isAddAward
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
  
  [self.lotterySaleInformationMap setObject:lotterySalesStatus forKey:key];
}

- (NSString *)description {
  return descriptionForDebug(self);
}
@end
