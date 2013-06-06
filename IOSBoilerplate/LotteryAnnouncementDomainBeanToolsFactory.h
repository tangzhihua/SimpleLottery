//
//  LotteryAnnouncementDomainBeanToolsFactory.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import <Foundation/Foundation.h>

#import "IDomainBeanAbstractFactory.h"

@interface LotteryAnnouncementDomainBeanToolsFactory : NSObject <IDomainBeanAbstractFactory> {
  
}

#pragma mark 实现 IDomainBeanAbstractFactory 接口
/**
 * 将当前业务Bean, 解析成跟后台数据接口对应的数据字典
 * @return
 */
- (id<IParseDomainBeanToDataDictionary>) getParseDomainBeanToDDStrategy;

/**
 * 将网络返回的数据字符串, 解析成当前业务Bean
 * @return
 */
- (id<IParseNetRespondStringToDomainBean>) getParseNetRespondStringToDomainBeanStrategy;

/**
 * 当前业务Bean, 对应的URL地址.
 * @return
 */
- (NSString *) getURL;
@end