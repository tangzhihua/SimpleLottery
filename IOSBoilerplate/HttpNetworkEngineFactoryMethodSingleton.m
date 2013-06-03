//
//  HttpNetworkEngineFactoryMethodSingleton.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "HttpNetworkEngineFactoryMethodSingleton.h"
#import "HttpNetworkEngineForAFNetworking.h"
#import "HttpNetworkEngineForNSURLConnection.h"

static const NSString *const TAG = @"<HttpNetworkEngineFactoryMethodSingleton>";

@interface HttpNetworkEngineFactoryMethodSingleton()
//@property (nonatomic, retain) id httpNetworkEngine;
@end

@implementation HttpNetworkEngineFactoryMethodSingleton
//@synthesize httpNetworkEngine = _httpNetworkEngine;

 

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
  }
  
  return self;
}

+ (HttpNetworkEngineFactoryMethodSingleton *) sharedInstance {
  static HttpNetworkEngineFactoryMethodSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark 接口 IHttpNetworkEngineFactoryMethod 方法

- (id<IHttpNetworkEngine>) getHttpNetworkEngine {
  return [HttpNetworkEngineForNSURLConnection httpNetworkEngineForNSURLConnection];
}
@end
