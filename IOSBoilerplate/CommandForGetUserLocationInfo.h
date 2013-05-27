//
//  CommandForGetUserLocationInfo.h
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import <Foundation/Foundation.h>
#import "SimpleLocationHelperForBaiduLBS.h"
#import "Command.h"

@interface CommandForGetUserLocationInfo : NSObject <Command, LocationDelegate, AddrInfoDelegate> {
  
}

+(id)commandForGetUserLocationInfo;
@end
