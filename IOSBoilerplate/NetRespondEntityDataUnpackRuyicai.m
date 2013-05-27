//
//  NetRespondEntityDataUnpackRuyicai.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import "NetRespondEntityDataUnpackRuyicai.h"

#import "NSData+AES.h"
#import "NSData+BASE64.h"
#import "NSData+ZIP.h"
#import "MacroConstantForThisProject.h"


#import "JSONKit.h"
static const NSString *const TAG = @"<NetRespondEntityDataUnpackRuyicai>";

@implementation NetRespondEntityDataUnpackRuyicai
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 INetRespondRawEntityDataUnpack 接口
- (NSString *) unpackNetRespondRawEntityData:(in NSData *) rawData {
  if (rawData == nil) {
    // 入参异常
    return nil;
  }
  
	// 解密
	NSData *entityDataForDecrypt = [rawData AESDecryptWithPassphrase:kAESKey];
	// Base64 解码
	NSData *entityDataForDecodeBase64 = [NSData decodeBase64:entityDataForDecrypt];
	// ZIP解压缩
	NSData *entityDataForUncompressZipped = [NSData uncompressZippedData:entityDataForDecodeBase64];
	// 转成UTF-8字符串
	NSString *stringData = [[NSString alloc] initWithData:entityDataForUncompressZipped encoding:NSUTF8StringEncoding];
	
  return stringData;
}
@end