//
//  LotteryAnnouncement.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "JSONModel.h"

@interface LotteryAnnouncement : JSONModel
// 期号
@property (nonatomic, readonly, strong) NSString *batchCode;
// 开奖号码
@property (nonatomic, readonly, strong) NSString *winCode;
// 开奖时间
@property (nonatomic, readonly, strong) NSString *openTime;
// 试机号, 只有福彩3D有试机号
@property (nonatomic, readonly, strong) NSString *tryCode;
@end
