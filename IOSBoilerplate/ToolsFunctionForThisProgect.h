//
//  ToolsFunctionForThisProgect.h
//  airizu
//
//  Created by 唐志华 on 13-1-6.
//
//

#import <Foundation/Foundation.h>
@class VersionNetRespondBean;
@class UserLoggedInfo;
@interface ToolsFunctionForThisProgect : NSObject {
  
}

+(void)noteLogonSuccessfulInfoWithUserLoggedInfo:(UserLoggedInfo *)userLoggedInfo
									usernameForLastSuccessfulLogon:(NSString *)usernameForLastSuccessfulLogon
									passwordForLastSuccessfulLogon:(NSString *)passwordForLastSuccessfulLogon;


// 检查新版本信息, 并且返回 VersionNetRespondBean
+(VersionNetRespondBean *)checkNewVersionAndReturnVersionBean;

+(NSString *)localAppVersion;

// 加载内部错误时的UI(Activity之间传递的必须参数无效), 并且隐藏 bodyLayout, 这里的设计要统一划一, 如果想要使用这种设计, 就要按照要求设计bodyLayout
+(void)loadIncomingIntentValidUIWithSuperView:(UIView *)superView andHideBodyLayout:(UIView *)bodyLayout;


+(NSString *)formatSecondToDayHourMinuteSecond:(NSNumber *)secondSource;
@end
