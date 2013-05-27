//
//  AloneParseDomainBeanToDD.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//

#import "IParseDomainBeanToDataDictionary.h"

@interface IssueQueryParseDomainBeanToDD : NSObject <IParseDomainBeanToDataDictionary> {
  
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean;
@end