//
//  LotteryAnnouncementDatabaseFieldConstant.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#ifndef ruyicai_LotteryAnnouncementDatabaseFieldConstant_h
#define ruyicai_LotteryAnnouncementDatabaseFieldConstant_h

/************      RequestBean       *************/






/************      RespondBean       *************/

// 正在进行的活动数量 Integer类型
 


/// array


// 下次联网时间(单位：秒), 用于客户端弹出消息，提示用户已开奖
#define k_LotteryAnnouncement_RespondKey_noticeTime  @"noticeTime"
// 期号
#define k_LotteryAnnouncement_RespondKey_batchCode   @"batchCode"
// 开奖号码
#define k_LotteryAnnouncement_RespondKey_winCode     @"winCode"
// 开奖时间
#define k_LotteryAnnouncement_RespondKey_openTime    @"openTime"
// 试机号, 只有福彩3D有试机号
#define k_LotteryAnnouncement_RespondKey_tryCode     @"tryCode"
 

#endif

 
