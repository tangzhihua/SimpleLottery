//
//  BaiduLBSSingleton.m
//  airizu
//
//  Created by 唐志华 on 13-1-7.
//
//

#import "BaiduLBSSingleton.h"

static const NSString *const TAG = @"<BaiduLBSSingleton>";

// 授权Key
// 申请地址：http://dev.baidu.com/wiki/static/imap/key/
static const NSString *const kBaiduLBSKey = @"198E24B94477359734BACB87B802396CE36EFE3A";

@interface BaiduLBSSingleton()
// 百度MapAPI的管理类
@property (nonatomic, readwrite, strong) BMKMapManager *baiduMapManager;
@end

@implementation BaiduLBSSingleton

#pragma mark -
#pragma mark 单例方法群
// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  NSAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
  }
  
  return self;
}

+ (BaiduLBSSingleton *) sharedInstance {
  static BaiduLBSSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}
 
#pragma mark -
#pragma mark 实现 BMKGeneralDelegate 接口
///通知Delegate

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError {
  // 您的网络出错啦
  NSLog(@"%@ onGetNetworkState error is %d", TAG, iError);
  
}

/**
 *返回授权验证错误
 *@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
 */
- (void)onGetPermissionState:(int)iError {
  NSLog(@"%@ onGetPermissionState error is %d", TAG, iError);
  
}

#pragma mark -
#pragma mark 实例方法
- (void)initializeMapManager {
  
  if (_baiduMapManager == nil) {
    // 要使用百度地图，请先启动BaiduMapManager
    _baiduMapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_baiduMapManager start:(NSString *)kBaiduLBSKey
                       generalDelegate:self];
    if (!ret) {
      NSLog(@"%@ manager start failed!", TAG);
    }
  }
}

- (void)releaseMapManager {
  if (_baiduMapManager != nil) {
    [_baiduMapManager stop];
    //[_baiduMapManager release];
    _baiduMapManager = nil;
  }
}

- (BOOL)gpsIsEnable {
  do {
    if(![CLLocationManager locationServicesEnabled]) {
      // 手机GPS总开关未开启
      break;
    }
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized) {
      // 手机GPS总开关开启, 但是当前App的GPS权限未开启
      break;
    }
    return YES;
  } while (NO);
  
  return NO;
}

- (BOOL)openGPS {
  return YES;
}

@end
