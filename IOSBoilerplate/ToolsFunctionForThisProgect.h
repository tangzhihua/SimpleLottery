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


// 同步网络请求App最新版本信息(一定要在子线程中调用此方法, 因为使用sendSynchronousRequest), 并且返回 VersionNetRespondBean
+(VersionNetRespondBean *)synchronousRequestAppNewVersionAndReturnVersionBean;

// 使用 Info.plist 中的 "Bundle version" 来保存本地App Version
+(NSString *)localAppVersion;

// 加载内部错误时的UI(Activity之间传递的必须参数无效), 并且隐藏 bodyLayout, 这里的设计要统一划一, 如果想要使用这种设计, 就要按照要求设计bodyLayout
+(void)loadIncomingIntentValidUIWithSuperView:(UIView *)superView andHideBodyLayout:(UIView *)bodyLayout;

// 将 "秒" 格式化成 "天小时分钟秒", 例如 : 入参是 118269(秒), 返回 "1天8时51分9秒"
+(NSString *)formatSecondToDayHourMinuteSecond:(NSNumber *)secondSource;
@end
