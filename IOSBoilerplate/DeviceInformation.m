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
  RNAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

// 当前屏幕的宽度和高度(根据屏幕设备方向而变化)
+ (CGFloat) currentlyScreenWidth {
  
  UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
  
  CGFloat width = 0;
  
  if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
    width = [UIScreen mainScreen].applicationFrame.size.width;
  } else if (currentOrientation == UIInterfaceOrientationLandscapeLeft || currentOrientation == UIInterfaceOrientationLandscapeRight) {
    width = [UIScreen mainScreen].applicationFrame.size.height;
  } else {
    width = [UIScreen mainScreen].applicationFrame.size.width;
  }
  
  return width;
}

+ (CGFloat) currentlyScreenHeight {
  
  UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
  
  CGFloat height = 0;
  if (currentOrientation == UIInterfaceOrientationPortrait || currentOrientation == UIInterfaceOrientationPortraitUpsideDown) {
    height = [UIScreen mainScreen].applicationFrame.size.height;
  } else if (currentOrientation == UIInterfaceOrientationLandscapeLeft || currentOrientation == UIInterfaceOrientationLandscapeRight) {
    height = [UIScreen mainScreen].applicationFrame.size.width;
  } else {
    height = [UIScreen mainScreen].applicationFrame.size.height;
  }
  
  return height;
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

// 根据字体大小计算label大小
+ (CGSize)calculateLabelSizeOfContent:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize {
  const CGSize defaultSize = CGSizeMake(320, 22);
  
  if ([NSString isEmpty:text]) {
    return defaultSize;
  }
  
  CGSize labelSize = [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
  if (labelSize.height < defaultSize.height) {
    labelSize.height = defaultSize.height;
  }
  return labelSize;
}

@end
