//
//  NetRequestEntityDataPackageForRuyicai.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import "NetRequestEntityDataPackageForRuyicai.h"

#import "JSONKit.h"
#import "NSData+AES.h"
#import "MacroConstantForThisProject.h"

static const NSString *const TAG = @"<NetRequestEntityDataPackageForRuyicai>";

@implementation NetRequestEntityDataPackageForRuyicai
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 INetRequestEntityDataPackage 接口方法
- (NSData *) packageNetRequestEntityDataWithDomainDataDictionary:(in NSDictionary *) domainDD {
  
  if ([domainDD count] <= 0) {
    // 入参为空
    return nil;
  }
  
	// 先将 "业务 - 数据字典" 转成 "JSON 字符串"
  NSString *entityDataStringOfJSON = [domainDD JSONString];
  
	// 使用UTF8编码 将 "JSON字符串" 转成 "网络传递实体数据"
  NSData *entityDataOfUTF8StringEncoding = [entityDataStringOfJSON dataUsingEncoding:NSUTF8StringEncoding];
  // 使用 AES 加密 "网络传递实体数据"
	NSData *entityDataOfEncrypt = [entityDataOfUTF8StringEncoding AESEncryptWithPassphrase:kAESKey];
	
	return entityDataOfEncrypt;
}
@end
