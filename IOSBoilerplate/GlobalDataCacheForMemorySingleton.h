//
//  GlobalDataCache.h
//  
//
//  Created by user on 12-9-13.
//
//  内存级别缓存
//
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@class UserLoggedInfo;
@class BMKUserLocation;
@class BMKAddrInfo;
@class SoftwareUpdateNetRespondBean;

@interface GlobalDataCacheForMemorySingleton : NSObject {
  
}

// 用户第一次启动App
@property (nonatomic, assign) BOOL isFirstStartApp;
// 是否需要在app启动时, 显示 "初学者指南界面"
@property (nonatomic, assign, setter=setNeedShowBeginnerGuide:) BOOL isNeedShowBeginnerGuide;
// 是否需要自动登录的标志
@property (nonatomic, assign, setter=setNeedAutologin:) BOOL isNeedAutologin;

 

// 
@property (nonatomic, strong) SoftwareUpdateNetRespondBean *softwareUpdateNetRespondBean;
// 欢迎界面广告图片的ID
@property (nonatomic, copy) NSString *adImageIDForLatest;
// 是否要显示从服务器下载的广告图片
@property (nonatomic, assign) BOOL isShowAdImageFromServer;
// 开机广告图片
@property (nonatomic, strong) UIImage *adImage;

// 用户登录成功后, 服务器返回的信息(判断有无此对象来判断当前用户是否已经登录)
@property (nonatomic, strong) UserLoggedInfo *userLoggedInfo;

// 用户最后一次登录成功时的 randomNumber
@property (nonatomic, copy) NSString *randomNumberForLastSuccessfulLogon;
// 用户最后一次登录成功时的用户名
@property (nonatomic, copy) NSString *usernameForLastSuccessfulLogon;
// 用户最后一次登录成功时的密码
@property (nonatomic, copy) NSString *passwordForLastSuccessfulLogon;



// 用户最后一次的 "附近" 坐标 (这里使用的是百度的LBS库)
@property (nonatomic, strong) BMKUserLocation *lastLocation;
// 用户最后一次的 "附近" 位置信息 (这里使用的是百度的LBS库)
@property (nonatomic, strong) BMKAddrInfo *lastMKAddrInfo;


// 本地缓存目录大小
@property (nonatomic, readonly) NSUInteger localCacheSize;


// 本地配置的彩票字典 (目前用本地配置的方式来控制哪些彩票处于激活状态)
@property (nonatomic, strong) NSArray *lotteryDictionaryList;


/// 用户可以自己配置在购彩大厅中所要显示的彩票, 分别保存在下面两个 NSArray 中.
// 在主菜单显示的彩票列表
@property (nonatomic, strong) NSMutableArray *lotteryListForShow;
// 用户隐藏的彩票列表
@property (nonatomic, strong) NSMutableArray *lotteryListForHide;


#pragma mark -
#pragma mark 单例
+ (GlobalDataCacheForMemorySingleton *) sharedInstance;
@end
