//
//  IDomainNetRespondCallback.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import <Foundation/Foundation.h>
#import "NetErrorBean.h"
/**
 * 用于 "外观层 - DomainProtocolNetHelper" 和 "控制层 - Activity" 之间的回调
 *
 * @author zhihua.tang
 */
@protocol IDomainNetRespondCallback <NSObject>

@required
/**
 * 此方法处于非UI线程中
 *
 * @param requestEvent
 * @param errorBean
 * @param respondDomainBean
 */
- (void) domainNetRespondHandleInNonUIThread:(in NSUInteger) requestEvent
														 netRequestIndex:(in NSInteger) netRequestIndex
                                   errorBean:(in NetErrorBean *) errorBean
                           respondDomainBean:(in id) respondDomainBean;
@end
