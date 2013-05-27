//
//  NetConnectionManageTools.h
//  airizu
//
//  Created by 唐志华 on 12-12-20.
//
//

#import <Foundation/Foundation.h>

@interface NetConnectionManageTools : NSObject {
  
}

- (BOOL) isNetAvailable;

#pragma mark -
#pragma mark 方便构造
+(id)netConnectionManageTools;


+(NSString *)macAddressString;
@end
