//
//  LogonDatabaseFieldsConstant.h
//  airizu
//
//  Created by 唐志华 on 12-12-28.
//
//

#ifndef airizu_LogonDatabaseFieldsConstant_h
#define airizu_LogonDatabaseFieldsConstant_h

/************      RequestBean       *************/

// 用户的手机号 必填
#define k_Login_RequestKey_phonenum        @"phonenum"
// 用户的密码 必填
#define k_Login_RequestKey_password        @"password"
// 是否设置自动登录 必填 1是，0否
#define k_Login_RequestKey_isAutoLogin     @"isAutoLogin"




/************      RespondBean       *************/

// 提示信息
#define k_Login_RespondKey_message         @"message"
// 用户编号
#define k_Login_RespondKey_userno          @"userno"
// 身份证号
#define k_Login_RespondKey_certid          @"certid"
// 手机号
#define k_Login_RespondKey_mobileid        @"mobileid"
// 真实姓名
#define k_Login_RespondKey_name            @"name"
// 用户名
#define k_Login_RespondKey_userName        @"userName"
// SessionId 
#define k_Login_RespondKey_sessionid       @"sessionid"
// 用于自动登录
#define k_Login_RespondKey_randomNumber    @"randomNumber"

#endif
