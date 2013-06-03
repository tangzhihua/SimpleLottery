//
//  BroadcastMessageNetReapondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "BroadcastMessageNetReapondBean.h"

@implementation BroadcastMessageNetReapondBean
-(id)initWithID:(NSNumber *)ID title:(NSString *)title message:(NSString *)message {
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _ID = [ID copy];
		_title = [title copy];
		_message = [message copy];
	}
  
  return self;
}


+(id)broadcastMessageNetReapondBeanWithID:(NSNumber *)ID title:(NSString *)title message:(NSString *)message {
	return  [[BroadcastMessageNetReapondBean alloc] initWithID:ID title:title message:message];
}



#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  RNAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (NSString *)description {
  return descriptionForDebug(self);
}

@end
