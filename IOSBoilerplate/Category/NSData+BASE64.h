//
//  NSData+BASE64.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import <Foundation/Foundation.h>

@interface NSData (BASE64)
+ (NSData *)decodeBase64:(NSData *)data;
+ (NSString *)encodeBase64:(NSData*)data;
@end
