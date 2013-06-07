//
//  NetRequestOperationOfMKNetworkKit.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-6.
//
//

#import "NetRequestOperationOfMKNetworkKit.h"

#import "IDomainBeanAbstractFactory.h"
#import "IParseDomainBeanToDataDictionary.h"
#import "DomainBeanAbstractFactoryCacheSingleton.h"
#import "NetEntityDataToolsFactoryMethodSingleton.h"
#import "INetRequestEntityDataPackage.h"
#import "HttpNetworkEngineParameterEnum.h"
#import "INetRespondRawEntityDataUnpack.h"
#import "NetEntityDataToolsFactoryMethodSingleton.h"
#import "IServerRespondDataTest.h"
#import "IDomainNetRespondCallback.h"
#import "IParseNetRespondStringToDomainBean.h"


@implementation NetRequestOperationOfMKNetworkKit

- (void)operationSucceeded
{
  // even when request completes without a HTTP Status code, it might be a benign error
  
  
}

-(void) operationFailedWithError:(NSError *)theError
{
  
  
   
}
@end
