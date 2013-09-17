//
//  MKNetworkEngineSingleton.m
//  ruyicai
//
//  Created by 熊猫 on 13-6-17.
//
//

#import "MKNetworkEngineSingleton.h"
 

@interface MKNetworkEngineSingleton ()
@property (nonatomic, assign) BOOL isConfigFinish;
@end
@implementation MKNetworkEngineSingleton


-(void)config {
  [self useCache];
}

#pragma mark -
#pragma mark Singleton Implementation

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

+ (MKNetworkEngineSingleton *) sharedInstance {
  static MKNetworkEngineSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initWithHostName:kUrlConstant_MainUrl apiPath:kUrlConstant_MainPtah customHeaderFields:nil];});

  if (!singletonInstance.isConfigFinish) {
    [singletonInstance config];
    singletonInstance.isConfigFinish = YES;
  }
  return singletonInstance;
}


@end
