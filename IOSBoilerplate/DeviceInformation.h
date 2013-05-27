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

+ (CGFloat) screenWidth;
+ (CGFloat) screenHeight;

+ (BOOL) isIPhone5;
+ (BOOL) isSimulator;

+ (void) printDeviceInfo;
@end
