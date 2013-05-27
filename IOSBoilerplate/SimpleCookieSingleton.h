//
//  SimpleCookieSingleton.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

@interface SimpleCookieSingleton : NSObject {
  
}

+ (SimpleCookieSingleton *) sharedInstance;

#pragma mark 实例方法群
- (void) clearCookie;
- (void) setObject:(NSString *) value forKey:(NSString *) key;
- (void) removeObjectForKey:(NSString *) key;
- (NSString *) cookieString;
@end
