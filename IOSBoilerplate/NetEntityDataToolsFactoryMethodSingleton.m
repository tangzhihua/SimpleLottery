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
#import "NetRespondEntityDataUnpackForRuyicai.h"
#import "ServerRespondDataTestForRuyicai.h"
#import "NetRespondDataToNSDictionaryForRuyicai.h"

@interface NetEntityDataToolsFactoryMethodSingleton()
@property (nonatomic, strong) id<INetRequestEntityDataPackage> netRequestEntityDataPackageStrategyAlgorithm;
@property (nonatomic, strong) id<INetRespondRawEntityDataUnpack> netRespondEntityDataUnpackStrategyAlgorithm;
@property (nonatomic, strong) id<IServerRespondDataTest> serverRespondDataTestStrategyAlgorithm;
@property (nonatomic, strong) id<INetRespondDataToNSDictionary> netRespondDataToNSDictionaryStrategyAlgorithm;
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
    
    _netRequestEntityDataPackageStrategyAlgorithm = [[NetRequestEntityDataPackageForRuyicai alloc] init];
    _netRespondEntityDataUnpackStrategyAlgorithm = [[NetRespondEntityDataUnpackForRuyicai alloc] init];
    _serverRespondDataTestStrategyAlgorithm = [[ServerRespondDataTestForRuyicai alloc] init];
    _netRespondDataToNSDictionaryStrategyAlgorithm = [[NetRespondDataToNSDictionaryForRuyicai alloc] init];
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
- (id<INetRequestEntityDataPackage>) getNetRequestEntityDataPackageStrategyAlgorithm {
  return self.netRequestEntityDataPackageStrategyAlgorithm;
}
- (id<INetRespondRawEntityDataUnpack>) getNetRespondEntityDataUnpackStrategyAlgorithm {
  return self.netRespondEntityDataUnpackStrategyAlgorithm;
}
- (id<IServerRespondDataTest>) getServerRespondDataTestStrategyAlgorithm {
  return self.serverRespondDataTestStrategyAlgorithm;
}
- (id<INetRespondDataToNSDictionary>) getNetRespondDataToNSDictionaryStrategyAlgorithm {
  return self.netRespondDataToNSDictionaryStrategyAlgorithm;
}
@end
