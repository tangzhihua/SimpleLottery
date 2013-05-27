//
//  LotterySaleInformation.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import "LotterySalesStatus.h"

@implementation LotterySalesStatus

- (id) initWithIsSale:(BOOL)isSale lotteryOpenPrizeStatusEnum:(LotteryOpenPrizeStatusEnum)lotteryOpenPrizeStatusEnum {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _isSale = isSale;
		_lotteryOpenPrizeStatusEnum = lotteryOpenPrizeStatusEnum;
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)lotterySalesStatusWithIsSale:(BOOL)isSale lotteryOpenPrizeStatusEnum:(LotteryOpenPrizeStatusEnum)lotteryOpenPrizeStatusEnum {
	return [[LotterySalesStatus alloc] initWithIsSale:isSale lotteryOpenPrizeStatusEnum:lotteryOpenPrizeStatusEnum];
}

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (NSString *)description {
	return descriptionForDebug(self);
}



@end
