//
//  NSData+BASE64.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import "NSData+BASE64.h"

#import "GTMBase64.h"

@implementation NSData (BASE64)
#pragma mark base64 method
+ (NSData *)decodeBase64:(NSData *)data {
	// 转换到base64
	data = [GTMBase64 decodeData:data];
	return data;
}

+ (NSString *)encodeBase64:(NSData*)data {
	//转换到base64
	data = [GTMBase64 encodeData:data];
	NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}
@end
