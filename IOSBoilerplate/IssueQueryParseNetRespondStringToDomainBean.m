//
//  AloneParseNetRespondStringToDomainBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//
#import "IssueQueryParseNetRespondStringToDomainBean.h"

#import "IssueQueryDatabaseFieldsConstant.h"
 

#import "JSONKit.h"

#import "NSDictionary+SafeValue.h"

#import "LotteryIssueInfo.h"

@implementation IssueQueryParseNetRespondStringToDomainBean
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

#pragma mark 实现 IParseNetRespondStringToDomainBean 接口
- (id) parseNetRespondStringToDomainBean:(in NSString *) netRespondString {
  do {
    if ([NSString isEmpty:netRespondString]) {
      PRPLog(@"%@-> 入参 netRespondString 为空 !");
      break;
    }
    
		const char *jsonStringForUTF8 = [netRespondString UTF8String];
		NSError *error = [[NSError alloc] init];
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc] init];
    NSDictionary *jsonRootNSDictionary
    = [jsonDecoder objectWithUTF8String:(const unsigned char *)jsonStringForUTF8
                                 length:(unsigned int)strlen(jsonStringForUTF8)];
    jsonDecoder = nil;
		error = nil;
    
    if (![jsonRootNSDictionary isKindOfClass:[NSDictionary class]]) {
      PRPLog(@"%@-> json 解析失败!");
      break;
    }
    
		/*
    // 关键数据字段检测
    NSString *defaultValueForString = @"";
		NSString *tmp = nil;
		
		//
		NSString *message
    = [jsonRootNSDictionary safeStringObjectForKey:k_IssueQuery_RespondKey_message
                                  withDefaultValue:defaultValueForString];
		//
    tmp = [jsonRootNSDictionary safeStringObjectForKey:k_IssueQuery_RespondKey_batchcode
																			withDefaultValue:defaultValueForString];
		NSNumber *batchcode = [NSNumber numberWithLongLong:[tmp longLongValue]];
		//
    tmp = [jsonRootNSDictionary safeStringObjectForKey:k_IssueQuery_RespondKey_syscurrenttime
																			withDefaultValue:defaultValueForString];
		NSNumber *syscurrenttime = [NSNumber numberWithLongLong:[tmp longLongValue]];
		//
		NSString *starttime
    = [jsonRootNSDictionary safeStringObjectForKey:k_IssueQuery_RespondKey_starttime
                                  withDefaultValue:defaultValueForString];
		//
		NSString *endtime
    = [jsonRootNSDictionary safeStringObjectForKey:k_IssueQuery_RespondKey_endtime
                                  withDefaultValue:defaultValueForString];
    //
    tmp = [jsonRootNSDictionary safeStringObjectForKey:k_IssueQuery_RespondKey_time_remaining
																			withDefaultValue:defaultValueForString];
		NSNumber *time_remaining = [NSNumber numberWithLongLong:[tmp longLongValue]];
    
		LotteryIssueInfo *lotteryIssueInfo = [LotteryIssueInfo lotteryIssueInfoWithMessage:message batchcode:batchcode syscurrenttime:syscurrenttime starttime:starttime endtime:endtime time_remaining:time_remaining];
    return lotteryIssueInfo;
		*/
    
    
    LotteryIssueInfo *lotteryIssueInfo = [[LotteryIssueInfo alloc] initWithDictionary:jsonRootNSDictionary];
    return lotteryIssueInfo;
  } while (NO);
  
  return nil;
}

@end
