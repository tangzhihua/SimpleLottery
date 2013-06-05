//
//  LotteryBatchCodeInfo.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "LotteryIssueInfo.h"

@interface LotteryIssueInfo ()
// 提示信息
@property (nonatomic, readwrite, strong) NSString *message;
// 期号 如：2012557、2012153
@property (nonatomic, readwrite, strong) NSNumber *batchcode;
//
@property (nonatomic, readwrite, strong) NSNumber *syscurrenttime;
//
@property (nonatomic, readwrite, strong) NSString *starttime;
// 投注截止时间 如：12-07-16 20:59、12-07-18 22:00
@property (nonatomic, readwrite, strong) NSString *endtime;
// 期结剩余时间	单位：秒
@property (nonatomic, readwrite, strong) NSNumber *time_remaining;
@end

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

- (NSString *)description {
  return descriptionForDebug(self);
}

@end
