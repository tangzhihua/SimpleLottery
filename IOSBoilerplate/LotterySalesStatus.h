//
//  LotterySaleInformation.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import <Foundation/Foundation.h>

#import "MacroConstantForThisProject.h"

@interface LotterySalesStatus : NSObject

// 彩票今日开奖状态
@property (nonatomic, readonly, assign) LotteryOpenPrizeStatusEnum lotteryOpenPrizeStatusEnum;

// 是否正在销售
@property (nonatomic, readonly, assign) BOOL isSale;

+(id)lotterySalesStatusWithIsSale:(BOOL)isSale
			 lotteryOpenPrizeStatusEnum:(LotteryOpenPrizeStatusEnum)lotteryOpenPrizeStatusEnum;
@end
