//
//  DomainProtocolNetHelperOfMKNetworkKitSingleton.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-6.
//
//

#import "DomainProtocolNetHelperOfMKNetworkKitSingleton.h"

#import "IDomainBeanAbstractFactory.h"
#import "IParseDomainBeanToDataDictionary.h"
#import "DomainBeanAbstractFactoryCacheSingleton.h"
#import "NetEntityDataToolsFactoryMethodSingleton.h"
#import "INetRequestEntityDataPackage.h"
#import "HttpNetworkEngineParameterEnum.h"
#import "SimpleCookieSingleton.h"
#import "NetRequestEvent.h"
#import "DomainBeanNetThread.h"
#import "NetErrorBean.h"
#import "NetErrorTypeEnum.h"
#import "NetRespondEvent.h"
#import "INetRespondRawEntityDataUnpack.h"
#import "NetEntityDataToolsFactoryMethodSingleton.h"
#import "IServerRespondDataTest.h"
#import "IDomainNetRespondCallback.h"
#import "IParseNetRespondStringToDomainBean.h"


#import "Activity.h"

#import "GlobalDataCacheForDataDictionarySingleton.h"



#import "MKNetworkEngine.h"


@interface DomainProtocolNetHelperOfMKNetworkKitSingleton()
@property (nonatomic, strong) MKNetworkEngine *networkEngine;
@end





@implementation DomainProtocolNetHelperOfMKNetworkKitSingleton





#pragma mark -
#pragma mark Singleton Implementation

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码  
    
    _networkEngine = [[MKNetworkEngine alloc] initWithHostName:kUrlConstant_MainUrl apiPath:kUrlConstant_MainPtah customHeaderFields:nil];
  }
  
  return self;
}

+ (DomainProtocolNetHelperOfMKNetworkKitSingleton *) sharedInstance {
  static DomainProtocolNetHelperOfMKNetworkKitSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}


#pragma mark -
#pragma mark 对外公开的方法

- (NSInteger) requestDomainProtocolWithContext:(id) context
                             requestDomainBean:(id) netRequestDomainBean
                                  requestEvent:(NSUInteger) requestEvent
                                successedBlock:(DomainNetRespondHandleInUIThreadSuccessedBlock) successedBlock
                                   failedBlock:(DomainNetRespondHandleInUIThreadFailedBlock) failedBlock {
  
  
  
  
  
  
  
  
  
  
  return 0;
}
@end
