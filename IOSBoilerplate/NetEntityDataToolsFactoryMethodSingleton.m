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

static const NSString *const TAG = @"<NetEntityDataToolsFactoryMethodSingleton>";

@interface NetEntityDataToolsFactoryMethodSingleton()
@property (nonatomic, retain) id netRequestEntityDataPackage;
@property (nonatomic, retain) id netRespondEntityDataUnpack;
@property (nonatomic, retain) id serverRespondDataTest;
@end

@implementation NetEntityDataToolsFactoryMethodSingleton

static NetEntityDataToolsFactoryMethodSingleton *singletonInstance = nil;

- (void) initialize {
  _netRequestEntityDataPackage = [[NetRequestEntityDataPackageForRuyicai alloc] init];
  _netRespondEntityDataUnpack = [[NetRespondEntityDataUnpackRuyicai alloc] init];
  _serverRespondDataTest = [[ServerRespondDataTestRuyicai alloc] init];
}

#pragma mark -
#pragma mark 单例方法群

+ (NetEntityDataToolsFactoryMethodSingleton *) sharedInstance
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
@end
