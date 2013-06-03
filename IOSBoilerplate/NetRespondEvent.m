//
//  NetRespondEvent.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "NetRespondEvent.h"

@implementation NetRespondEvent

- (id) initWithThreadID:(NSInteger)threadID
netRespondRawEntityData:(NSData *)netRespondRawEntityData
               netError:(NetErrorBean *)netError {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _threadID                = threadID;
    _netRespondRawEntityData = netRespondRawEntityData;
    _netError                = netError;
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)netRespondEventWithThreadID:(NSInteger)threadID
         netRespondRawEntityData:(NSData *)netRespondRawEntityData
                        netError:(NetErrorBean *)netError {
  
  return [[NetRespondEvent alloc] initWithThreadID:threadID
													 netRespondRawEntityData:netRespondRawEntityData
																					netError:netError];
}

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  RNAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

@end
