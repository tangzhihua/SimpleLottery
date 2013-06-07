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
#import "NetRequestError.h"
#import "NetRequestOperationOfMKNetworkKit.h"

@interface DomainProtocolNetHelperOfMKNetworkKitSingleton()
@property (nonatomic, strong) MKNetworkEngine *networkEngine;
@property (nonatomic, strong) NSMutableDictionary *synchronousNetRequestBuf;
@property (nonatomic, assign) NSInteger netRequestIndexCounter;
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
		_synchronousNetRequestBuf = [NSMutableDictionary dictionary];
		_netRequestIndexCounter = 0;
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
                                  requestEvent:(NSUInteger) requestEventEnum
                  extraHttpRequestParameterMap:(NSDictionary *) extraHttpRequestParameterMap
                                successedBlock:(DomainNetRespondHandleInUIThreadSuccessedBlock) successedBlock
                                   failedBlock:(DomainNetRespondHandleInUIThreadFailedBlock) failedBlock {
  
  
  
  NSInteger returnValue = IDLE_NETWORK_REQUEST_ID;
	const NSInteger netRequestIndex = ++_netRequestIndexCounter;
	
	PRPLog(@" ");
	PRPLog(@" ");
	PRPLog(@" ");
	PRPLog(@"%@%i%@", @"<<<<<<<<<<     Request a domain protocol begin (" , netRequestIndex , @")     >>>>>>>>>>");
	PRPLog(@" ");
	
	do {
		if (context == nil || netRequestDomainBean == nil || successedBlock == NULL || failedBlock == NULL) {
			PRPLog(@"requestDomainProtocolWithContext:入参中有空参数.");
			//break;
		}
		
		/**
		 * 将 "网络请求业务Bean" 的 完整class name 作为和这个业务Bean对应的"业务接口" 绑定的所有相关的处理算法的唯一识别Key
		 */
		NSString *abstractFactoryMappingKey = NSStringFromClass([netRequestDomainBean class]);
		PRPLog(@"%@%i", @"request index--> ", netRequestIndex);
		PRPLog(@"%@%@", @"abstractFactoryMappingKey--> ", abstractFactoryMappingKey);
		PRPLog(@"%@%i", @"request event enum --> ", requestEventEnum);
		PRPLog(@"%@%@", @"context class--> ", NSStringFromClass([context class]));
		
		
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
		NSMutableDictionary *fullDataDictionary = nil;
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
			fullDataDictionary = [NSMutableDictionary dictionaryWithDictionary:publicDD];
			[fullDataDictionary addEntriesFromDictionary:domainDD];
			
			
			
			
			// 最终确认确实需要使用POST方式发送数据
			httpRequestMethod = @"POST";
		} while (NO);
		
		
		// TODO : 这里将来要提出一个方法
		NSMutableDictionary *httpRequestParameterMap = [NSMutableDictionary dictionary];
		
		
		[httpRequestParameterMap setObject:[[SimpleCookieSingleton sharedInstance] cookieString]
																forKey:@"Cookie"];
		[httpRequestParameterMap setObject:@"application/x-www-form-urlencoded"
																forKey:@"Content-Type"];
		if ([extraHttpRequestParameterMap count] > 0) {
			[httpRequestParameterMap addEntriesFromDictionary:extraHttpRequestParameterMap];
		}
		// //////////////////////////////////////////////////////////////////////////////
		
		NetRequestOperationOfMKNetworkKit *netRequestOperation = (NetRequestOperationOfMKNetworkKit *)[self.networkEngine operationWithURLString:url params:fullDataDictionary httpMethod:httpRequestMethod];
		[netRequestOperation addHeaders:httpRequestParameterMap];
		[netRequestOperation setCustomPostDataEncodingHandler:^NSString *(NSDictionary *postDataDict) {
			
			// 然后将业务参数字典, 拼装成HTTP请求实体字符串
			// 业务字典是 Map<String, String> 格式的, 在这里要完成对 Map<String, String>格式的数据再次加工,
			// 比如 "key1=value1, key2=value2" 或者 "JSON格式" 或者 "XML格式" 或者 "自定义格式"
			NSData *httpEntityData = [[[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRequestEntityDataPackage] packageNetRequestEntityDataWithDomainDataDictionary:fullDataDictionary];
			return [[NSString alloc] initWithData:httpEntityData encoding:NSUTF8StringEncoding];
		} forType:nil];
		[netRequestOperation onCompletion:^(MKNetworkOperation *completedOperation) {
      
			id netRespondDomainBean = nil;
			NSNumber *netRequestIndex = nil;
			
			do {
				
				NSData *netRawEntityData = [completedOperation responseData];
			  if (![netRawEntityData isKindOfClass:[NSData class]] || netRawEntityData.length <= 0) {
					PRPLog(@"-->从服务器端获得的实体数据为空(EntityData), 这种情况有可能是正常的, 比如 退出登录 接口, 服务器就只是通知客户端访问成功, 而不发送任何实体数据. ");
					PRPLog(@"-->也可能是网络超时.");
			 
					break;
				}
				
				// 将具体网络引擎层返回的 "原始未加工数据byte[]" 解包成 "可识别数据字符串(一般是utf-8)".
				// 这里要考虑网络传回的原生数据有加密的情况, 比如MD5加密的数据, 那么在这里先解密成可识别的字符串
				id netRespondRawEntityDataUnpack = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getNetRespondEntityDataUnpack];
				if (![netRespondRawEntityDataUnpack conformsToProtocol:@protocol(INetRespondRawEntityDataUnpack)]) {
					// 异常 (NullPointerException)
					PRPLog(@"-->解析服务器端返回的实体数据的 \"解码算法类(INetRespondRawEntityDataUnpack)\"是必须要实现的.");
				 
					break;
				}
				NSString *netUnpackedData = [netRespondRawEntityDataUnpack unpackNetRespondRawEntityDataToUTF8String:netRawEntityData];
				if ([NSString isEmpty:netUnpackedData]) {
					// 异常 (NullPointerException)
					PRPLog(@"-->解析服务器端返回的实体数据失败.");
			 
					break;
				}
				//PRPLog(@"%@ --> net respond unpacked data(%@)", TAG, netUnpackedData);
				
			 
				
				// 检查服务器返回的数据是否有效, 如果无效, 要获取服务器返回的错误码和错误描述信息
				// (比如说某次网络请求成功了, 但是服务器那边没有有效的数据给客户端, 所以服务器会返回错误码和描述信息告知客户端访问结果)
				id serverRespondDataTest = [[NetEntityDataToolsFactoryMethodSingleton sharedInstance] getServerRespondDataTest];
				if (![serverRespondDataTest conformsToProtocol:@protocol(IServerRespondDataTest)]) {
					// 异常 (NullPointerException)
					PRPLog(@"-->检查服务器返回是否有效(IServerRespondDataTest)的算法类, 是必须实现的");
			 
					break;
				}
				
				NetErrorBean *serverRespondDataError = [serverRespondDataTest testServerRespondDataIsValid:netUnpackedData];
				
				
				// 将 "已经解包的可识别数据字符串" 解析成 "具体的业务响应数据Bean"
				// note : 将服务器返回的数据字符串(已经解密, 解码完成了), 解析成对应的 "网络响应业务Bean"
				id domainBeanAbstractFactoryObject
				= [[DomainBeanAbstractFactoryCacheSingleton sharedInstance] getDomainBeanAbstractFactoryObjectByKey:@"LotteryAnnouncementNetRequestBean"];
				if ([domainBeanAbstractFactoryObject conformsToProtocol:@protocol(IDomainBeanAbstractFactory)]) {
					id domainBeanParseAlgorithm = [domainBeanAbstractFactoryObject getParseNetRespondStringToDomainBeanStrategy];
					if ([domainBeanParseAlgorithm conformsToProtocol:@protocol(IParseNetRespondStringToDomainBean)]) {
						netRespondDomainBean = [domainBeanParseAlgorithm parseNetRespondStringToDomainBean:netUnpackedData];
						if (netRespondDomainBean == nil) {
							// 异常 (NullPointerException)
							 
							break;
						}
						
						//PRPLog(@"%@ -->netRespondDomainBean->%@", TAG, netRespondDomainBean);
					}
				}
				// ----------------------------------------------------------------------------

				
			} while (NO);
			
			
			
			 
			//successedBlock(responseDictionary);
			
		} onError:^(NSError *error){
			
			int i = 0;
			
		}];
		
		
		/**
		 * 将这个 "内部网络请求事件" 缓存到集合synchronousNetRequestEventBuf中
		 */
		[self.synchronousNetRequestBuf setObject:netRequestOperation
																			forKey:[NSNumber numberWithInteger:netRequestIndex]];
		
		[self.networkEngine enqueueOperation:netRequestOperation];
		PRPLog(@"synchronousNetRequestBuf:count=%i", self.synchronousNetRequestBuf.count);
		
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
@end
