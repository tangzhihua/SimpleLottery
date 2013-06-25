//
//  TodayOpenPrizeNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface LotterySalesStatusNetRespondBean : BaseModel {
  
}


// 正在进行的活动数量
@property (nonatomic, readonly, assign) NSInteger inProgressActivityCount;

// 彩票销售状态 列表
@property (nonatomic, readonly, strong) NSMutableDictionary *lotterySaleInformationMap;


@end
