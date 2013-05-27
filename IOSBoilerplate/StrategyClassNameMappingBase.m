//
//  StrategyClassNameMappingBase.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "StrategyClassNameMappingBase.h"

static const NSString *const TAG = @"<StrategyClassNameMappingBase>";

@implementation StrategyClassNameMappingBase

//@synthesize strategyClassesNameMappingList = _strategyClassesNameMappingList;

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
    strategyClassesNameMappingList = [[NSMutableDictionary alloc] initWithCapacity:50];
	}
	
	return self;
}

#pragma mark
#pragma mark 通过 key 查找 对应的抽象工厂类 (专为子类准备的)
- (NSString *) getTargetClassNameForKey:(id) key {
  
  NSAssert(key != nil, @"入参 key 不能为空 ! ");
  
  NSString *className = [strategyClassesNameMappingList objectForKey:key];
  return className;
}

@end
