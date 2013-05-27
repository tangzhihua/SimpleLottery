//
//  HttpNetworkEngineForNSURLConnection.h
//  airizu
//
//  Created by 唐志华 on 12-12-20.
//
//

#import <Foundation/Foundation.h>
#import "IHttpNetworkEngine.h"

@class NetErrorBean;
@interface HttpNetworkEngineForNSURLConnection : NSObject <IHttpNetworkEngine, NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
  
}

#pragma mark -
#pragma mark 实现 IHttpNetworkEngine 接口
- (NSData *) requestNetByHttpWithHttpRequestParameter:(in NSDictionary *) httpRequestParameterMap
                                   outputNetErrorBean:(out NetErrorBean *) netErrorForOUT;


#pragma mark -
#pragma mark 方便构造
+(id)httpNetworkEngineForNSURLConnection;
@end
