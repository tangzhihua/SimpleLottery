//
//  DomainProtocolNetHelper.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "DomainProtocolNetHelperSingleton.h"
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






@interface DomainProtocolNetHelperSingleton()

@end









@implementation DomainProtocolNetHelperSingleton {
	/**
	 * 网络请求索引计数器
	 */
	NSInteger _netRequestIndexCounter;
	
	/**
	 * 当前正在并发执行的 "网络请求内部事件(NetRequestEvent)" 缓存集合
	 */
	NSMutableDictionary *_synchronousNetRequestEventBuf;
	/**
	 * 当前正在并发的网络请求线程缓存集合 (DomainBeanNetThread)
	 */
	NSMutableDictionary *_synchronousNetThreadBuf;
}

#pragma mark -
#pragma mark GlobalDataCacheForMemorySingleton Singleton Implementation

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
    
    //
    _netRequestIndexCounter = 0;
    //
    _synchronousNetRequestEventBuf = [[NSMutableDictionary alloc] initWithCapacity:100];
    //
    _synchronousNetThreadBuf = [[NSMutableDictionary alloc] initWithCapacity:100];
  }
  
  return self;
}

+ (DomainProtocolNetHelperSingleton *) sharedInstance {
  static DomainProtocolNetHelperSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}


#pragma mark -
#pragma mark 发起一个后台接口的网络请求线程
/**
 * @param context
 * @param netRequestDomainBean
 * @param requestEvent
 * @param netRespondDelegate
 * @param extraHttpRequestParameterMap 此参数是为那种需要兼容不同HTTP参数的情况, 是不好的服务器设计
 * @return
 */
