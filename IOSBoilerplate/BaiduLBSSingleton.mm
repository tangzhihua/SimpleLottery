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

static BaiduLBSSingleton *singletonInstance = nil;

- (void) initialize {
  
}

#pragma mark -
#pragma mark 单例方法群

+ (BaiduLBSSingleton *) sharedInstance
{
  if (singletonInstance == nil)
  {
    singletonInstance = [[super allocWithZone:NULL] init];
    
    // initialize the first view controller
    // and keep it with the singleton
    [singletonInstance initialize];
  }
  
  return singletonInstance;
}
/*
+ (id) allocWithZone:(NSZone *)zone
{
  return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
  return self;
}

- (id) retain
{
  return self;
}

- (NSUInteger) retainCount
{
  return NSUIntegerMax;
}

- (oneway void) release
{
  // do nothing
}

- (id) autorelease
{
  return self;
}
*/
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
