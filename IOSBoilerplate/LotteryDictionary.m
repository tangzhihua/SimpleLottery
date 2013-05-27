//
//  LotteryDictionary.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-4.
//
//

#import "LotteryDictionary.h"

@implementation LotteryDictionary
-(id)initWithKey:(NSString *)key
						name:(NSString *)name
						code:(NSString *)code
						icon:(NSString *)icon
							ad:(NSString *)ad
					enable:(BOOL)enable
fixedInformation:(NSString *)fixedInformation{
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _key = [key copy];
		_name = [name copy];
		_code = [code copy];
		_icon = [UIImage imageNamed:icon];
		_ad = [ad copy];
		_enable = enable;
		_fixedInformation = [fixedInformation copy];
	}
  
  return self;
}


+(id)lotteryDictionaryWithKey:(NSString *)key
												 name:(NSString *)name
												 code:(NSString *)code
												 icon:(NSString *)icon
													 ad:(NSString *)ad
											 enable:(BOOL)enable
						 fixedInformation:(NSString *)fixedInformation{
	
	return  [[LotteryDictionary alloc] initWithKey:key name:name code:code icon:icon ad:ad enable:enable fixedInformation:fixedInformation];
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
