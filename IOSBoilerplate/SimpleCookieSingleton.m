//
//  SimpleCookieSingleton.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "SimpleCookieSingleton.h"

static const NSString *const TAG = @"<SimpleCookieSingleton>";

@interface SimpleCookieSingleton()
@property (nonatomic, retain) NSMutableDictionary *cookieCache;
@end

@implementation SimpleCookieSingleton

static SimpleCookieSingleton *singletonInstance = nil;

- (void) initialize {
  _cookieCache = [[NSMutableDictionary alloc] initWithCapacity:10];
}

#pragma mark -
#pragma mark 单例方法群

+ (SimpleCookieSingleton *) sharedInstance
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
#pragma mark 实例方法群
- (void) clearCookie {
  [_cookieCache removeAllObjects];
}

- (void) setObject:(NSString *) value
            forKey:(NSString *) key {
  [_cookieCache setObject:value forKey:key];
}

- (void) removeObjectForKey:(NSString *) key {
  [_cookieCache removeObjectForKey:key];
}

- (NSString *) cookieString {
  NSMutableString *cookieStringBuilder = [NSMutableString string];

  NSEnumerator *keyEnumerator = [_cookieCache keyEnumerator];
  
  for (NSString *key in keyEnumerator) {
    NSString *value = [_cookieCache objectForKey:key];
    if ([value length] > 0) {
      [cookieStringBuilder appendFormat:@"%@=%@;", key, value];
    }
  }
 
  PRPLog(@"CookieString-> %@", cookieStringBuilder);
  return cookieStringBuilder;
}

@end