- (NSInteger) requestDomainProtocolWithContext:(id) context
                          andRequestDomainBean:(id) netRequestDomainBean
                               andRequestEvent:(NSUInteger) requestEventEnum
                            andRespondDelegate:(id) netRespondDelegate
               andExtraHttpRequestParameterMap:(NSDictionary *) extraHttpRequestParameterMap {
  
  // 这里要加线程锁, 不过还未清楚iOS线程保护机制
  {
    
    NSInteger returnValue = IDLE_NETWORK_REQUEST_ID;
    const NSInteger netRequestIndex = ++_netRequestIndexCounter;
    
    PRPLog(@" ");
    PRPLog(@" ");
    PRPLog(@" ");
    PRPLog(@"%@%i%@", @"<<<<<<<<<<     Request a domain protocol begin (" , netRequestIndex , @")     >>>>>>>>>>");
    PRPLog(@" ");
    
    do {
      if (context == nil || netRequestDomainBean == nil || netRespondDelegate == nil) {
        PRPLog(@"requestDomainProtocolWithContext:入参中有空参数.");
        break;
      }
      
      if (![netRespondDelegate conformsToProtocol:@protocol(IDomainNetRespondCallback)]) {
				
        PRPLog(@"requestDomainProtocolWithContext:参数 netRespondDelegate 未实现 IDomainNetRespondCallback 接口");
        break;
      }
      
      /**
       * 将 "网络请求业务Bean" 的 完整class name 作为和这个业务Bean对应的"业务接口" 绑定的所有相关的处理算法的唯一识别Key
       */
      NSString *abstractFactoryMappingKey = NSStringFromClass([netRequestDomainBean class]);
      PRPLog(@"%@%i", @"request index--> ", netRequestIndex);
      PRPLog(@"%@%@", @"abstractFactoryMappingKey--> ", abstractFactoryMappingKey);
      PRPLog(@"%@%i", @"request event enum --> ", requestEventEnum);
      PRPLog(@"%@%@", @"net callback delegate class--> ", NSStringFromClass([netRespondDelegate class]));
      
      
      // 这里的设计使用了 "抽象工厂" 设计模式
      id domainBeanAbstractFactoryObject = [[DomainBeanAbstractFactoryCacheSingleton sharedInstance] getDomainBeanAbstractFactoryObjectByKey:abstractFactoryMappingKey];
      
      if (![domainBeanAbstractFactoryObject conformsToProtocol:@protocol(IDomainBeanAbstractFactory)]) {
        PRPLog(@"必须实现 IDomainBeanAbstractFactory 接口");
        break;
      }
      
      // 获取当前业务网络接口, 对应的URL
			/*
			 NSString *url = [domainBeanAbstractFactoryObject getURL];
			 if ([url length] <= 0) {
			 PRPLog(@"当前接口的 url 不能为空 ! ");
			 break;
			 }
			 */
      // 组成说明 : MainUrl(http://124.65.163.102:819) + MainPtah(/app) + SpecialPath(/....)
			//url = [NSString stringWithFormat:@"%@%@%@", kUrlConstant_MainUrl, kUrlConstant_MainPtah, url];
      NSString *url = [NSString stringWithFormat:@"%@%@", kUrlConstant_MainUrl, kUrlConstant_MainPtah];
      PRPLog(@"url-->%@", url);
      
      // HTTP 请求方法类型, 默认是GET
      NSString *httpRequestMethod = @"GET";
      
      /**
       * 处理HTTP 请求实体数据, 如果有实体数据的话, 就设置 RequestMethod 为 "POST" 目前POST 和 GET的认定标准是, 有附加参数就使用POST, 没有就使用GET(这里要跟后台开发团队事先约定好)
       */
      id parseDomainBeanToDataDictionary = [domainBeanAbstractFactoryObject getParseDomainBeanToDDStrategy];
      // 要上传服务器的实体数据
      NSData *httpEntityData = nil;
      do {
        if (![parseDomainBeanToDataDictionary conformsToProtocol:@protocol(IParseDomainBeanToDataDictionary)]) {
          // 没有额外的数据需要上传服务器
          break;
        }
        
				/**
				 * 由于我们的接口中有固定的参数那么我们需要在这里将固定的参数加入
				 */
				NSDictionary *publicDD = [GlobalDataCacheForDataDictionarySingleton sharedInstance].publicNetRequestParameters;
				
        /**
         * 首先获取目标 "网络请求业务Bean" 对应的 "业务协议参数字典 domainParams" (字典由K和V组成,K是"终端应用与后台通信接口协议.doc" 文档中的业务协议关键字, V就是具体的值.)
         */
        NSDictionary *domainDD = [parseDomainBeanToDataDictionary parseDomainBeanToDataDictionary:netRequestDomainBean];
        if ([domainDD count] <= 0) {
          // 没有额外的数据需要上传服务器
          break;
        }
        PRPLog(@"domainParams-->%@", [domainDD description]);
        
				// 完整的 "数据字典"
				NSMutableDictionary *fullDataDictionary = [NSMutableDictionary dictionaryWithDictionary:publicDD];
				[fullDataDictionary addEntriesFromDictionary:domainDD];
				
				
        // 然后将业务参数字典, 拼装成HTTP请求实体字符串
        // 业务字典是 Map<String, String> 格式的, 在这里要完成对 Map<String, String>格式的数据再次加工,
        // 比如 "key1=value1, key2=value2" 或者 "JSON格式" 或者 "XML格式" 或者 "自定义格式"
        httpEntityData = [[[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRequestEntityDataPackage] packageNetRequestEntityDataWithDomainDataDictionary:fullDataDictionary];
        
        // 最终确认确实需要使用POST方式发送数据
        httpRequestMethod = @"POST";
      } while (NO);
      
      if ([httpEntityData length] <= 0 && [httpRequestMethod isEqualToString:@"POST"]) {
        // 这里我们已经和后台定了协议, 只要有附属数据需要上传服务器, 就使用 POST 方式
        break;
      }
      
      
      // TODO : 这里将来要提出一个方法
      NSMutableDictionary *httpRequestParameterMap = [NSMutableDictionary dictionary];
      [httpRequestParameterMap setObject:url
                                  forKey:kHttpNetworkEngineParameterEnum_URL];
      [httpRequestParameterMap setObject:httpRequestMethod
                                  forKey:kHttpNetworkEngineParameterEnum_REQUEST_METHOD];
      if (httpEntityData != nil) {
        [httpRequestParameterMap setObject:httpEntityData
                                    forKey:kHttpNetworkEngineParameterEnum_ENTITY_DATA];
      }
      
      [httpRequestParameterMap setObject:[[SimpleCookieSingleton sharedInstance] cookieString]
                                  forKey:kHttpNetworkEngineParameterEnum_COOKIE];
      [httpRequestParameterMap setObject:@"application/x-www-form-urlencoded"
                                  forKey:kHttpNetworkEngineParameterEnum_CONTENT_TYPE];
      if ([extraHttpRequestParameterMap count] > 0) {
        [httpRequestParameterMap addEntriesFromDictionary:extraHttpRequestParameterMap];
      }
      // //////////////////////////////////////////////////////////////////////////////
      
      
      ///
      /**
       * 创建一个在 "网络间接层" 内部进行流转的 "网络请求事件"对象. 本次进行的网络接口请求的全部数据都在这个 "事件对象" 中进行了保存.
       */
      NetRequestEvent *netRequestEvent
      = [NetRequestEvent netRequestEventWithThreadID:netRequestIndex
                           abstractFactoryMappingKey:abstractFactoryMappingKey
                                    requestEventEnum:requestEventEnum
                                  netRespondDelegate:netRespondDelegate
                             httpRequestParameterMap:httpRequestParameterMap];
      /**
       * 将这个 "内部网络请求事件" 缓存到集合synchronousNetRequestEventBuf中
       */
      [_synchronousNetRequestEventBuf setObject:netRequestEvent
                                         forKey:[NSNumber numberWithInteger:netRequestIndex]];
      
      
      ///
      /**
       * 创建一个全新的网络请求线程
       */
      DomainBeanNetThread *httpRequestThread
      = [DomainBeanNetThread domainBeanNetThreadWithNetRequestEvent:netRequestEvent networkCallback:self];
      /**
       * 将新建的网络线程, 缓存到集合中, 这样就可以随时关闭这个线程.
       */
      [_synchronousNetThreadBuf setObject:httpRequestThread
                                   forKey:[NSNumber numberWithInteger:netRequestIndex]];
      
      PRPLog(@"NetRequestEventBuf:count=%i", _synchronousNetRequestEventBuf.count);
      PRPLog(@"NetThreadBuf:count=%i", _synchronousNetThreadBuf.count);
      
      PRPLog(@" ");
      PRPLog(@" ");
      PRPLog(@" ");
      PRPLog(@"%@%i%@", @"<<<<<<<<<<     Request a domain protocol end (" , netRequestIndex , @")     >>>>>>>>>>");
      PRPLog(@" ");
      PRPLog(@" ");
      PRPLog(@" ");
      
      // 启动线程
      [httpRequestThread start];
      
      returnValue = netRequestIndex;
    } while (NO);
    
    return returnValue;
  }
}


/**
 * 给控制层使用的, 发起一个网络接口请求的方法
 *
 * @param netRequestDomainBean 请求目标业务协议网络接口, 所需要的 "网络请求业务Bean"
 * @param requestEvent 具体控制层定义的, 对本次网络请求的抽象定义, 用于当网络接口返回给控制层的时候, 控制层是根据这个参数来区分是哪个网络请求返回了 (因为控制层具体类只会实现一个 INetRespondDelegate代理回调接口,用于处理当前控制层 所发起的所有类型的网络请求事件).
 * @param netRespondDelegate 网络响应后, 通过此代理来跟控制层进行通讯
 * @return 本次网络请求事件对应的 requestIndex, 控制层通过此索引来取消本次网络请求.如果失败, 返回 IDLE_NETWORK_REQUEST_ID
 */
- (NSInteger) requestDomainProtocolWithContext:(id) context
                          andRequestDomainBean:(id) netRequestDomainBean
                               andRequestEvent:(NSUInteger) requestEvent
                            andRespondDelegate:(id) netRespondDelegate {
  // 这里要加线程锁, 不过还未清楚iOS线程保护机制
  @synchronized(self) {
    
    return [self requestDomainProtocolWithContext:context
                             andRequestDomainBean:netRequestDomainBean
                                  andRequestEvent:requestEvent
                               andRespondDelegate:netRespondDelegate
                  andExtraHttpRequestParameterMap:nil];
  }
  
}



/**
 * 取消一个 "网络请求索引" 所对应的 "网络请求命令"
 *
 * @param netRequestIndex : 网络请求命令对应的索引
 */
- (void) cancelNetRequestByRequestIndex:(NSInteger) netRequestIndex {
  
  // 这里要加线程锁, 不过还未清楚iOS线程保护机制
  @synchronized(self) {
    
    if (netRequestIndex == IDLE_NETWORK_REQUEST_ID) {
			return;
		}
		
    PRPLog(@"-> cancelNetRequestByRequestIndex:[%d]", netRequestIndex);
    
		DomainBeanNetThread *httpRequestThread = [_synchronousNetThreadBuf objectForKey:[NSNumber numberWithInteger:netRequestIndex]];
		if (httpRequestThread != nil) {
			[httpRequestThread interrupt];
		}
  }
}

/**
 * 批量取消网络请求
 *
 * @param key key可能是 netRespondDelegate, 也可能是发起这个网络请求的控制层 context
 */
- (void) bulkCancelNetRequestByKey:(id) key {
  do {
    if (nil == key) {
      break;
    }
    
    if ([_synchronousNetRequestEventBuf count] <= 0) {
      break;
    }
    
    
    NSEnumerator *valueNSEnumerator = [_synchronousNetRequestEventBuf objectEnumerator];
    for (NetRequestEvent *netRequestEvent in valueNSEnumerator) {
      if (netRequestEvent.netRespondDelegate == key) {
        DomainBeanNetThread *httpRequestThread = [_synchronousNetThreadBuf objectForKey:[NSNumber numberWithInteger:netRequestEvent.threadID]];
        if (httpRequestThread != nil) {
          /**
           * 不要在这里做删除动作, 而是通知相关线程自己结束其生命周期, 然后统一在 Handler中释放缓存的对象.
           */
          [httpRequestThread interrupt];
        }
      }
    }
    
  } while (false);
}

/**
 * 取消跟目标 "netRespondDelegate" 相关的所有网络请求
 *
 * @param netRespondDelegate : 网络响应代理
 */
- (void) cancelAllNetRequestWithThisNetRespondDelegate:(id) netRespondDelegate {
  // 这里要加线程锁, 不过还未清楚iOS线程保护机制
  @synchronized(self) {
    [self bulkCancelNetRequestByKey:netRespondDelegate];
  }
}

/**
 * 取消跟目标 "context" 相关的所有网络请求
 *
 * @param netRespondDelegate : 上下文
 */
- (void) cancelAllNetRequestWithThisContext:(id) context {
  // 这里要加线程锁, 不过还未清楚iOS线程保护机制
  @synchronized(self) {
    [self bulkCancelNetRequestByKey:context];
  }
}

#pragma mark -
#pragma mark 实现 INetThreadToNetHelperCallback 接口
- (void) netThreadToNetHelperCallbackWithNetRespondEvent:(in NetRespondEvent *) netRespondEvent
                                               andThread:(in id) netThread {
  
  // 这里要加线程锁, 不过还未清楚iOS线程保护机制
  @synchronized(self) {
    
    PRPLog(@" ");
    PRPLog(@" ");
    PRPLog(@" ");
    PRPLog(@"<-------------  netThreadToNetHelperCallback --> start  --------------->");
    PRPLog(@" ");
    
    NetErrorBean *netErrorBean = [NetErrorBean netErrorBean];
    NetRequestEvent *requestEvent = nil;
    id netRespondDomainBean = nil;
    NSNumber *netRequestIndex = nil;
    
    do {
      
      // 入参检测
      if (netRespondEvent == nil || [netRespondEvent netError] == nil || netThread == nil) {
        // 入参异常 (IllegalArgumentException)
        PRPLog(@"-->method parameter : netRespondEvent or netRespondEvent.getNetError() or netThread or is null.");
        [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
        break;
      }
      if ([netRespondEvent threadID] < 0) {
        // 入参异常 (IllegalArgumentException)
        PRPLog(@"-->method parameter : thread id is invalidate.");
        [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
        break;
      }
      
      
      //
      netRequestIndex = [NSNumber numberWithInteger:netRespondEvent.threadID];
      
      //
      requestEvent = [_synchronousNetRequestEventBuf objectForKey:netRequestIndex];
      if (![requestEvent isKindOfClass:[NetRequestEvent class]]) {
        // 异常 (IllegalArgumentException)
        PRPLog(@"-->在 request event 缓存池中查找目标对象失败.");
        [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
        break;
      }
      
      // 获取 DomainBeanNetThread 层返回的 netErrorBean, 要先判断 DomainBeanNetThread 层执行是否正常
      [netErrorBean setErrorCode:netRespondEvent.netError.errorCode];
      [netErrorBean setErrorType:netRespondEvent.netError.errorType];
      [netErrorBean setErrorMessage:netRespondEvent.netError.errorMessage];
      if (netErrorBean.errorType != NET_ERROR_TYPE_SUCCESS) {
        PRPLog(@"-->网络访问错误 : 可能是->1)客户端网络不通; 2)服务器端网络连接超时; 3)本次网络请求被取消; 4)其他异常.");
        break;
      }
      
      // 获取从服务器得到的网络实体数据(此时是 "生数据")
      NSData *netRawEntityData = netRespondEvent.netRespondRawEntityData;
      if (![netRawEntityData isKindOfClass:[NSData class]] || netRawEntityData.length <= 0) {
        PRPLog(@"-->从服务器端获得的实体数据为空(EntityData), 这种情况有可能是正常的, 比如 退出登录 接口, 服务器就只是通知客户端访问成功, 而不发送任何实体数据. ");
        PRPLog(@"-->也可能是网络超时.");
        PRPLog(@"-->出现这种情况的业务Bean是 --> %@", requestEvent.abstractFactoryMappingKey);
        break;
      }
      if ([netThread isInterrupted]) {
        // 本次网络请求被取消了
        break;
      }
      
      // 将具体网络引擎层返回的 "原始未加工数据byte[]" 解包成 "可识别数据字符串(一般是utf-8)".
      // 这里要考虑网络传回的原生数据有加密的情况, 比如MD5加密的数据, 那么在这里先解密成可识别的字符串
      id netRespondRawEntityDataUnpack = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRespondEntityDataUnpack];
      if (![netRespondRawEntityDataUnpack conformsToProtocol:@protocol(INetRespondRawEntityDataUnpack)]) {
        // 异常 (NullPointerException)
        PRPLog(@"-->解析服务器端返回的实体数据的 \"解码算法类(INetRespondRawEntityDataUnpack)\"是必须要实现的.");
        [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
        break;
      }
      NSString *netUnpackedData = [netRespondRawEntityDataUnpack unpackNetRespondRawEntityDataToUTF8String:netRawEntityData];
      if ([NSString isEmpty:netUnpackedData]) {
        // 异常 (NullPointerException)
        PRPLog(@"-->解析服务器端返回的实体数据失败.");
        [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
        break;
      }
      //PRPLog(@"%@ --> net respond unpacked data(%@)", TAG, netUnpackedData);
      
      if ([netThread isInterrupted]) {
        // 本次网络请求被取消了
        break;
      }
      
      // 检查服务器返回的数据是否有效, 如果无效, 要获取服务器返回的错误码和错误描述信息
      // (比如说某次网络请求成功了, 但是服务器那边没有有效的数据给客户端, 所以服务器会返回错误码和描述信息告知客户端访问结果)
      id serverRespondDataTest = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getServerRespondDataTest];
      if (![serverRespondDataTest conformsToProtocol:@protocol(IServerRespondDataTest)]) {
        // 异常 (NullPointerException)
        PRPLog(@"-->检查服务器返回是否有效(IServerRespondDataTest)的算法类, 是必须实现的");
        [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
        break;
      }
      NetErrorBean *serverRespondDataError = [serverRespondDataTest testServerRespondDataIsValid:netUnpackedData];
      if (serverRespondDataError.errorType != NET_ERROR_TYPE_SUCCESS) {
        // 如果服务器没有有效的数据到客户端, 那么就不需要创建  "网络响应业务Bean"
        PRPLog(@"-->服务器端告知客户端, 本次网络访问未获取到有效数据(具体情况, 可以查看服务器端返回的错误代码和错误信息)");
        PRPLog(@"-->%@", serverRespondDataError);
        [netErrorBean setErrorCode:serverRespondDataError.errorCode];
        [netErrorBean setErrorType:serverRespondDataError.errorType];
        [netErrorBean setErrorMessage:serverRespondDataError.errorMessage];
        break;
      }
      if ([netThread isInterrupted]) {
        // 本次网络请求被取消了
        break;
      }
      
      // 将 "已经解包的可识别数据字符串" 解析成 "具体的业务响应数据Bean"
      // note : 将服务器返回的数据字符串(已经解密, 解码完成了), 解析成对应的 "网络响应业务Bean"
      id domainBeanAbstractFactoryObject
      = [[DomainBeanAbstractFactoryCacheSingleton sharedInstance] getDomainBeanAbstractFactoryObjectByKey:requestEvent.abstractFactoryMappingKey];
      if ([domainBeanAbstractFactoryObject conformsToProtocol:@protocol(IDomainBeanAbstractFactory)]) {
        id domainBeanParseAlgorithm = [domainBeanAbstractFactoryObject getParseNetRespondStringToDomainBeanStrategy];
        if ([domainBeanParseAlgorithm conformsToProtocol:@protocol(IParseNetRespondStringToDomainBean)]) {
          netRespondDomainBean = [domainBeanParseAlgorithm parseNetRespondStringToDomainBean:netUnpackedData];
          if (netRespondDomainBean == nil) {
            // 异常 (NullPointerException)
            PRPLog(@"-->创建 网络响应业务Bean失败, 出现这种情况的业务Bean是 --> %@", requestEvent.abstractFactoryMappingKey);
            [netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
            break;
          }
          
          //PRPLog(@"%@ -->netRespondDomainBean->%@", TAG, netRespondDomainBean);
        }
      }
      // ----------------------------------------------------------------------------
      
    } while (NO);
    
    if (netThread != nil && ![netThread isInterrupted]) {
      if (requestEvent != nil
          && requestEvent.netRespondDelegate != nil
          && [requestEvent.netRespondDelegate conformsToProtocol:@protocol(IDomainNetRespondCallback)]) {
        
        // 通知 "控制层" 本次网络访问的结果
        [requestEvent.netRespondDelegate domainNetRespondHandleInNonUIThread:requestEvent.requestEventEnum
																														 netRequestIndex:[netRequestIndex integerValue]
                                                                   errorBean:netErrorBean
                                                           respondDomainBean:netRespondDomainBean];
        
        
        //// 对于Session过期的处理
        if (netErrorBean.errorType == NET_ERROR_TYPE_SERVER_NET_ERROR) {
          if (kNetErrorCodeWithServerEnum_Needlogin == netErrorBean.errorCode) {
            if ([requestEvent.netRespondDelegate isKindOfClass:[Activity class]]) {
              Activity *activity = (Activity *)requestEvent.netRespondDelegate;
              // Session 已经过期, 已经保证当前Activity的一个完整的网络请求已经完成
              [activity processForSessionHasExpiredInNonUIThread];
            }
          }
        }
				
      }
    } else {
      PRPLog(@"#####  本次网络请求被取消(%d)  #####", [netRequestIndex intValue]);
    }
    
    if (netRequestIndex != nil) {
      /// 清除缓存
      
      // 1.清除 NetRequestEvent (网络请求事件对象)
      [_synchronousNetRequestEventBuf removeObjectForKey:netRequestIndex];
      // 2.清除 DomainBeanNetThread (网络线程对象)
      [_synchronousNetThreadBuf removeObjectForKey:netRequestIndex];
    }
    
    PRPLog(@" ");
    PRPLog(@" ");
    PRPLog(@" ");
    PRPLog(@"<-------------  netThreadToNetHelperCallback --> end  --------------->");
    PRPLog(@" ");
    
  }
  
  
}


@end
