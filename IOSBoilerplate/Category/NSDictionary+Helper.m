//
//  NSDictionary+Helper.m
//  airizu
//
//  Created by 唐志华 on 13-1-23.
//
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

-(BOOL)containsKey:(id)key {
  if (key == nil || [key isKindOfClass:[NSNull class]]) {
    // 入参非法
    return NO;
  }
  
  NSArray *keys = [self allKeys];
  for (id item in keys) {
    if ([item isEqual:key]) {
      return YES;
    }
  }
  
  return NO;
}

-(BOOL)containsValue:(id)value {
  if (value == nil) {
    // 入参非法
    return NO;
  }
  
  NSArray *values = [self allValues];
  for (id item in values) {
    if ([item isEqual:value]) {
      return YES;
    }
  }
  
  return NO;
}

@end
