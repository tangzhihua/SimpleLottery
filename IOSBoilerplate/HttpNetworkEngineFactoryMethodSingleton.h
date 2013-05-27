//
//  HttpNetworkEngineFactoryMethodSingleton.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "IHttpNetworkEngineFactoryMethod.h"

@interface HttpNetworkEngineFactoryMethodSingleton : NSObject <IHttpNetworkEngineFactoryMethod> {
  
}

+ (HttpNetworkEngineFactoryMethodSingleton *) sharedInstance;

#pragma mark 接口 IHttpNetworkEngineFactoryMethod 方法
- (id<IHttpNetworkEngine>) getHttpNetworkEngine;
@end
