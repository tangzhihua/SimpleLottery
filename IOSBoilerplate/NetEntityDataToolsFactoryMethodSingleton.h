//
//  NetEntityDataToolsFactoryMethodSingleton.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "INetEntityDataTools.h"

@interface NetEntityDataToolsFactoryMethodSingleton : NSObject <INetEntityDataTools> {
  
}

+ (NetEntityDataToolsFactoryMethodSingleton *) sharedInstance;

@end
