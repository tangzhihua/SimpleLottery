//
//  TodayOpenPrizeParseDomainBeanToDD.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-12.
//
//

#import "IParseDomainBeanToDataDictionary.h"

@interface LotterySalesStatusParseDomainBeanToDD : NSObject <IParseDomainBeanToDataDictionary> {
  
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean;
@end