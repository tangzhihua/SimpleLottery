//
//  SimpleLocationHelperForBaiduLBS.m
//  airizu
//
//  Created by 唐志华 on 13-1-7.
//
//

#import "SimpleLocationHelperForBaiduLBS.h"
#import "BMapKit.h"
#import "GlobalDataCacheForMemorySingleton.h"

static const NSString *const TAG = @"<SimpleLocationHelperForBaiduLBS>";

@interface SimpleLocationHelperForBaiduLBS()
@property(nonatomic, strong) BMKMapView *mapView;
@property(nonatomic, strong) BMKSearch *baiduMKsearch;
@end

@implementation SimpleLocationHelperForBaiduLBS

- (void) dealloc {
	PRPLog(@"dealloc: [0x%x]", [self hash]);
   
}

- (id) init {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    //
    _mapView = [[BMKMapView alloc] init];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    //
    _baiduMKsearch = [[BMKSearch alloc] init];
    _baiduMKsearch.delegate = self;
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+ (id) simpleLocationHelperForBaiduLBS {
  return [[SimpleLocationHelperForBaiduLBS alloc] init];
}

#pragma mark -
#pragma mark 实现 BMKMapViewDelegate 接口
/// MapView的Delegate，mapView通过此类来通知用户对应的事件


/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView {
  PRPLog(@"%@ start locate", TAG);
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView {
  PRPLog(@"%@ stop locate", TAG);
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation {
  
  @synchronized(self) {
    if (userLocation != nil) {
      
      /// 一旦成功收到一次 UserLocation 信息后, 就注销 BMKMapView 的 代理.
      _mapView.delegate = nil;
      
      
      ///
      PRPLog(@"%@ didUpdateUserLocation:latitude=%f, longitude=%f", TAG, userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
      
      [[GlobalDataCacheForMemorySingleton sharedInstance] setLastLocation:userLocation];
      
      if (_locationDelegate != nil) {
        [_locationDelegate locationCallback:userLocation];
        self.locationDelegate = nil;
      }
      
      // 请求用户当前的位置信息
      CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
      BOOL flag = [_baiduMKsearch reverseGeocode:pt];
      if (!flag) {
        PRPLog(@"search failed!");
      }
      
    }
  }
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
  if (error != nil)
		PRPLog(@"%@ locate failed: %@", TAG, [error localizedDescription]);
	else {
		PRPLog(@"%@ locate failed", TAG);
	}
}

#pragma mark -
#pragma mark 实现 BMKSearchDelegate 接口
/**
 *返回地址信息搜索结果
 *@param result 搜索结果
 *@param error 错误号，@see BMKErrorCode
 */
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error {
  
  PRPLog(@"%@ onGetAddrResult", TAG);
  
  do {
    if (error != 0) {
      PRPLog(@"%@ onGetAddrResult:error=%d", TAG, error);
      break;
    }
    
    if (result.addressComponent == nil) {
      PRPLog(@"%@ onGetAddrResult:res.addressComponents is null", TAG);
      break;
    }
    
    /// 一旦成功接收到用户当前位置信息后, 就要及时注销 MKSearch 代理.
    _baiduMKsearch.delegate = nil;
    
    // 获取用户当前位置信息, 不是一次可能成功的, 所以要成功后, 才能停止 didUpdateUserLocation 方法
    _mapView.showsUserLocation = NO;
    
    [[GlobalDataCacheForMemorySingleton sharedInstance] setLastMKAddrInfo:result];
    
    PRPLog(@"地址名称 strAddr=%@", result.strAddr);
    PRPLog(@"地址坐标 geoPt.latitude=%f, geoPt.longitude=%f", result.geoPt.latitude, result.geoPt.longitude);
    PRPLog(@"街道号码 streetNumber=%@", result.addressComponent.streetNumber);
    PRPLog(@"街道名称 streetName=%@", result.addressComponent.streetName);
    PRPLog(@"区县名称 district=%@", result.addressComponent.district);
    PRPLog(@"城市名称 city=%@", result.addressComponent.city);
    PRPLog(@"省份名称 province=%@", result.addressComponent.province);
    
    if (_addrInfoDelegate != nil) {
      [_addrInfoDelegate addrInfoCallback:result];
      self.addrInfoDelegate = nil;
    }
    
  } while (NO);
}

#pragma mark -
#pragma mark 静态方法群
+ (BMKUserLocation *) getLastLocation {
  return [[GlobalDataCacheForMemorySingleton sharedInstance] lastLocation];
}
+ (BMKAddrInfo *) getLastMKAddrInfo {
  return [[GlobalDataCacheForMemorySingleton sharedInstance] lastMKAddrInfo];
}
@end
