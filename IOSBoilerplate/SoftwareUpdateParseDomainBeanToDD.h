//
//  SoftwareUpdateParseDomainBeanToDD.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>
#import "IParseDomainBeanToDataDictionary.h"

@interface SoftwareUpdateParseDomainBeanToDD : NSObject <IParseDomainBeanToDataDictionary> {
  
}

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean;
@end