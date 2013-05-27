//
//  BaiduLBSSingleton.h
//  airizu
//
//  Created by 唐志华 on 13-1-7.
//
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface BaiduLBSSingleton : NSObject <BMKGeneralDelegate>{
  
}

// 百度MapAPI的管理类
@property (nonatomic, readonly, strong) BMKMapManager *baiduMapManager;

+ (BaiduLBSSingleton *) sharedInstance;


#pragma mark -
#pragma mark 实现 BMKGeneralDelegate 接口
///通知Delegate

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError;

/**
 *返回授权验证错误
 *@param iError 错误号 : BMKErrorPermissionCheckFailure 验证失败
 */
- (void)onGetPermissionState:(int)iError;

#pragma mark - 
#pragma mark - 实例方法群
- (void)initializeMapManager;
- (void)releaseMapManager;
- (BOOL)gpsIsEnable;
- (BOOL)openGPS;
@end
