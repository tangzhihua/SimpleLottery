//
//  GloblaDataCacheForFile.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "GlobalDataCacheForNeedSaveToFileSystem.h"
#import "GlobalDataCacheForMemorySingleton.h"

 

 
#import "NSObject+Serialization.h"

#import "LocalCacheDataPathConstant.h"










static NSString *const TAG = @"<GlobalDataCacheForNeedSaveToFileSystem>";











// 自动登录的标志
static NSString *const kLocalCacheDataName_AutoLoginMark                  = @"AutoLoginMark";
// 用户最后一次成功登录的 RandomNumber
static NSString *const kLocalCacheDataName_RandomNumber                   = @"RandomNumber";
// 用户最后一次成功登录时的用户名
static NSString *const kLocalCacheDataName_UsernameForLastSuccessfulLogon = @"UsernameForLastSuccessfulLogon";
// 用户最后一次成功登录时的密码
static NSString *const kLocalCacheDataName_PasswordForLastSuccessfulLogon = @"PasswordForLastSuccessfulLogon";
// 用户是否是首次启动App
static NSString *const kLocalCacheDataName_FirstStartApp                  = @"FirstStartApp";
// 是否需要显示 初学者指南 
static NSString *const kLocalCacheDataName_BeginnerGuide                  = @"BeginnerGuide";
// 欢迎界面的广告图片 版本ID
static NSString *const kLocalCacheDataName_AdImageIDForLatest             = @"AdImageIDForLatest";
// 是否显示从服务器下载的广告图片
static NSString *const kLocalCacheDataName_IsShowAdImageFromServer        = @"IsShowAdImageFromServer";

@implementation GlobalDataCacheForNeedSaveToFileSystem

#pragma mark -
#pragma mark
 
+ (void)readUserLoginInfoToGlobalDataCacheForMemorySingleton {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  // 自动登录的标志
  id autoLoginMark = [userDefaults objectForKey:(NSString *)kLocalCacheDataName_AutoLoginMark];
  if (autoLoginMark == nil) {
    [userDefaults setBool:YES forKey:(NSString *)kLocalCacheDataName_AutoLoginMark];
  }
  BOOL autoLoginMarkBOOL = [userDefaults boolForKey:(NSString *)kLocalCacheDataName_AutoLoginMark];
  [[GlobalDataCacheForMemorySingleton sharedInstance] setNeedAutologin:autoLoginMarkBOOL];
  
	// 用户最后一次成功登录的 RandomNumber
	NSString *randomNumberForLastSuccessfulLogon = [userDefaults stringForKey:(NSString *)kLocalCacheDataName_RandomNumber];
  [GlobalDataCacheForMemorySingleton sharedInstance].randomNumberForLastSuccessfulLogon = randomNumberForLastSuccessfulLogon;
	
  // 用户最后一次成功登录时的用户名
  NSString *usernameForLastSuccessfulLogon = [userDefaults stringForKey:(NSString *)kLocalCacheDataName_UsernameForLastSuccessfulLogon];
  [GlobalDataCacheForMemorySingleton sharedInstance].usernameForLastSuccessfulLogon = usernameForLastSuccessfulLogon;
  
  // 用户最后一次成功登录时的密码
  NSString *passwordForLastSuccessfulLogon = [userDefaults stringForKey:(NSString *)kLocalCacheDataName_PasswordForLastSuccessfulLogon];
  [GlobalDataCacheForMemorySingleton sharedInstance].passwordForLastSuccessfulLogon = passwordForLastSuccessfulLogon;
}

+ (void)readAppConfigInfoToGlobalDataCacheForMemorySingleton {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
	// 用户是否是第一次启动App
	id isFirstStartAppTest = [userDefaults objectForKey:kLocalCacheDataName_FirstStartApp];
  if (nil == isFirstStartAppTest) {
    [userDefaults setBool:YES forKey:kLocalCacheDataName_FirstStartApp];
  }
  BOOL isFirstStartApp = [userDefaults boolForKey:kLocalCacheDataName_FirstStartApp];
  [GlobalDataCacheForMemorySingleton sharedInstance].isFirstStartApp = isFirstStartApp;
	
	
  // 是否需要在启动后显示初学者指南界面
  id isNeedShowBeginnerGuideTest = [userDefaults objectForKey:kLocalCacheDataName_BeginnerGuide];
  if (nil == isNeedShowBeginnerGuideTest) {
    [userDefaults setBool:YES forKey:kLocalCacheDataName_BeginnerGuide];
  }
  BOOL isNeedShowBeginnerGuide = [userDefaults boolForKey:kLocalCacheDataName_BeginnerGuide];
  [GlobalDataCacheForMemorySingleton sharedInstance].isNeedShowBeginnerGuide = isNeedShowBeginnerGuide;
	
	// 欢迎界面的广告图片版本ID
	NSString *adImageIDForLatest = [userDefaults stringForKey:(NSString *)kLocalCacheDataName_AdImageIDForLatest];
  [GlobalDataCacheForMemorySingleton sharedInstance].adImageIDForLatest = adImageIDForLatest;
	
	// 是否显示从服务器下载的广告图片
  id isShowAdImageFromServerTest = [userDefaults objectForKey:kLocalCacheDataName_IsShowAdImageFromServer];
  if (nil == isShowAdImageFromServerTest) {
    [userDefaults setBool:NO forKey:kLocalCacheDataName_IsShowAdImageFromServer];
  }
  BOOL isShowAdImageFromServer = [userDefaults boolForKey:kLocalCacheDataName_IsShowAdImageFromServer];
  [GlobalDataCacheForMemorySingleton sharedInstance].isShowAdImageFromServer = isShowAdImageFromServer;

}






