//
//  CommandForPrintDeviceInfo.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForPrintDeviceInfo.h"

@implementation CommandForPrintDeviceInfo

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  [DeviceInformation printDeviceInfo];
}

+(id)commandForPrintDeviceInfo {
  return [[CommandForPrintDeviceInfo alloc] init];
}
@end
