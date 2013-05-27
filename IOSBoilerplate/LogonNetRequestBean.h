//
//  LogonNetRequestBean.h
//  airizu
//
//  Created by 唐志华 on 13-1-1.
//
//

#import <Foundation/Foundation.h>

@interface LogonNetRequestBean : NSObject {
  
}

// 用户的手机号 必填
@property (nonatomic, readonly, strong) NSString *phonenum;
// 用户的密码 必填
@property (nonatomic, readonly, strong) NSString *password;
// 是否设置自动登录 必填 1是，0否
@property (nonatomic, readonly) BOOL isAutoLogin;

#pragma mark -
#pragma mark 方便构造
+(id)logonNetRequestBeanWithPhonenum:(NSString *)phonenum password:(NSString *)password isAutoLogin:(BOOL)isAutoLogin;

@end
