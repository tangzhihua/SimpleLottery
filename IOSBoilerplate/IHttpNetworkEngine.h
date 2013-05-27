//
//  IHttpNetworkEngine.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

@class NetErrorBean;
@protocol IHttpNetworkEngine <NSObject>
- (NSData *) requestNetByHttpWithHttpRequestParameter:(in NSDictionary *) httpRequestParameterMap
                                   outputNetErrorBean:(out NetErrorBean *) netErrorForOUT;
@end
