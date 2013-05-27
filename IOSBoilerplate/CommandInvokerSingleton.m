//
//  CommandInvokerSingleton.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandInvokerSingleton.h"
#import "Command.h"

@implementation CommandInvokerSingleton

#pragma mark -
#pragma mark 单例方法群
static CommandInvokerSingleton *singletonInstance = nil;

-(void)initialize {
  
}

+(CommandInvokerSingleton *)sharedInstance {
  if (singletonInstance == nil) {
    singletonInstance = [[super allocWithZone:NULL] init];
    
    // initialize the first view controller
    // and keep it with the singleton
    [singletonInstance initialize];
  }
  
  return singletonInstance;
}


-(void)runCommandWithCommandObject:(id)commandObject {
  if ([commandObject conformsToProtocol:@protocol(Command)]) {
    [commandObject execute];
  }
}

@end
