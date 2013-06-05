//
//  AutoLoginUserInfo.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface UserLoggedInfo : JSONModel
// 提示信息
@property (nonatomic, readonly, strong) NSString *message;
// 用户编号
@property (nonatomic, readonly, strong) NSString *userno;
// 身份证号
@property (nonatomic, readonly, strong) NSString *certid;
// 手机号
@property (nonatomic, readonly, strong) NSString *mobileid;
// 真实姓名
@property (nonatomic, readonly, strong) NSString *name;
// 用户名
@property (nonatomic, readonly, strong) NSString *userName;
// SessionId
@property (nonatomic, readonly, strong) NSString *sessionid;
// 用户自动登录
@property (nonatomic, readonly, strong) NSString *randomNumber;

@end
