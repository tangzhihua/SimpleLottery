//
//  DomainBeanNetThread.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

@class NetRequestEvent;
@interface DomainBeanNetThread : NSThread {
  
}

/**
 * 通知当前线程, 可以终止了
 */
- (void) interrupt;

/**
 * 判断当前线程是否需要终止
 */
- (BOOL) isInterrupted;

#pragma mark -
#pragma mark 方便构造
+(id)domainBeanNetThreadWithNetRequestEvent:(NetRequestEvent *)requestEvent
                            networkCallback:(id)networkCallback;
@end
