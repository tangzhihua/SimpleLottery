//
//  DomainBeanHelperClassNameMapping.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "DomainBeanHelperClassNameMapping.h"

// 2.2.1 软件升级
#import "SoftwareUpdateDomainBeanToolsFactory.h"
#import "SoftwareUpdateNetRequestBean.h"

//2.2.2 登录
#import "LogonDomainBeanToolsFactory.h"
#import "LogonNetRequestBean.h"
//2.2.80	当前期号查询
#import "IssueQueryDomainBeanToolsFactory.h"
#import "IssueQueryNetRequestBean.h"
//
#import "LotterySalesStatusDomainBeanToolsFactory.h"
#import "LotterySalesStatusNetRequestBean.h"

static const NSString *const TAG = @"<DomainBeanHelperClassNameMapping>";

@implementation DomainBeanHelperClassNameMapping

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
		/**
		 * 2.2.1 软件升级
		 */
		[strategyClassesNameMappingList setObject:NSStringFromClass([SoftwareUpdateDomainBeanToolsFactory class])
                                       forKey:NSStringFromClass([SoftwareUpdateNetRequestBean class])];
		
		/**
		 * 2.2.2 登录
		 */
    [strategyClassesNameMappingList setObject:NSStringFromClass([LogonDomainBeanToolsFactory class])
                                       forKey:NSStringFromClass([LogonNetRequestBean class])];
		/**
		 * 2.2.80	当前期号查询
		 */
    [strategyClassesNameMappingList setObject:NSStringFromClass([IssueQueryDomainBeanToolsFactory class])
                                       forKey:NSStringFromClass([IssueQueryNetRequestBean class])];

		/**
		 * 2.2.83	购买大厅(其实是彩票销售状态查询)
		 */
    [strategyClassesNameMappingList setObject:NSStringFromClass([LotterySalesStatusDomainBeanToolsFactory class])
                                       forKey:NSStringFromClass([LotterySalesStatusNetRequestBean class])];
		
		
	}
	
	return self;
}

@end
