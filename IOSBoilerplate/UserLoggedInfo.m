//
//  AutoLoginUserInfo.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "UserLoggedInfo.h"

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

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (NSString *)description {
	return descriptionForDebug(self);
}
@end
