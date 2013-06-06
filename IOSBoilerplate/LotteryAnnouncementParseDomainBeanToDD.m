//
//  LotteryAnnouncementParseDomainBeanToDD.m
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "LotteryAnnouncementParseDomainBeanToDD.h"

#import "LotteryAnnouncementNetRequestBean.h"
#import "MacroConstantForNetRequestCommand.h"
#import "MacroConstantForNetRequestType.h"


@implementation LotteryAnnouncementParseDomainBeanToDD
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
	}
	
	return self;
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean {
  RNAssert(netRequestDomainBean != nil, @"入参为空 !");
  
  do {
    if (! [netRequestDomainBean isMemberOfClass:[LotteryAnnouncementParseDomainBeanToDD class]]) {
      RNAssert(NO, @"传入的业务Bean的类型不符 !");
      break;
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
		
		
    /// 必须参数
		//
    [params setObject:k_NetRequestCommand_QueryLot forKey:k_NetRequestCommand_key];
		[params setObject:k_NetRequestType_winInfo forKey:k_NetRequestType_key];
		
		
    return params;
  } while (NO);
  
  return nil;
}
@end
