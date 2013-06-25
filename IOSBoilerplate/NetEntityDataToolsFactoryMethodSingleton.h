//
//  NetEntityDataToolsFactoryMethodSingleton.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "INetEntityDataTools.h"

@interface NetEntityDataToolsFactoryMethodSingleton : NSObject <INetEntityDataTools> {
  
}

+ (NetEntityDataToolsFactoryMethodSingleton *) sharedInstance;

#pragma mark 接口 INetEntityDataTools 方法
- (id<INetRequestEntityDataPackage>) getNetRequestEntityDataPackage;
- (id<INetRespondRawEntityDataUnpack>) getNetRespondEntityDataUnpack;
- (id<IServerRespondDataTest>) getServerRespondDataTest;
@end
