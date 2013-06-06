//
//  DomainProtocolNetHelperOfMKNetworkKitSingleton.h
//  ruyicai
//
//  Created by tangzhihua on 13-6-6.
//
//

#import <Foundation/Foundation.h>

@class NetRequestError;



typedef void (^DomainNetRespondHandleInUIThreadSuccessedBlock)(NSUInteger requestEvent, NSInteger netRequestIndex, id respondDomainBean);
typedef void (^DomainNetRespondHandleInUIThreadFailedBlock)(NSUInteger requestEvent, NSInteger netRequestIndex, NetRequestError *error);





@interface DomainProtocolNetHelperOfMKNetworkKitSingleton : NSObject {
  
}


+ (DomainProtocolNetHelperOfMKNetworkKitSingleton *) sharedInstance;



- (NSInteger) requestDomainProtocolWithContext:(id) context
                             requestDomainBean:(id) netRequestDomainBean
                                  requestEvent:(NSUInteger) requestEventEnum
									extraHttpRequestParameterMap:(NSDictionary *) extraHttpRequestParameterMap
                                successedBlock:(DomainNetRespondHandleInUIThreadSuccessedBlock) successedBlock
                                   failedBlock:(DomainNetRespondHandleInUIThreadFailedBlock) failedBlock;



/**
 * 取消一个 "网络请求索引" 所对应的 "网络请求命令"
 *
 * @param netRequestIndex : 网络请求命令对应的索引
 */
- (void) cancelNetRequestByRequestIndex:(NSInteger) netRequestIndex;



/**
 * 取消跟目标 "context" 相关的所有网络请求
 *
 * @param netRespondDelegate : 上下文
 */
- (void) cancelAllNetRequestWithThisContext:(id) context;

@end
