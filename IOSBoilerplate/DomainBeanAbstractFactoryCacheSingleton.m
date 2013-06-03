//
//  DomainBeanAbstractFactoryCacheSingleton.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "DomainBeanAbstractFactoryCacheSingleton.h"
#import "DomainBeanHelperClassNameMapping.h"
#import "IDomainBeanAbstractFactory.h"

static const NSString *const TAG = @"<DomainBeanAbstractFactoryCacheSingleton>";

@interface DomainBeanAbstractFactoryCacheSingleton()
@property (nonatomic, retain) DomainBeanHelperClassNameMapping *strategyClassNameMapping;
@property (nonatomic, retain) NSMutableDictionary *abstractFactoryObjectBufList;
@end

@implementation DomainBeanAbstractFactoryCacheSingleton

#pragma mark -
#pragma mark GlobalDataCacheForMemorySingleton Singleton Implementation

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
    
    _strategyClassNameMapping = [[DomainBeanHelperClassNameMapping alloc] init];
    _abstractFactoryObjectBufList = [[NSMutableDictionary alloc] initWithCapacity:100];
  }
  
  return self;
}

+ (DomainBeanAbstractFactoryCacheSingleton *) sharedInstance {
  static DomainBeanAbstractFactoryCacheSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark
#pragma mark getDomainBeanAbstractFactoryObjectByKey

 
- (id<IDomainBeanAbstractFactory>) getDomainBeanAbstractFactoryObjectByKey : (NSString *) key {
  do{
    if([key length] <= 0){
      RNAssert(NO, @"入参 key 不能为空 ! ");
      break;
    }
    
    id<IDomainBeanAbstractFactory> abstractFactoryObject = [_abstractFactoryObjectBufList objectForKey:key];
    if (abstractFactoryObject == nil) {
      NSString *className = [_strategyClassNameMapping getTargetClassNameForKey:key];
      if([className length] <= 0){
        RNAssert(NO, @"找不到 key 对应的抽象工厂类 ! ");
        break;
      }
      
      abstractFactoryObject = [[NSClassFromString(className) alloc] init];
      if(abstractFactoryObject == nil){
        RNAssert(NO, @"反射创建抽象工厂类失败 ! ");
        break;
      }
      
      [_abstractFactoryObjectBufList setObject:abstractFactoryObject forKey:key];
    }
    return abstractFactoryObject;
  }while(NO);
  
  return nil;
}
@end
