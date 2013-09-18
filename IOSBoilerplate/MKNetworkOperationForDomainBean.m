//
//  MyMKNetworkOperation.m
//  ruyicai
//
//  Created by 唐志华 on 13-9-17.
//
//

#import "MKNetworkOperationForDomainBean.h"
#import "INetRespondRawEntityDataUnpack.h"
#import "NetEntityDataToolsFactoryMethod.h"
#import "IServerRespondDataTest.h"

@implementation MKNetworkOperationForDomainBean
/*!
 *  @abstract Overridable custom method where you can add your custom business logic error handling
 *
 *  @discussion
 *	This optional method can be overridden to do custom error handling. Be sure to call [super operationSucceeded] at the last.
 *  For example, a valid HTTP response (200) like "Item not found in database" might have a custom business error code
 *  You can override this method and called [super failWithError:customError]; to notify that HTTP call was successful but the method
 *  ended as a failed call
 *
 */
-(void) operationSucceeded {
  
  NSString *errorMessage = nil;
  do {
    NSData *netRawEntityData = [self responseData];
    if (![netRawEntityData isKindOfClass:[NSData class]] || netRawEntityData.length <= 0) {
      errorMessage = @"-->从服务器端获得的实体数据为空(EntityData), 这种情况有可能是正常的, 比如 退出登录 接口, 服务器就只是通知客户端访问成功, 而不发送任何实体数据. 也可能是网络超时.";
      PRPLog(errorMessage);
      
      break;
    }
    
    //
    id<INetEntityDataTools> netEntityDataTools = [[NetEntityDataToolsFactoryMethod alloc] init];
    
    // 将具体网络引擎层返回的 "原始未加工数据byte[]" 解包成 "可识别数据字符串(一般是utf-8)".
    // 这里要考虑网络传回的原生数据有加密的情况, 比如MD5加密的数据, 那么在这里先解密成可识别的字符串
    id<INetRespondRawEntityDataUnpack> netRespondRawEntityDataUnpackMethod = [netEntityDataTools getNetRespondEntityDataUnpackStrategyAlgorithm];
    if (![netRespondRawEntityDataUnpackMethod conformsToProtocol:@protocol(INetRespondRawEntityDataUnpack)]) {
      errorMessage = @"-->解析服务器端返回的实体数据的 \"解码算法类(INetRespondRawEntityDataUnpack)\"是必须要实现的.";
      RNAssert(NO, @"%@", errorMessage);
      break;
    }
    NSString *netUnpackedDataOfUTF8String = [netRespondRawEntityDataUnpackMethod unpackNetRespondRawEntityDataToUTF8String:netRawEntityData];
    if ([NSString isEmpty:netUnpackedDataOfUTF8String]) {
      errorMessage = @"-->解析服务器端返回的实体数据失败, 在netRawEntityData不为空的时候, netUnpackedDataOfUTF8String是绝对不能为空的.";
      RNAssert(NO, @"%@", errorMessage);
      break;
    }
    
    // 检查服务器返回的数据是否有效, 如果无效, 要获取服务器返回的错误码和错误描述信息
    // (比如说某次网络请求成功了, 但是服务器那边没有有效的数据给客户端, 所以服务器会返回错误码和描述信息告知客户端访问结果)
    id<IServerRespondDataTest> serverRespondDataTest = [netEntityDataTools getServerRespondDataTestStrategyAlgorithm];
    if (![serverRespondDataTest conformsToProtocol:@protocol(IServerRespondDataTest)]) {
      errorMessage = @"-->检查服务器返回是否有效(IServerRespondDataTest)的算法类, 是必须实现的";
      RNAssert(NO, @"%@", errorMessage);
      break;
    }
    NetRequestErrorBean *serverRespondDataError = [serverRespondDataTest testServerRespondDataIsValid:netUnpackedDataOfUTF8String];
    if (serverRespondDataError.errorCode != 200) {
      errorMessage = @"-->服务器端告知客户端, 本次网络访问未获取到有效数据(具体情况, 可以查看服务器端返回的错误代码和错误信息)";
      PRPLog(errorMessage);
      break;
    }
    
    // 服务器告知客户端, 本次发起的网络请求接口业务上OK.(如 : 登录成功).
    [super operationSucceeded];
    
    return;
  } while (NO);
  
  
  // 服务器返回的数据中包含有 error code, 证明本次发起的网络请求, 业务上失败(如 : 用户名密码错误等..)
  [super operationFailedWithError:[NSError errorWithDomain:errorMessage code:-1 userInfo:nil]];
}

/*!
 *  @abstract Overridable custom method where you can add your custom business logic error handling
 *
 *  @discussion
 *	This optional method can be overridden to do custom error handling. Be sure to call [super operationSucceeded] at the last.
 *  For example, a invalid HTTP response (401) like "Unauthorized" might be a valid case in your app.
 *  You can override this method and called [super operationSucceeded]; to notify that HTTP call failed but the method
 *  ended as a success call. For example, Facebook login failed, but to your business implementation, it's not a problem as you
 *  are going to try alternative login mechanisms.
 *
 */
-(void) operationFailedWithError:(NSError*) error {
  
}
@end
