//
//  AdImageInWelcomePageNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "AdImageInWelcomePageNetRespondBean.h"

@implementation AdImageInWelcomePageNetRespondBean
-(id)initWithIsShowAdImageFromServer:(BOOL)isShowAdImageFromServer
																	ID:(NSString *)ID
														imageUrl:(NSString *)imageUrl {
	
	
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _isShowAdImageFromServer = isShowAdImageFromServer;
		_ID = [ID copy];
		_imageUrl = [imageUrl copy];
  }
  
  return self;
	
}



+(id)adImageInWelcomePageNetRespondBeanWithIsShowAdImageFromServer:(BOOL)isShowAdImageFromServer
																																ID:(NSString *)ID
																													imageUrl:(NSString *)imageUrl {
	
	return [[AdImageInWelcomePageNetRespondBean alloc] initWithIsShowAdImageFromServer:isShowAdImageFromServer ID:ID imageUrl:imageUrl];
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
