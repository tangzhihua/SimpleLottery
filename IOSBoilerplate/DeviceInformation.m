//
//  DeviceInformation.m
//  airizu
//
//  Created by 唐志华 on 12-12-26.
//
//

#import "DeviceInformation.h"

static const NSString *const TAG = @"<DeviceInformation>";



@implementation DeviceInformation
- (id) init {
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

+ (CGFloat) screenWidth {
	return [UIScreen mainScreen].applicationFrame.size.width;
}

+ (CGFloat) screenHeight {
	return [UIScreen mainScreen].applicationFrame.size.height;
}

+ (BOOL) isIPhone5 {
  return ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
}

+ (BOOL) isSimulator {
  //制定真机调试保存日志文件
  UIDevice *device =[UIDevice currentDevice];
  NSRange range = [[device model] rangeOfString:@"Simulator"];
  
  return (range.length > 0);
}

+ (void) printDeviceInfo {
  UIDevice *device =[UIDevice currentDevice];
  NSLog(@"    ");
  NSLog(@"-----------------------------");
  NSLog(@"    ");
  
  NSLog(@"device.name=%@", device.name);// e.g. "My iPhone"
  NSLog(@"device.model=%@", device.model);// e.g. @"iPhone", @"iPod touch"
  NSLog(@"device.localizedModel=%@", device.localizedModel);// localized version of model
  NSLog(@"device.systemName=%@", device.systemName);// e.g. @"iOS"
  NSLog(@"device.systemVersion=%@", device.systemVersion);// e.g. @"4.0"
  
  NSLog(@"    ");
  NSLog(@"-----------------------------");
  NSLog(@"    ");
}

@end
