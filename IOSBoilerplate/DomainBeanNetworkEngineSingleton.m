//
//  DomainBeanNetworkEngineSingleton.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-6.
//
//

#import "DomainBeanNetworkEngineSingleton.h"

#import "IDomainBeanAbstractFactory.h"
#import "IParseDomainBeanToDataDictionary.h"
#import "DomainBeanAbstractFactoryCacheSingleton.h"
#import "NetEntityDataToolsFactoryMethodSingleton.h"
#import "INetRequestEntityDataPackage.h"

#import "SimpleCookieSingleton.h"
#import "INetRespondRawEntityDataUnpack.h"
#import "NetEntityDataToolsFactoryMethodSingleton.h"
#import "IServerRespondDataTest.h"
#import "IParseNetRespondStringToDomainBean.h"
#import "INetRespondDataToNSDictionary.h"
#import "BaseModel.h"
#import "Activity.h"

#import "GlobalDataCacheForDataDictionarySingleton.h"



#import "MKNetworkEngine.h"
#import "NetRequestErrorBean.h"


/*
 
 */





@interface DomainBeanNetworkEngineSingleton()

// 网络引擎
@property (nonatomic, strong) MKNetworkEngine *networkEngine;
// 当前在并发请求的 MKNetworkOperation 队列
@property (atomic, strong) NSMutableDictionary *synchronousNetRequestBuf;
// 网络请求索引 计数器
@property (atomic, assign) NSInteger netRequestIndexCounter;
@end









@implementation DomainBeanNetworkEngineSingleton





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
    [_networkEngine useCache];
    
		_synchronousNetRequestBuf = [NSMutableDictionary dictionary];
		_netRequestIndexCounter = 0;
  }
  
  return self;
}

+ (DomainBeanNetworkEngineSingleton *) sharedInstance {
  static DomainBeanNetworkEngineSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}


#pragma mark -
#pragma mark 对外公开的方法

- (NSInteger) requestDomainProtocolWithRequestDomainBean:(id) netRequestDomainBean
																						requestEvent:(NSUInteger) requestEventEnum
																					successedBlock:(DomainNetRespondHandleInUIThreadSuccessedBlock) successedBlock
																						 failedBlock:(DomainNetRespondHandleInUIThreadFailedBlock) failedBlock {
  
  return [self requestDomainProtocolWithRequestDomainBean:netRequestDomainBean requestEvent:requestEventEnum extraHttpRequestParameterMap:nil successedBlock:successedBlock failedBlock:failedBlock];
}

