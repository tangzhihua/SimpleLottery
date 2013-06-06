//
//  LotteryAnnouncementParseDomainBeanToDD.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import "IParseDomainBeanToDataDictionary.h"

@interface LotteryAnnouncementParseDomainBeanToDD : NSObject <IParseDomainBeanToDataDictionary> {
  
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean;
@end