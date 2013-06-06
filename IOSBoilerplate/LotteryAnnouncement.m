//
//  LotteryAnnouncement.m
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "LotteryAnnouncement.h"

@interface LotteryAnnouncement ()
// 期号
@property (nonatomic, readwrite, strong) NSString *batchCode;
// 开奖号码
@property (nonatomic, readwrite, strong) NSString *winCode;
// 开奖时间
@property (nonatomic, readwrite, strong) NSString *openTime;
// 试机号, 只有福彩3D有试机号
@property (nonatomic, readwrite, strong) NSString *tryCode;


@end


@implementation LotteryAnnouncement
- (NSString *)description {
	return descriptionForDebug(self);
}
@end
