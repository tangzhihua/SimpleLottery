//
//  DeviceInformation.h
//  airizu
//
//  Created by 唐志华 on 12-12-26.
//
//

#import <Foundation/Foundation.h>



@interface DeviceInformation : NSObject {
  
}

// 当前屏幕的宽度和高度(根据屏幕设备方向而变化)
+ (CGFloat) currentlyScreenWidth;
+ (CGFloat) currentlyScreenHeight;

+ (BOOL) isIPhone5;
+ (BOOL) isSimulator;

+ (void) printDeviceInfo;

+ (CGSize)calculateLabelSizeOfContent:(NSString *)text withFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
