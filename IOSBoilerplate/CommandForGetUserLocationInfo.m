//
//  CommandForGetUserLocationInfo.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForGetUserLocationInfo.h"

static CommandForGetUserLocationInfo *singletonInstance = nil;








@interface CommandForGetUserLocationInfo ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
// 定位用户位置信息
@property (nonatomic, retain) SimpleLocationHelperForBaiduLBS *userLocationForBaiduLBS;
@end







@implementation CommandForGetUserLocationInfo


/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  if (!_isExecuted) {
		_isExecuted = YES;
		
    // 启动 "获取用户当前所在位置信息" 子线程, 因为这个过程很耗时, 所以要 开辟子线程来进行加载
    [NSThread detachNewThreadSelector:@selector(childThreadForLoadingUserLocationInfo) toTarget:self withObject:nil];
  }  

}

+(id)commandForGetUserLocationInfo {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandForGetUserLocationInfo alloc] init];
    singletonInstance.isExecuted = NO;
  }
  return singletonInstance;
}

#pragma mark -
#pragma mark 子线程 ------> "获取用户当前所在位置信息"
- (void) childThreadForLoadingUserLocationInfo {
  
	@autoreleasepool {
    _userLocationForBaiduLBS = [[SimpleLocationHelperForBaiduLBS alloc] init];
		_userLocationForBaiduLBS.locationDelegate = self;
		_userLocationForBaiduLBS.addrInfoDelegate = self;
	} 
}

// 用户当前坐标回调(经纬度)
- (void) locationCallback:(BMKUserLocation *)userLocation {
  // 发送 "获取用户当前经纬度坐标成功" 的广播消息
  
  // 判断用户地址是否已经获取到, 如果已经获取到, 这里就注销代理(因为进入一些特殊的Activity时,
  // 也会主动获取用户当前坐标和地址
  if ([GlobalDataCacheForMemorySingleton sharedInstance].lastMKAddrInfo != nil) {
    _userLocationForBaiduLBS.addrInfoDelegate = nil;
  }
}


// 用户当前位置信息回调(街道号码->街道名称->区县名称->城市名称->省份名称)
- (void) addrInfoCallback:(BMKAddrInfo *)location {
  // 发送 "获取用户当前地址成功" 的广播消息
  
  Intent *intent = [Intent intent];
  [intent setAction:[[NSNumber numberWithUnsignedInteger:kUserNotificationEnum_GetUserAddressSuccess] stringValue]];
  Activity *activity = [Activity activity];
  [activity sendBroadcast:intent];
}
@end
