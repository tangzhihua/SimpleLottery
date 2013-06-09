//
//  NetEntityDataToolsFactoryMethodSingleton.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "NetEntityDataToolsFactoryMethodSingleton.h"

// 爱日租项目
#import "NetRequestEntityDataPackageForAirizu.h"
#import "NetRespondEntityDataUnpackAirizu.h"
#import "ServerRespondDataTestAirizu.h"

// 如意彩项目
#import "NetRequestEntityDataPackageForRuyicai.h"
#import "NetRespondEntityDataUnpackRuyicai.h"
#import "ServerRespondDataTestRuyicai.h"
#import "ServerRespondDataTestRuyicaiNew.h"

@interface NetEntityDataToolsFactoryMethodSingleton()
@property (nonatomic, retain) id netRequestEntityDataPackage;
@property (nonatomic, retain) id netRespondEntityDataUnpack;
@property (nonatomic, retain) id serverRespondDataTest;
@property (nonatomic, retain) id serverRespondDataTestNew;
@end

@implementation NetEntityDataToolsFactoryMethodSingleton

#pragma mark -
#pragma mark 单例方法群

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
    
    _netRequestEntityDataPackage = [[NetRequestEntityDataPackageForRuyicai alloc] init];
    _netRespondEntityDataUnpack = [[NetRespondEntityDataUnpackRuyicai alloc] init];
    _serverRespondDataTest = [[ServerRespondDataTestRuyicai alloc] init];
    _serverRespondDataTestNew = [[ServerRespondDataTestRuyicaiNew alloc] init];
  }
  
  return self;
}

+ (NetEntityDataToolsFactoryMethodSingleton *) sharedInstance {
  static NetEntityDataToolsFactoryMethodSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark
#pragma mark 实现 INetEntityDataTools 接口的方法
- (id<INetRequestEntityDataPackage>) getNetRequestEntityDataPackage {
  return _netRequestEntityDataPackage;
}
- (id<INetRespondRawEntityDataUnpack>) getNetRespondEntityDataUnpack {
  return _netRespondEntityDataUnpack;
}
- (id<IServerRespondDataTest>) getServerRespondDataTest {
  return _serverRespondDataTest;
}
- (id<IServerRespondDataTestNew>) getServerRespondDataTestNew {
  return _serverRespondDataTestNew;
}
@end
