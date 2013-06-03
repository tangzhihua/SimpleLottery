//
//  TodayOpenPrizeNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import "LotterySalesStatusNetRespondBean.h"

@implementation LotterySalesStatusNetRespondBean
- (id) initWithInProgressActivityCount:(NSInteger)inProgressActivityCount lotterySaleInformationMap:(NSDictionary *)lotterySaleInformationMap {
  
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _inProgressActivityCount = inProgressActivityCount;
    _lotterySaleInformationMap = [lotterySaleInformationMap copy];
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)lotterySalesStatusNetRespondBeanWithInProgressActivityCount:(NSInteger)inProgressActivityCount
																			 lotterySaleInformationMap:(NSDictionary *)lotterySaleInformationMap {
  return [[LotterySalesStatusNetRespondBean alloc] initWithInProgressActivityCount:inProgressActivityCount lotterySaleInformationMap:lotterySaleInformationMap];
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
