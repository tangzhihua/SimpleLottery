//
//  SoftwareUpdateDatabaseFieldsConstant.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#ifndef ruyicai_SoftwareUpdateDatabaseFieldsConstant_h
#define ruyicai_SoftwareUpdateDatabaseFieldsConstant_h

/************      RequestBean       *************/

//随机数 (可选)
#define k_SoftwareUpdate_RequestKey_randomNumber      @"randomNumber"
//是模拟器 (可选)
#define k_SoftwareUpdate_RequestKey_isemulator        @"isemulator"

/************      RespondBean       *************/


/// 图片升级返回bean的key
// 
#define k_AdImage_RespondKey_image						        @"image"
//
#define k_AdImage_RespondKey_errorCode						    @"errorCode"
//
#define k_AdImage_RespondKey_id						            @"id"
//
#define k_AdImage_RespondKey_imageUrl						      @"imageUrl"

 

// 各个彩种当前信息返回bean的key
//
#define k_BatchCodeInfo_RespondKey_currentBatchCode   @"currentBatchCode"
//
#define k_BatchCodeInfo_RespondKey_batchCode				  @"batchCode"
//
#define k_BatchCodeInfo_RespondKey_endTime					  @"endTime"
//
#define k_BatchCodeInfo_RespondKey_endSecond				  @"endSecond"


// 广播消息返回bean的key
//
#define k_BroadcastMessage_RespondKey_broadcastmessage @"broadcastmessage"
//
#define k_BroadcastMessage_RespondKey_id				       @"id"
//
#define k_BroadcastMessage_RespondKey_title				     @"title"
//
#define k_BroadcastMessage_RespondKey_message				   @"message"

// 用户自动登录信息返回bean的key
//
#define k_AutoLogin_RespondKey_autoLogin				       @"autoLogin"
//
#define k_AutoLogin_RespondKey_isAutoLogin				     @"isAutoLogin"
//
#define k_AutoLogin_RespondKey_userno				           @"userno"
//
#define k_AutoLogin_RespondKey_certid				           @"certid"
//
#define k_AutoLogin_RespondKey_mobileid				         @"mobileid"
//
#define k_AutoLogin_RespondKey_name				             @"name"
//
#define k_AutoLogin_RespondKey_userName				         @"userName"
//
#define k_AutoLogin_RespondKey_sessionid				       @"sessionid"


// 获取新闻和下次联网时间返回bean的key
//
#define k_News_RespondKey_news				                 @"news"
//
#define k_Noticetime_RespondKey_noticetime			       @"noticetime"


#endif
