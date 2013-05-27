//
//  IHttpNetworkEngineFactoryMethod.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

@protocol IHttpNetworkEngine;
@protocol IHttpNetworkEngineFactoryMethod <NSObject>
- (id<IHttpNetworkEngine>) getHttpNetworkEngine;
@end
