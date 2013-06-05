//
//  TodayOpenPrizeDatabaseFieldsConstant.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#ifndef ruyicai_LotterySalesStatusDatabaseFieldsConstant_h
#define ruyicai_LotterySalesStatusDatabaseFieldsConstant_h

/************      RequestBean       *************/

 




/************      RespondBean       *************/

// 正在进行的活动数量 Integer类型
#define k_LotterySalesStatus_RespondKey_inProgressActivityCount @"inProgressActivityCount"


/// array

// 彩种编号 : 如：F47102、F47103、ZC(足彩)、JC_Z(竞彩足球)、JC_L(竞彩篮球)
#define k_LotterySalesStatus_RespondKey_lotNo                   @"lotNo"
// 是否今日开奖 true:是，false:否。
#define k_LotterySalesStatus_RespondKey_isTodayOpenPrize        @"isTodayOpenPrize"
// 是否加奖 true:是，false:否
#define k_LotterySalesStatus_RespondKey_isAddAward              @"isAddAward"
// 是否正在销售 true:是，false:否
#define k_LotterySalesStatus_RespondKey_isSale                  @"isSale"



#endif
