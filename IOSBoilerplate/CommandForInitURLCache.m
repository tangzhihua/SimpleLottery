//
//  CommandForInitURLCache.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForInitURLCache.h"
#import "AFURLCache.h"

@implementation CommandForInitURLCache
/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  AFURLCache *URLCache
  = [[AFURLCache alloc] initWithMemoryCapacity:1024*1024   // 1MB mem cache
                                  diskCapacity:1024*1024*5 // 5MB disk cache
                                      diskPath:[AFURLCache defaultCachePath]];
	[NSURLCache setSharedURLCache:URLCache];
  URLCache = nil;
}

+(id)commandForInitURLCache {
  return [[CommandForInitURLCache alloc] init];
}
@end
