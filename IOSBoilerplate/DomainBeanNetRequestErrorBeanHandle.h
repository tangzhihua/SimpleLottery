//
//  DomainBeanNetRequestErrorMessageHandle.h
//  airizu
//
//  Created by 唐志华 on 13-1-9.
//
//

#import <Foundation/Foundation.h>

@class NetErrorBean;
@interface DomainBeanNetRequestErrorBeanHandle : NSObject {
  
}

+ (void) handleNetRequestErrorBean:(NetErrorBean *)netErrorBean;
@end
