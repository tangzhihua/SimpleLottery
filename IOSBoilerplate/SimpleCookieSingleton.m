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
    _cookieCache = [[NSMutableDictionary alloc] initWithCapacity:10];
  }
  
  return self;
}

+ (SimpleCookieSingleton *) sharedInstance {
  static SimpleCookieSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
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
