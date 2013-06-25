//
//  NetRespondEntityDataUnpackRuyicai.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import "NetRespondEntityDataUnpackForRuyicai.h"

#import "NSData+AES.h"
#import "NSData+BASE64.h"
#import "NSData+ZIP.h"
#import "MacroConstantForThisProject.h"


#import "JSONKit.h"
static const NSString *const TAG = @"<NetRespondEntityDataUnpackRuyicai>";

@implementation NetRespondEntityDataUnpackForRuyicai
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 INetRespondRawEntityDataUnpack 接口
- (NSString *) unpackNetRespondRawEntityDataToUTF8String:(in NSData *) rawData {
  if (rawData == nil) {
    // 入参异常
    return nil;
  }
  
	// 将 "原生数据" 进行 "AES" 解密
	NSData *entityDataOfDecrypt = [rawData AESDecryptWithPassphrase:kAESKey];
	// 将解密后的 "原生数据" 进行 "Base64解码"
	NSData *entityDataOfDecodeBase64 = [NSData decodeBase64:entityDataOfDecrypt];
	// 将解码后的 "原生数据" 进行 "ZIP解压缩"
	NSData *entityDataOfUncompressZipped = [NSData uncompressZippedData:entityDataOfDecodeBase64];
	// 将解压缩后的 "原生数据" 转成 "UTF-8字符串"
	NSString *stringOfUTF8 = [[NSString alloc] initWithData:entityDataOfUncompressZipped encoding:NSUTF8StringEncoding];
	
  return stringOfUTF8;
}
@end