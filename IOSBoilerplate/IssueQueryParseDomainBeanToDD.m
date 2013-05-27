//
//  AloneParseDomainBeanToDD.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//

#import "IssueQueryParseDomainBeanToDD.h"
				
#import "IssueQueryDatabaseFieldsConstant.h"
#import "IssueQueryNetRequestBean.h"

#import "MacroConstantForNetRequestCommand.h"
#import "MacroConstantForNetRequestType.h"
 

@implementation IssueQueryParseDomainBeanToDD

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean {
  NSAssert(netRequestDomainBean != nil, @"入参为空 !");
  
  do {
    if (! [netRequestDomainBean isMemberOfClass:[IssueQueryNetRequestBean class]]) {
      NSAssert(NO, @"传入的业务Bean的类型不符 !");
      break;
    }
    
    const IssueQueryNetRequestBean *requestBean = netRequestDomainBean;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
		
		NSString *value = nil;
		
    /// 必须参数
		//
    [params setObject:k_NetRequestCommand_QueryLot forKey:k_NetRequestCommand_key];
		[params setObject:k_NetRequestType_highFrequency forKey:k_NetRequestType_key];
		
		//彩种
		value = requestBean.lotteryCode;
		if ([NSString isEmpty:value]) {
      NSAssert(NO, @"丢失关键参数 : lotno");
      break;
		}
		[params setObject:value forKey:k_IssueQuery_RequestKey_lotno];
   
    return params;
  } while (NO);
  
  return nil;
}
@end
