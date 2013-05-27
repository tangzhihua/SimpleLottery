//
//  SimpleLocationHelperForBaiduLBS.h
//  airizu
//
//  Created by 唐志华 on 13-1-7.
//
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

// 用户当前坐标回调(经纬度)
@protocol LocationDelegate <NSObject>
- (void) locationCallback:(BMKUserLocation *)userLocation;
@end

// 用户当前位置信息回调(街道号码->街道名称->区县名称->城市名称->省份名称)
@protocol AddrInfoDelegate <NSObject>
- (void) addrInfoCallback:(BMKAddrInfo *)location;
@end


@interface SimpleLocationHelperForBaiduLBS : NSObject <BMKMapViewDelegate, BMKSearchDelegate> {
  
}

@property(nonatomic, weak) id locationDelegate;
@property(nonatomic, weak) id addrInfoDelegate;

#pragma mark -
#pragma mark 方便构造
+ (id) simpleLocationHelperForBaiduLBS;

#pragma mark -
#pragma mark 静态方法群
+ (BMKUserLocation *) getLastLocation;
+ (BMKAddrInfo *) getLastMKAddrInfo;


@end
