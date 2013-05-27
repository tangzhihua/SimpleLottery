//
//  AloneNetRequestBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//

#import "IssueQueryNetRequestBean.h"

@implementation IssueQueryNetRequestBean

-(id)initWithLotteryCode:(NSString *)lotteryCode{
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _lotteryCode = [lotteryCode copy];
		
	}
  
  return self;
}


+(id)issueQueryNetRequestBeanWithLotteryCode:(NSString *)lotteryCode{
	return  [[IssueQueryNetRequestBean alloc] initWithLotteryCode:lotteryCode];
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
