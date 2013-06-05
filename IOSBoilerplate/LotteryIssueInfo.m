//
//  LotteryBatchCodeInfo.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "LotteryIssueInfo.h"
#import "SoftwareUpdateDatabaseFieldsConstant.h"

@interface LotteryIssueInfo ()
// 提示信息
@property (nonatomic, readwrite, strong) NSString *message;
// 期号 如：2012557、2012153
@property (nonatomic, readwrite, strong) NSNumber *batchcode;
//
@property (nonatomic, readwrite, strong) NSNumber *syscurrenttime;
//
@property (nonatomic, readwrite, strong) NSString *starttime;
// 投注截止时间 如：12-07-16 20:59、12-07-18 22:00
@property (nonatomic, readwrite, strong) NSString *endtime;
// 期结剩余时间	单位：秒
@property (nonatomic, readwrite, strong) NSNumber *time_remaining;
@end

@implementation LotteryIssueInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if([key isEqualToString:k_BatchCodeInfo_RespondKey_batchCode]) {
    self.batchcode = value;
  } else if([key isEqualToString:k_BatchCodeInfo_RespondKey_endTime]) {
    self.endtime = value;
  } else if([key isEqualToString:k_BatchCodeInfo_RespondKey_endSecond]) {
    self.time_remaining = value;
  } else {
    [super setValue:value forUndefinedKey:key];
  }
}

- (NSString *)description {
  return descriptionForDebug(self);
}

@end
