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

static HttpNetworkEngineFactoryMethodSingleton *singletonInstance = nil;

- (void) initialize {
  //_httpNetworkEngine = [[HttpNetworkEngineForNSURLConnection alloc] init];
}

#pragma mark -
#pragma mark 单例方法群

+ (HttpNetworkEngineFactoryMethodSingleton *) sharedInstance
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

#pragma mark 接口 IHttpNetworkEngineFactoryMethod 方法

- (id<IHttpNetworkEngine>) getHttpNetworkEngine {
  return [HttpNetworkEngineForNSURLConnection httpNetworkEngineForNSURLConnection];
}
@end
