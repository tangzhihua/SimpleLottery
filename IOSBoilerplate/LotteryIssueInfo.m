//
//  LotteryBatchCodeInfo.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "LotteryIssueInfo.h"

@implementation LotteryIssueInfo

-(id)initWithMessage:(NSString *)message
					 batchcode:(NSNumber *)batchcode
			syscurrenttime:(NSNumber *)syscurrenttime
					 starttime:(NSString *)starttime
						 endtime:(NSString *)endtime
			time_remaining:(NSNumber *)time_remaining {
	
	
  if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _message = [message copy];
		_batchcode = [batchcode copy];
		_syscurrenttime = [syscurrenttime copy];
		_starttime = [starttime copy];
		_endtime = [endtime copy];
		_time_remaining = [time_remaining copy];
  }
  
  return self;
	
}



+(id)lotteryIssueInfoWithMessage:(NSString *)message
											 batchcode:(NSNumber *)batchcode
									syscurrenttime:(NSNumber *)syscurrenttime
											 starttime:(NSString *)starttime
												 endtime:(NSString *)endtime
									time_remaining:(NSNumber *)time_remaining {
	
	return [[LotteryIssueInfo alloc] initWithMessage:message
																				 batchcode:batchcode
																		syscurrenttime:syscurrenttime
																				 starttime:starttime
																					 endtime:endtime
																		time_remaining:time_remaining];
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
