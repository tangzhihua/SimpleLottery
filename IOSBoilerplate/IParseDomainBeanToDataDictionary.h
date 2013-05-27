//
//  IParseDomainBeanToDataDictionary.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import <Foundation/Foundation.h>

@protocol IParseDomainBeanToDataDictionary <NSObject>

- (NSDictionary *) parseDomainBeanToDataDictionary:(in id) netRequestDomainBean;
@end
