//
//  LotteryBatchCodeInfo.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface LotteryIssueInfo : JSONModel

// 提示信息
@property (nonatomic, readonly, strong) NSString *message;
// 期号 如：2012557、2012153
@property (nonatomic, readonly, strong) NSNumber *batchcode;
//
@property (nonatomic, readonly, strong) NSNumber *syscurrenttime;
//
@property (nonatomic, readonly, strong) NSString *starttime;
// 投注截止时间 如：12-07-16 20:59、12-07-18 22:00
@property (nonatomic, readonly, strong) NSString *endtime;
// 期结剩余时间	单位：秒
@property (nonatomic, readonly, strong) NSNumber *time_remaining;

@end
