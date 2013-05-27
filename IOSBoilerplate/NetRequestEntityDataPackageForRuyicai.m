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
- (NSData *) packageNetRequestEntityData:(NSDictionary *) domainDD {
  
  if ([domainDD count] <= 0) {
    // 入参为空
    return nil;
  }
  
	// 先将 "数据字典" 转成 "JSON 字符串"
  NSString *entityDataString = [domainDD JSONString];
  
	// 加密 "JSON 字符串"
  NSData *entityData = [entityDataString dataUsingEncoding:NSUTF8StringEncoding];
	NSData *entityDataForEncrypt = [entityData AESEncryptWithPassphrase:kAESKey];
	
	return entityDataForEncrypt;
}
@end
