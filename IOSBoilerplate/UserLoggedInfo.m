//
//  AutoLoginUserInfo.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "UserLoggedInfo.h"

@interface UserLoggedInfo ()
// 提示信息
@property (nonatomic, readwrite, strong) NSString *message;
// 用户编号
@property (nonatomic, readwrite, strong) NSString *userno;
// 身份证号
@property (nonatomic, readwrite, strong) NSString *certid;
// 手机号
@property (nonatomic, readwrite, strong) NSString *mobileid;
// 真实姓名
@property (nonatomic, readwrite, strong) NSString *name;
// 用户名
@property (nonatomic, readwrite, strong) NSString *userName;
// SessionId
@property (nonatomic, readwrite, strong) NSString *sessionid;
// 用户自动登录
@property (nonatomic, readwrite, strong) NSString *randomNumber;
@end

@implementation UserLoggedInfo
 
- (NSString *)description {
	return descriptionForDebug(self);
}
@end
