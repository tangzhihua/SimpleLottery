//
//  CommandForInitLBSLibrary.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForInitLBSLibrary.h"
#import "BaiduLBSSingleton.h"

@implementation CommandForInitLBSLibrary
/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  // 要使用百度地图，请先启动BaiduMapManager
  [[BaiduLBSSingleton sharedInstance] initializeMapManager];
}

+(id)commandForInitLBSLibrary {
  return [[CommandForInitLBSLibrary alloc] init];
}
@end
