//
//  INetThreadToNetHelperCallback.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

/**
 * 用于 "网络访问线程 - DomainBeanNetThread" 和 "外观层 - DomainProtocolNetHelper" 之间的回调
 *
 * @author zhihua.tang
 */
@class NetRespondEvent;
@protocol INetThreadToNetHelperCallback <NSObject>
- (void) netThreadToNetHelperCallbackWithNetRespondEvent:(in NetRespondEvent *) netRespondEvent
                                               andThread:(in id) netThread;
@end
