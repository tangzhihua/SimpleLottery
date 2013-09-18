//
//  ToolsFunctionForThisProgect.m
//  airizu
//
//  Created by 唐志华 on 13-1-6.
//
//

#import "ToolsFunctionForThisProgect.h"

#import "JSONKit.h"
#import "NSDictionary+SafeValue.h"


#import "NSDate+Convenience.h"


#import "GlobalDataCacheForDataDictionarySingleton.h"
#import "MacroConstantForThisProject.h"
#import "SimpleLocationHelperForBaiduLBS.h"

#import "SimpleCookieSingleton.h"

#import "VersionNetRespondBean.h"

#import "UserLoggedInfo.h"



@implementation ToolsFunctionForThisProgect

/**
 * 记录用户登录成功后的重要信息
 *
 * @param logonNetRespondBean
 * @param usernameForLastSuccessfulLogon
 * @param passwordForLastSuccessfulLogon
 */
+(void)noteLogonSuccessfulInfoWithUserLoggedInfo:(UserLoggedInfo *)userLoggedInfo
									usernameForLastSuccessfulLogon:(NSString *)usernameForLastSuccessfulLogon
									passwordForLastSuccessfulLogon:(NSString *)passwordForLastSuccessfulLogon {
  
  if (userLoggedInfo == nil) {
    RNAssert(NO, @"userLoggedInfo is null !");
    return;
  }
  
  if ([NSString isEmpty:usernameForLastSuccessfulLogon] || [NSString isEmpty:passwordForLastSuccessfulLogon]) {
    RNAssert(NO, @"username or password is empty ! ");
    return;
  }
  
  PRPLog(@"%@ userLoggedInfo --->", userLoggedInfo);
  PRPLog(@"%@ username --->", usernameForLastSuccessfulLogon);
  PRPLog(@"%@ password --->", passwordForLastSuccessfulLogon);
  
  // 设置Cookie
  [[SimpleCookieSingleton sharedInstance] setObject:userLoggedInfo.sessionid forKey:@"sessionid"];
  
  // 保用用户登录成功的信息
  [GlobalDataCacheForMemorySingleton sharedInstance].userLoggedInfo = userLoggedInfo;
  
	// 保留用户最后一次登录成功时的 randomNumber
  [GlobalDataCacheForMemorySingleton sharedInstance].randomNumberForLastSuccessfulLogon = userLoggedInfo.randomNumber;
	
  // 保留用户最后一次登录成功时的 用户名
  [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon = usernameForLastSuccessfulLogon;
  
  // 保留用户最后一次登录成功时的 密码
  [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon = passwordForLastSuccessfulLogon;
}

/**
 * 清空登录相关信息
 */
+(void)clearLogonInfo {
  [[SimpleCookieSingleton sharedInstance] removeObjectForKey:@"sessionid"];
  
  [GlobalDataCacheForMemorySingleton sharedInstance].userLoggedInfo = nil;
}



// 同步网络请求App最新版本信息(一定要在子线程中调用此方法, 因为使用sendSynchronousRequest发起的网络请求), 并且返回 VersionNetRespondBean
#define APP_URL @"http://itunes.apple.com/lookup?id=494520120"
+(VersionNetRespondBean *)synchronousRequestAppNewVersionAndReturnVersionBean {
  VersionNetRespondBean *versionBean = nil;
  
  do {
    
    NSString *URL = APP_URL;
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:URL]];
    [urlRequest setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    // 同步请求网络数据
    NSData *recervedData
    = [NSURLConnection sendSynchronousRequest:urlRequest
                            returningResponse:&urlResponse
                                        error:&error];
    if (![recervedData isKindOfClass:[NSData class]]) {
      break;
    }
    if (recervedData.length <= 0) {
      break;
    }
  
    urlRequest = nil;
    NSDictionary *jsonRootNSDictionary = [NSJSONSerialization JSONObjectWithData:recervedData options:0 error:&error];
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      break;
    }
    NSArray *infoArray = [jsonRootNSDictionary objectForKey:@"results"];
    if ([infoArray count] > 0) {
      NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
      NSString *lastVersion = [releaseInfo objectForKey:@"version"];
      NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
      NSString *fileSizeBytes = [releaseInfo objectForKey:@"fileSizeBytes"];
      versionBean = [VersionNetRespondBean versionNetRespondBeanWithNewVersion:lastVersion
                                                                   andFileSize:fileSizeBytes
                                                              andUpdateContent:nil
                                                            andDownloadAddress:trackViewUrl];
    }
  } while (NO);
  
  return versionBean;
}

/*
Xcode4有两个版本号，一个是Version,另一个是Build,对应于Info.plist的字段名分别为CFBundleShortVersionString,CFBundleVersion。
友盟SDK为了兼容Xcode3的工程，默认取的是Build号，如果需要取Xcode4的Version，可以使用下面的方法。

NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
*/
// 使用 Info.plist 中的 "Bundle version" 来保存本地App Version
+(NSString *)localAppVersion {
  NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
  NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
  return appVersion;
}

// 加载内部错误时的UI(Activity之间传递的必须参数无效), 并且隐藏 bodyLayout
+(void)loadIncomingIntentValidUIWithSuperView:(UIView *)superView andHideBodyLayout:(UIView *)bodyLayout {
  if (![superView isKindOfClass:[UIView class]]) {
    // 入参错误
    return;
  }
  
	/*
	 PreloadingUIToolBar *preloadingUIToolBar = [PreloadingUIToolBar preloadingUIToolBar];
	 [preloadingUIToolBar setHintInfo:kIncomingIntentValid];
	 [preloadingUIToolBar showInView:superView];
	 
	 // 外部传入的数据非法, 就隐藏掉 bodyLayout
	 if ([bodyLayout isKindOfClass:[UIView class]]) {
	 bodyLayout.hidden = YES;
	 }
	 */
}

 
// 将 "秒" 格式化成 "天小时分钟秒", 例如 : 入参是 118269(秒), 返回 "1天8时51分9秒"
+(NSString *)formatSecondToDayHourMinuteSecond:(NSNumber *)secondSource {
	if (![secondSource isKindOfClass:[NSNumber class]] || [secondSource doubleValue] <= 0.0f) {
    return @"0秒";
  }
  
	double timeOfSecond = [secondSource doubleValue];
	NSInteger day = timeOfSecond / 86400;
	timeOfSecond -= 86400*day;
	NSInteger hour = timeOfSecond / 3600;
	timeOfSecond -= 3600*hour;
	NSInteger minute = timeOfSecond / 60;
	timeOfSecond -= 60*minute;
	NSInteger second = timeOfSecond;
	

	NSMutableString *dateString = [NSMutableString string];
	if (day > 0) {
		[dateString appendFormat:@"%d天", day];
	}
	if (hour > 0) {
		[dateString appendFormat:@"%d时", hour];
	}
	if (minute > 0) {
		[dateString appendFormat:@"%d分", minute];
	}
	[dateString appendFormat:@"%d秒", second];
	
	return dateString;
}
@end
