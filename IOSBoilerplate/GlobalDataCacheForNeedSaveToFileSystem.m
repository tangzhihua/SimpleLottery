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

#import "LotteryDictionaryDatabaseFieldsConstant.h"
#import "LotteryDictionary.h"








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


static NSString *const kLocalCacheDataName_LotteryListForShow             = @"LotteryListForShow";
static NSString *const kLocalCacheDataName_LotteryListForHide             = @"LotteryListForHide";


@implementation GlobalDataCacheForNeedSaveToFileSystem

+(void) initialize {
  
  // 这是为了子类化当前类后, 父类的initialize方法会被调用2次
  if (self == [GlobalDataCacheForNeedSaveToFileSystem class]) {
    // 内存告警
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(saveMemoryCacheToDisk:)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
  // 应用进入后台
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(saveMemoryCacheToDisk:)
                                               name:UIApplicationDidEnterBackgroundNotification
                                             object:nil];
  // 应用退出
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(saveMemoryCacheToDisk:)
                                               name:UIApplicationWillTerminateNotification
                                             object:nil];
  }
  
  
}

+(void) dealloc {
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationDidReceiveMemoryWarningNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationDidEnterBackgroundNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationWillTerminateNotification
                                                object:nil];
  
}

#pragma mark -
#pragma mark 将内存中缓存的数据保存到文件系统中

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


// 读取 "彩票字典" 相关数据到内存中
+ (void)readLotteryDictionaryInfoToGlobalDataCacheForMemorySingleton {
  
  // 本地设置的可以使用的彩票字典
  NSMutableArray *lotteryDictionaryOfEnable = [NSMutableArray array];
  
  // 读取本地彩票字典, 这是彩票的主字典(最重要的是彩票的 key/code/name)
  NSString *filePathForLotteryDictionary = [[NSBundle mainBundle] pathForResource:@"lottery_list" ofType:@"plist"];
  NSArray *plistForLotteryDictionary = [[NSArray alloc] initWithContentsOfFile:filePathForLotteryDictionary];
  NSMutableArray *lotteryDictionaryList = [NSMutableArray arrayWithCapacity:30];
  for (NSDictionary *dictionary in plistForLotteryDictionary) {
    LotteryDictionary *lotteryDictionary = [[LotteryDictionary alloc] initWithDictionary:dictionary];
    [lotteryDictionaryList addObject:lotteryDictionary];
    
    if (lotteryDictionary.enable) {
      [lotteryDictionaryOfEnable addObject:lotteryDictionary.name];
    }
  }
  // 缓存到内存中
  [GlobalDataCacheForMemorySingleton sharedInstance].lotteryDictionaryList = lotteryDictionaryList;
  
  
  
  
  // 读取本地缓存的, 用户设置的要显示的彩票
  BOOL isHasDirtyData = NO;
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSArray *lotteryListForHide = [userDefaults objectForKey:(NSString *)kLocalCacheDataName_LotteryListForHide];
  [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForHide = [NSMutableArray arrayWithArray:lotteryListForHide];

  //
  NSArray *lotteryListForShow = [userDefaults objectForKey:(NSString *)kLocalCacheDataName_LotteryListForShow];
  if (lotteryListForShow != nil && lotteryListForShow.count > 0) {
    if (lotteryDictionaryOfEnable.count == (lotteryListForHide.count + lotteryListForShow.count)) {
      [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForShow = [NSMutableArray arrayWithArray:lotteryListForShow];
    } else {
      // 出现了脏数据, 此时要重置数据
      isHasDirtyData = YES;
    }
    
  } else {
    if ([GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForHide.count <= 0) {
       [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForShow = [NSMutableArray arrayWithArray:lotteryDictionaryOfEnable];
    } else {
      // 出现了脏数据, 此时要重置数据
      isHasDirtyData = YES;
    }
  }
  
  // 处理脏数据
  if (isHasDirtyData) {
    [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForHide = nil;
    [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForShow = [NSMutableArray arrayWithArray:lotteryDictionaryOfEnable];
    [userDefaults removeObjectForKey:(NSString *)kLocalCacheDataName_LotteryListForShow];
    [userDefaults removeObjectForKey:(NSString *)kLocalCacheDataName_LotteryListForHide];
  }
}



#pragma mark -
#pragma mark 从文件系统中读取缓存的数据到内存中

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

+ (void)writeLotteryDictionaryInfoToFileSystem {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
	//
  NSArray *lotteryListForShow = [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForShow;
  if (lotteryListForShow.count > 0) {
    [userDefaults setObject:lotteryListForShow forKey:(NSString *)kLocalCacheDataName_LotteryListForShow];
  } else {
    [userDefaults removeObjectForKey:(NSString *)kLocalCacheDataName_LotteryListForShow];
  }
  
  NSArray *lotteryListForHide = [GlobalDataCacheForMemorySingleton sharedInstance].lotteryListForHide;
  if (lotteryListForHide.count > 0) {
    [userDefaults setObject:lotteryListForShow forKey:(NSString *)kLocalCacheDataName_LotteryListForHide];
  } else {
    [userDefaults removeObjectForKey:(NSString *)kLocalCacheDataName_LotteryListForHide];
  }
}

#pragma mark -
#pragma mark 将内存级别缓存的数据固化到硬盘中
+ (void)saveMemoryCacheToDisk:(NSNotification *)notification {
  PRPLog(@"saveMemoryCacheToDisk:%@", notification);
  
  [GlobalDataCacheForNeedSaveToFileSystem writeUserLoginInfoToFileSystem];
  [GlobalDataCacheForNeedSaveToFileSystem writeAppConfigInfoToFileSystem];
  [GlobalDataCacheForNeedSaveToFileSystem writeLotteryDictionaryInfoToFileSystem];
}

@end
