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

static DomainBeanAbstractFactoryCacheSingleton *singletonInstance = nil;

- (void) initialize {
  _strategyClassNameMapping = [[DomainBeanHelperClassNameMapping alloc] init];
  _abstractFactoryObjectBufList = [[NSMutableDictionary alloc] initWithCapacity:100];
}

#pragma mark -
#pragma mark GlobalDataCacheForMemorySingleton Singleton Implementation

+ (DomainBeanAbstractFactoryCacheSingleton *) sharedInstance
{
  if (singletonInstance == nil)
  {
    singletonInstance = [[super allocWithZone:NULL] init];
    
    // initialize the first view controller
    // and keep it with the singleton
    [singletonInstance initialize];
  }
  
  return singletonInstance;
}

/*
+ (id) allocWithZone:(NSZone *)zone
{
  return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
  return self;
}

- (id) retain
{
  return self;
}

- (NSUInteger) retainCount
{
  return NSUIntegerMax;
}

- (oneway void) release
{
  // do nothing
}

- (id) autorelease
{
  return self;
}
*/

#pragma mark
#pragma mark getDomainBeanAbstractFactoryObjectByKey

 
- (id<IDomainBeanAbstractFactory>) getDomainBeanAbstractFactoryObjectByKey : (NSString *) key {
  do{
    if([key length] <= 0){
      NSAssert(NO, @"入参 key 不能为空 ! ");
      break;
    }
    
    id<IDomainBeanAbstractFactory> abstractFactoryObject = [_abstractFactoryObjectBufList objectForKey:key];
    if (abstractFactoryObject == nil) {
      NSString *className = [_strategyClassNameMapping getTargetClassNameForKey:key];
      if([className length] <= 0){
        NSAssert(NO, @"找不到 key 对应的抽象工厂类 ! ");
        break;
      }
      
      abstractFactoryObject = [[NSClassFromString(className) alloc] init];
      if(abstractFactoryObject == nil){
        NSAssert(NO, @"反射创建抽象工厂类失败 ! ");
        break;
      }
      
      [_abstractFactoryObjectBufList setObject:abstractFactoryObject forKey:key];
    }
    return abstractFactoryObject;
  }while(NO);
  
  return nil;
}
@end
