//
//  SoftwareUpdateNetRequestBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "SoftwareUpdateNetRequestBean.h"

@implementation SoftwareUpdateNetRequestBean
-(id)initWithRandomNumber:(NSString *)randomNumber isEmulator:(NSNumber *)isEmulator {
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _randomNumber = [randomNumber copy];
		_isEmulator = [isEmulator copy];
		
	}
  
  return self;
}


+(id)softwareUpdateNetRequestBeanWithRandomNumber:(NSString *)randomNumber isEmulator:(NSNumber *)isEmulator {
	return  [[SoftwareUpdateNetRequestBean alloc] initWithRandomNumber:randomNumber isEmulator:isEmulator];
}



#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (NSString *)description {
  return descriptionForDebug(self);
}

@end
