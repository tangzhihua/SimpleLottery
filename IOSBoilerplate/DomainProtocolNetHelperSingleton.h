//
//  DomainProtocolNetHelper.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import <Foundation/Foundation.h>
#import "INetThreadToNetHelperCallback.h"

/**
 * 发起一个网络请求失败的标识
 */
#define IDLE_NETWORK_REQUEST_ID (-2012)

// 业务Bean网络请求 外观层
@interface DomainProtocolNetHelperSingleton : NSObject <INetThreadToNetHelperCallback> {
  
}

+ (DomainProtocolNetHelperSingleton *) sharedInstance;

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
                            andRespondDelegate:(id) netRespondDelegate;

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
                               andRequestEvent:(NSUInteger) requestEvent
                            andRespondDelegate:(id) netRespondDelegate
               andExtraHttpRequestParameterMap:(NSDictionary *) extraHttpRequestParameterMap;

/**
 * 取消一个 "网络请求索引" 所对应的 "网络请求命令"
 *
 * @param netRequestIndex : 网络请求命令对应的索引
 */
- (void) cancelNetRequestByRequestIndex:(NSInteger) netRequestIndex;

/**
 * 取消跟目标 "netRespondDelegate" 相关的所有网络请求
 *
 * @param netRespondDelegate : 网络响应代理
 */
- (void) cancelAllNetRequestWithThisNetRespondDelegate:(id) netRespondDelegate;

/**
 * 取消跟目标 "context" 相关的所有网络请求
 *
 * @param netRespondDelegate : 上下文
 */
- (void) cancelAllNetRequestWithThisContext:(id) context;


#pragma mark 实现 INetThreadToNetHelperCallback 接口
- (void) netThreadToNetHelperCallbackWithNetRespondEvent:(in NetRespondEvent *) netRespondEvent
                                               andThread:(in id) netThread;
@end
