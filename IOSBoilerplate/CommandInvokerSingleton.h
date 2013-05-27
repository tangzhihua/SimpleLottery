//
//  CommandInvokerSingleton.h
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import <Foundation/Foundation.h>


@interface CommandInvokerSingleton : NSObject {
  
}

+ (CommandInvokerSingleton *) sharedInstance;

//
-(void)runCommandWithCommandObject:(id)commandObject;
@end
