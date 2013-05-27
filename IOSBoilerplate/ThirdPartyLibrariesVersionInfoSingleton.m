//
//  ThirdPartyLibrariesVersionInfoSingleton.m
//  airizu
//
//  Created by 唐志华 on 13-2-27.
//
//

#import "ThirdPartyLibrariesVersionInfoSingleton.h"

#import "BMKVersion.h"
#import "MobClick.h"

static const NSString *const TAG = @"<ThirdPartyLibrariesVersionInfoSingleton>";

@implementation ThirdPartyLibrariesVersionInfoSingleton

static ThirdPartyLibrariesVersionInfoSingleton *singletonInstance = nil;

- (void) initialize {
  //
  _BMKVersion = [[NSString alloc] initWithString:BMKGetMapApiVersion()];
  //
  _AlixPayVersion = @"20121026";
  //
  _UMAnalyticsVersion = [[NSString alloc] initWithString:[MobClick getAgentVersion]];
}

#pragma mark -
#pragma mark 单例方法群

+ (ThirdPartyLibrariesVersionInfoSingleton *) sharedInstance
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
@end