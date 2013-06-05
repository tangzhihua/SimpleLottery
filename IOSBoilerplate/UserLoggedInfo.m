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
- (id) initWithMessage:(NSString *)message
								userno:(NSString *)userno
								certid:(NSString *)certid
							mobileid:(NSString *)mobileid
									name:(NSString *)name
							userName:(NSString *)userName
						 sessionid:(NSString *)sessionid
					randomNumber:(NSString *)randomNumber {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _message = [message copy];
    _userno = [userno copy];
    _certid = [certid copy];
    _mobileid = [mobileid copy];
    _name = [name copy];
		_userName = [userName copy];
    _sessionid = [sessionid copy];
		_randomNumber = [randomNumber copy];
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造

+(id)userLoggedInfoWithMessage:(NSString *)message
												userno:(NSString *)userno
												certid:(NSString *)certid
											mobileid:(NSString *)mobileid
													name:(NSString *)name
											userName:(NSString *)userName
										 sessionid:(NSString *)sessionid
									randomNumber:(NSString *)randomNumber {
	
  return [[UserLoggedInfo alloc] initWithMessage:message
																					userno:userno
																					certid:certid
																				mobileid:mobileid
																						name:name
																				userName:userName
																			 sessionid:sessionid
																		randomNumber:randomNumber];
}

- (NSString *)description {
	return descriptionForDebug(self);
}
@end
