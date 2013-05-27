//
//  AloneLotteryDatabaseFieldsConstant.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//

#ifndef ruyicai_IssueQueryDatabaseFieldsConstant_h
#define ruyicai_IssueQueryDatabaseFieldsConstant_h


/************      RequestBean       *************/



// 用彩种 必填
#define k_IssueQuery_RequestKey_lotno        @"lotno"



/************      RespondBean       *************/




// 提示信息
#define k_IssueQuery_RespondKey_message						 @"message"
// 期号
#define k_IssueQuery_RespondKey_batchcode          @"batchcode"
//  
#define k_IssueQuery_RespondKey_starttime          @"starttime"
// 系统当前时间
#define k_IssueQuery_RespondKey_syscurrenttime     @"syscurrenttime"
// 投注截止时间	
#define k_IssueQuery_RespondKey_endtime						 @"endtime"
// 期结剩余时间	单位：秒
#define k_IssueQuery_RespondKey_time_remaining     @"time_remaining"





#endif
