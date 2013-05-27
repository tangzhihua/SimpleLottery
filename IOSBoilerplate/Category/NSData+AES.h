//
//  NSData+AES.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

// 加密
- (NSData *)AESEncryptWithPassphrase:(NSString *)pass;
// 解密
- (NSData *)AESDecryptWithPassphrase:(NSString *)pass;
//
- (NSString*)base64Encode;
@end
