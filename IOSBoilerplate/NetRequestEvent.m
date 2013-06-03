//
//  NetRequestEvent.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "NetRequestEvent.h"
#import "IDomainNetRespondCallback.h"

@implementation NetRequestEvent

-(id)    initWithThreadID:(NSInteger)threadID
abstractFactoryMappingKey:(NSString *)abstractFactoryMappingKey
         requestEventEnum:(NSUInteger)requestEventEnum
       netRespondDelegate:(id<IDomainNetRespondCallback>)netRespondDelegate
  httpRequestParameterMap:(NSDictionary *)httpRequestParameterMap {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _threadID                  = threadID;
    _abstractFactoryMappingKey = abstractFactoryMappingKey;
    _requestEventEnum          = requestEventEnum;
    _netRespondDelegate        = netRespondDelegate;
    _httpRequestParameterMap   = [NSDictionary dictionaryWithDictionary:httpRequestParameterMap];
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)netRequestEventWithThreadID:(NSInteger)threadID
       abstractFactoryMappingKey:(NSString *)abstractFactoryMappingKey
                requestEventEnum:(NSUInteger)requestEventEnum
              netRespondDelegate:(id<IDomainNetRespondCallback>)netRespondDelegate
         httpRequestParameterMap:(NSDictionary *)httpRequestParameterMap {
  
  return [[NetRequestEvent alloc] initWithThreadID:threadID
												 abstractFactoryMappingKey:abstractFactoryMappingKey
																	requestEventEnum:requestEventEnum
																netRespondDelegate:netRespondDelegate
													 httpRequestParameterMap:httpRequestParameterMap];
}

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  RNAssert(NO, @"Can not use the default init method!");
  
  return nil;
}




@end
