//
//  LotteryDictionary.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-4.
//
//

#import "LotteryDictionary.h"

@interface LotteryDictionary ()
@property (nonatomic, readwrite, strong) NSString *key;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *code;
@property (nonatomic, readwrite, strong) UIImage *icon;
@property (nonatomic, readwrite, strong) NSString *ad;
@property (nonatomic, readwrite, assign) BOOL enable;

// 彩票 固定信息(比如竞彩足球, 就是会固定显示 "返奖率高达69%")
@property (nonatomic, readwrite, strong) NSString *fixedInformation;
@end

@implementation LotteryDictionary

-(void) setValue:(id)value forKey:(NSString *)key{
	if ([key isEqualToString:@"icon"]) {
		self.icon = [UIImage imageNamed:value];
	} else {
		[super setValue:value forKey:key];
	}
}
- (NSString *)description {
  return descriptionForDebug(self);
}
@end