- (NSInteger) requestDomainProtocolWithRequestDomainBean:(id) netRequestDomainBean
																						requestEvent:(NSUInteger) requestEventEnum
														extraHttpRequestParameterMap:(NSDictionary *) extraHttpRequestParameterMap
																					successedBlock:(DomainNetRespondHandleInUIThreadSuccessedBlock) successedBlock
																						 failedBlock:(DomainNetRespondHandleInUIThreadFailedBlock) failedBlock {
  
  
  
  NSInteger returnValue = NETWORK_REQUEST_ID_OF_IDLE;
	const NSInteger netRequestIndex = ++_netRequestIndexCounter;
	
	PRPLog(@" ");
	PRPLog(@" ");
	PRPLog(@" ");
	PRPLog(@"%@%i%@", @"<<<<<<<<<<     Request a domain protocol begin (" , netRequestIndex , @")     >>>>>>>>>>");
	PRPLog(@" ");
	
	do {
		if (netRequestDomainBean == nil || successedBlock == NULL || failedBlock == NULL) {
			PRPLog(@"requestDomainProtocolWithContext:入参中有空参数.");
			break;
		}
		
		/**
		 * 将 "网络请求业务Bean" 的 完整class name 作为和这个业务Bean对应的"业务接口" 绑定的所有相关的处理算法的唯一识别Key
		 */
		NSString *abstractFactoryMappingKey = NSStringFromClass([netRequestDomainBean class]);
		PRPLog(@"%@%i", @"request index--> ", netRequestIndex);
		PRPLog(@"%@%@", @"abstractFactoryMappingKey--> ", abstractFactoryMappingKey);
		PRPLog(@"%@%i", @"request event enum --> ", requestEventEnum);
		
		// 这里的设计使用了 "抽象工厂" 设计模式
		id<IDomainBeanAbstractFactory> domainBeanAbstractFactoryObject = [[DomainBeanAbstractFactoryCacheSingleton sharedInstance] getDomainBeanAbstractFactoryObjectByKey:abstractFactoryMappingKey];
		if (![domainBeanAbstractFactoryObject conformsToProtocol:@protocol(IDomainBeanAbstractFactory)]) {
			PRPLog(@"必须实现 IDomainBeanAbstractFactory 接口");
			break;
		}
		
		// 获取当前业务网络接口, 对应的URL
		// 组成说明 : MainUrl(http://124.65.163.102:819) + MainPtah(/app) + SpecialPath(/....)
		//url = [NSString stringWithFormat:@"%@%@%@", kUrlConstant_MainUrl, kUrlConstant_MainPtah, url];
		NSString *url = [NSString stringWithFormat:@"%@%@", kUrlConstant_MainUrl, kUrlConstant_MainPtah];
		PRPLog(@"url-->%@", url);
		
		// HTTP 请求方法类型, 默认是GET
		NSString *httpRequestMethod = @"GET";
		
    // 完整的 "数据字典"
    NSMutableDictionary *fullDataDictionary = nil;
    
		/**
		 * 处理HTTP 请求实体数据, 如果有实体数据的话, 就设置 RequestMethod 为 "POST" 目前POST 和 GET的认定标准是, 有附加参数就使用POST, 没有就使用GET(这里要跟后台开发团队事先约定好)
		 */
		id<IParseDomainBeanToDataDictionary> parseDomainBeanToDataDictionary = [domainBeanAbstractFactoryObject getParseDomainBeanToDDStrategy];
		
		do {
			if (![parseDomainBeanToDataDictionary conformsToProtocol:@protocol(IParseDomainBeanToDataDictionary)]) {
				// 没有额外的数据需要上传服务器
				break;
			}
			
			/**
			 * 如果我们的接口中有固定的参数, 那么我们可以在这里将固定的参数加入
			 */
			NSDictionary *publicDD = [GlobalDataCacheForDataDictionarySingleton sharedInstance].publicNetRequestParameters;
			
			/**
			 * 首先获取目标 "网络请求业务Bean" 对应的 "业务协议参数字典 domainParams" (字典由K和V组成,K是"终端应用与后台通信接口协议.doc" 文档中的业务协议关键字, V就是具体的值.)
			 */
			NSDictionary *domainDD = [parseDomainBeanToDataDictionary parseDomainBeanToDataDictionary:netRequestDomainBean];
			if (![domainDD isKindOfClass:[NSDictionary class]] || [domainDD count] <= 0) {
				// 没有额外的数据需要上传服务器
				break;
			}
			PRPLog(@"domainParams-->%@", [domainDD description]);
			
			// 拼接完整的 "数据字典"
			fullDataDictionary = [NSMutableDictionary dictionaryWithDictionary:publicDD];
			[fullDataDictionary addEntriesFromDictionary:domainDD];
			
			// 最终确认确实需要使用POST方式发送数据
			httpRequestMethod = @"POST";
		} while (NO);
		
		// 拼接Http请求头
		// TODO : 这里将来要提出一个方法
		NSMutableDictionary *httpRequestParameterMap = [NSMutableDictionary dictionary];
    NSString *cookieString = [[SimpleCookieSingleton sharedInstance] cookieString];
    if (![NSString isEmpty:cookieString]) {
      [httpRequestParameterMap setObject:cookieString
                                  forKey:@"Cookie"];
    }
		
		[httpRequestParameterMap setObject:@"application/x-www-form-urlencoded"
																forKey:@"Content-Type"];
    
    // 有时候, 控制层有些特殊的要求, 所以可以通过这个extraHttpRequestParameterMap参数, 来携带一些特殊的http请求参数
    // ???????? 这里目前的设计还没想好
		if ([extraHttpRequestParameterMap count] > 0) {
			[httpRequestParameterMap addEntriesFromDictionary:extraHttpRequestParameterMap];
		}
		// //////////////////////////////////////////////////////////////////////////////
		
		
		// 创建一个 Http Operation
		MKNetworkOperation *netRequestOperation = [self.networkEngine operationWithURLString:url params:fullDataDictionary httpMethod:httpRequestMethod];
		
		[netRequestOperation addHeaders:httpRequestParameterMap];
		[netRequestOperation setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
			
			if (postDataDict != nil) {
				// 将业务参数字典, 拼装成HTTP请求实体字符串
				// 业务字典是 Map<String, String> 格式的, 在这里要完成对 Map<String, String>格式的数据再次加工,
				// 比如处理成 "key1=value1, key2=value2" 或者 "JSON格式" 或者 "XML格式" 或者 "自定义格式"
        // 可以在这里完成数据的加密工作
				NSData *httpEntityData = [[[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRequestEntityDataPackageStrategyAlgorithm] packageNetRequestEntityDataWithDomainDataDictionary:postDataDict];
				return [[NSString alloc] initWithData:httpEntityData encoding:NSUTF8StringEncoding];
			} else {
				return nil;
			}
			
		} forType:nil];
    
    /**********************************************************************************/
    [netRequestOperation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
      
      // 网络数据正常返回
      
      
      id netRespondDomainBean = nil;
      NetRequestErrorBean *serverRespondDataError = [[NetRequestErrorBean alloc] init];
      serverRespondDataError.errorCode = 200;
      serverRespondDataError.message = @"OK";
      
			do {
				
        // ------------------------------------- >>>
        if ([completedOperation isCancelled]) {
          // 本次网络请求被取消了
          break;
        }
        // ------------------------------------- >>>
        
				NSData *netRawEntityData = [completedOperation responseData];
			  if (![netRawEntityData isKindOfClass:[NSData class]] || netRawEntityData.length <= 0) {
					PRPLog(@"-->从服务器端获得的实体数据为空(EntityData), 这种情况有可能是正常的, 比如 退出登录 接口, 服务器就只是通知客户端访问成功, 而不发送任何实体数据. 也可能是网络超时.");
          serverRespondDataError.errorCode = -1;
					break;
				}
				
        
				// 将具体网络引擎层返回的 "原始未加工数据byte[]" 解包成 "可识别数据字符串(一般是utf-8)".
				// 这里要考虑网络传回的原生数据有加密的情况, 比如MD5加密的数据, 那么在这里先解密成可识别的字符串
				id<INetRespondRawEntityDataUnpack> netRespondRawEntityDataUnpackMethod = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRespondEntityDataUnpackStrategyAlgorithm];
				if (![netRespondRawEntityDataUnpackMethod conformsToProtocol:@protocol(INetRespondRawEntityDataUnpack)]) {
          RNAssert(NO, @"-->解析服务器端返回的实体数据的 \"解码算法类(INetRespondRawEntityDataUnpack)\"是必须要实现的.");
          serverRespondDataError.errorCode = -1;
					break;
				}
				NSString *netUnpackedDataOfUTF8String = [netRespondRawEntityDataUnpackMethod unpackNetRespondRawEntityDataToUTF8String:netRawEntityData];
				if ([NSString isEmpty:netUnpackedDataOfUTF8String]) {
					RNAssert(NO, @"-->解析服务器端返回的实体数据失败, 在netRawEntityData不为空的时候, netUnpackedDataOfUTF8String是绝对不能为空的.");
          serverRespondDataError.errorCode = -1;
					break;
				}
        
        
				// ------------------------------------- >>>
        if ([completedOperation isCancelled]) {
          // 本次网络请求被取消了
          break;
        }
        // ------------------------------------- >>>
        
				
				// 检查服务器返回的数据是否有效, 如果无效, 要获取服务器返回的错误码和错误描述信息
				// (比如说某次网络请求成功了, 但是服务器那边没有有效的数据给客户端, 所以服务器会返回错误码和描述信息告知客户端访问结果)
				id<IServerRespondDataTest> serverRespondDataTest = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getServerRespondDataTestStrategyAlgorithm];
				if (![serverRespondDataTest conformsToProtocol:@protocol(IServerRespondDataTest)]) {
					RNAssert(NO, @"-->检查服务器返回是否有效(IServerRespondDataTest)的算法类, 是必须实现的");
          
					break;
				}
				serverRespondDataError = [serverRespondDataTest testServerRespondDataIsValid:netUnpackedDataOfUTF8String];
				if (serverRespondDataError.errorCode != 200) {
          PRPLog(@"-->服务器端告知客户端, 本次网络访问未获取到有效数据(具体情况, 可以查看服务器端返回的错误代码和错误信息)");
          break;
        }
				
        
        // ------------------------------------- >>>
        if ([completedOperation isCancelled]) {
          // 本次网络请求被取消了
          break;
        }
        // ------------------------------------- >>>
        
        
				// 将 "已经解包的可识别数据字符串" 解析成 "具体的业务响应数据Bean"
				// note : 将服务器返回的数据字符串(已经解密, 解码完成了), 解析成对应的 "网络响应业务Bean"
        // 20130625 : 对于那种单一的项目, 就是不会同时有JSON/XML等多种数据格式的项目, 可以完全使用KVC来生成 NetRespondBean
				id domainBeanAbstractFactoryObject = [[DomainBeanAbstractFactoryCacheSingleton sharedInstance] getDomainBeanAbstractFactoryObjectByKey:abstractFactoryMappingKey];
				if ([domainBeanAbstractFactoryObject conformsToProtocol:@protocol(IDomainBeanAbstractFactory)]) {
          /*
					id domainBeanParseAlgorithm = [domainBeanAbstractFactoryObject getParseNetRespondStringToDomainBeanStrategy];
					if ([domainBeanParseAlgorithm conformsToProtocol:@protocol(IParseNetRespondStringToDomainBean)]) {
						netRespondDomainBean = [domainBeanParseAlgorithm parseNetRespondStringToDomainBean:netUnpackedDataOfUTF8String];
						if (netRespondDomainBean == nil) {
							// 异常 (NullPointerException)
              RNAssert(NO, @"-->创建 网络响应业务Bean失败, 出现这种情况的业务Bean是:%@", abstractFactoryMappingKey);
              serverRespondDataError.errorCode = -1;
							break;
						}
						
						PRPLog(@"%@ -->netRespondDomainBean->", netRespondDomainBean);
					}
           */
          id netRespondDataToNSDictionaryStrategyAlgorithm = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRespondDataToNSDictionaryStrategyAlgorithm];
					if ([netRespondDataToNSDictionaryStrategyAlgorithm conformsToProtocol:@protocol(INetRespondDataToNSDictionary)]) {
            NSDictionary *dic = [netRespondDataToNSDictionaryStrategyAlgorithm netRespondDataToNSDictionary:netUnpackedDataOfUTF8String];
            
						netRespondDomainBean = [[[domainBeanAbstractFactoryObject getClassOfNetRespondBean] alloc] initWithDictionary:dic];
						if (netRespondDomainBean == nil) {
							// 异常 (NullPointerException)
              RNAssert(NO, @"-->创建 网络响应业务Bean失败, 出现这种情况的业务Bean是:%@", abstractFactoryMappingKey);
              serverRespondDataError.errorCode = -1;
							break;
						}
						
						PRPLog(@"%@ -->netRespondDomainBean->", netRespondDomainBean);
					}

				}
        
				// ----------------------------------------------------------------------------
        
				
			} while (NO);
			
      // ------------------------------------- >>>
      if (![completedOperation isCancelled]) {
        if (serverRespondDataError.errorCode != 200) {
          failedBlock(requestEventEnum, netRequestIndex, serverRespondDataError);
        } else {
          successedBlock(requestEventEnum, netRequestIndex, netRespondDomainBean);
        }
      }
      // ------------------------------------- >>>
      
      
      // 删除本地缓存的 MKNetworkOperation
      [self.synchronousNetRequestBuf removeObjectForKey:[NSNumber numberWithInteger:netRequestIndex]];
      PRPLog(@"当前网络接口请求队列长度=%i", self.synchronousNetRequestBuf.count);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
      
      
      // 发生网络请求错误
      // ------------------------------------- >>>
      if (![completedOperation isCancelled]) {
        NetRequestErrorBean *serverRespondDataError = [[NetRequestErrorBean alloc] init];
        serverRespondDataError.errorCode = error.code;
        serverRespondDataError.message = @"Error";
        failedBlock(requestEventEnum, netRequestIndex, serverRespondDataError);
      }
      // ------------------------------------- >>>
      
      
      // 删除本地缓存的 MKNetworkOperation
      [self.synchronousNetRequestBuf removeObjectForKey:[NSNumber numberWithInteger:netRequestIndex]];
      PRPLog(@"当前网络接口请求队列长度=%i", self.synchronousNetRequestBuf.count);
    }];
    
    
		
		
		/**
		 * 将这个 "内部网络请求事件" 缓存到集合synchronousNetRequestEventBuf中
		 */
		[self.synchronousNetRequestBuf setObject:netRequestOperation
																			forKey:[NSNumber numberWithInteger:netRequestIndex]];
		
		[self.networkEngine enqueueOperation:netRequestOperation];
		
		
		PRPLog(@"当前网络接口请求队列长度=%i", self.synchronousNetRequestBuf.count);
		
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@"%@%i%@", @"<<<<<<<<<<     Request a domain protocol end (" , netRequestIndex , @")     >>>>>>>>>>");
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@" ");
		
		
		
		returnValue = netRequestIndex;
	} while (NO);
	
	return returnValue;
}

/**
 * 取消一个 "网络请求索引" 所对应的 "网络请求命令"
 *
 * @param netRequestIndex : 网络请求命令对应的索引
 */
- (void) cancelNetRequestByRequestIndex:(NSInteger) netRequestIndex {
  do {
    if (netRequestIndex == NETWORK_REQUEST_ID_OF_IDLE) {
      break;
    }
    
    NSNumber *indexOfNSNumber = [NSNumber numberWithInteger:netRequestIndex];
    MKNetworkOperation *netRequestOperation = [self.synchronousNetRequestBuf objectForKey:indexOfNSNumber];
    if (nil == netRequestOperation) {
      break;
    }
    
    // 调用 cancel 不会在触发 addCompletionHandler 和 errorHandler, 所以这里直接从请求队列中删除缓存对象.
    [netRequestOperation cancel];
    [self.synchronousNetRequestBuf removeObjectForKey:indexOfNSNumber];
    PRPLog(@"当前网络接口请求队列长度=%i", self.synchronousNetRequestBuf.count);
  } while (NO);
  
}

@end