#pragma mark -
#pragma mark 
 
+ (void)writeUserLoginInfoToFileSystem {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  // 自动登录的标志
  BOOL autoLoginMark = [[GlobalDataCacheForMemorySingleton sharedInstance] isNeedAutologin];
  [userDefaults setBool:autoLoginMark forKey:(NSString *)kLocalCacheDataName_AutoLoginMark];
  
  // 用户最后一次成功登录时的sessionID
  NSString *randomNumberForLastSuccessfulLogon = [GlobalDataCacheForMemorySingleton sharedInstance].randomNumberForLastSuccessfulLogon;
  if (![NSString isEmpty:randomNumberForLastSuccessfulLogon]) {
    [userDefaults setObject:randomNumberForLastSuccessfulLogon forKey:(NSString *)kLocalCacheDataName_RandomNumber];
  }
	
  // 用户最后一次成功登录时的用户名
  NSString *usernameForLastSuccessfulLogon = [[GlobalDataCacheForMemorySingleton sharedInstance] usernameForLastSuccessfulLogon];
  if (![NSString isEmpty:usernameForLastSuccessfulLogon]) {
    [userDefaults setObject:usernameForLastSuccessfulLogon forKey:(NSString *)kLocalCacheDataName_UsernameForLastSuccessfulLogon];
  }
  
  // 用户最后一次成功登录时的密码
  NSString *passwordForLastSuccessfulLogon = [[GlobalDataCacheForMemorySingleton sharedInstance] passwordForLastSuccessfulLogon];
  if (![NSString isEmpty:passwordForLastSuccessfulLogon]) {
    [userDefaults setObject:passwordForLastSuccessfulLogon forKey:(NSString *)kLocalCacheDataName_PasswordForLastSuccessfulLogon];
  }
  
}

+ (void)writeAppConfigInfoToFileSystem {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
	// 是否需要显示用户第一次登录时的帮助界面的标志
  BOOL isFirstStartApp = [GlobalDataCacheForMemorySingleton sharedInstance].isFirstStartApp;
  [userDefaults setBool:isFirstStartApp forKey:kLocalCacheDataName_FirstStartApp];
	
  // 是否需要显示用户第一次登录时的帮助界面的标志
  BOOL isNeedShowBeginnerGuide = [GlobalDataCacheForMemorySingleton sharedInstance].isNeedShowBeginnerGuide;
  [userDefaults setBool:isNeedShowBeginnerGuide forKey:kLocalCacheDataName_BeginnerGuide];
	
	// 欢迎界面的广告图片版本ID
  NSString *adImageIDForLatest = [GlobalDataCacheForMemorySingleton sharedInstance].adImageIDForLatest;
  if (![NSString isEmpty:adImageIDForLatest]) {
    [userDefaults setObject:adImageIDForLatest forKey:(NSString *)kLocalCacheDataName_AdImageIDForLatest];
  }
	
	// 是否显示从服务器下载的广告图片
  BOOL isShowAdImageFromServer = [GlobalDataCacheForMemorySingleton sharedInstance].isShowAdImageFromServer;
  [userDefaults setBool:isShowAdImageFromServer forKey:kLocalCacheDataName_IsShowAdImageFromServer];
}

#pragma mark -
#pragma mark
+ (void)saveAllCacheDataToFileSystem {
   
  //[GlobalDataCacheForNeedSaveToFileSystem writeDictionaryNetRespondBeanToFileSystem];
  [GlobalDataCacheForNeedSaveToFileSystem writeUserLoginInfoToFileSystem];
  [GlobalDataCacheForNeedSaveToFileSystem writeAppConfigInfoToFileSystem];
}

@end
