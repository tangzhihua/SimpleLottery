//
//  NSString+Expand.m
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import "NSString+isEmpty.h"

@implementation NSString (isEmpty)

+ (BOOL) isEmpty:(NSString *) string {
  do {
    if (![string isKindOfClass:[NSString class]]) {
      break;
    }
    
    if ([string length] <= 0) {
      break;
    }
    
    return NO;
  } while (NO);
  
  return YES;
}

+(BOOL)compareTwoStringsAreTheSameWithStringA:(NSString *)stringA andStringB:(NSString *)stringB {
  do {
    if ([NSString isEmpty:stringA] && [NSString isEmpty:stringB]) {
      // 两个空字符串, 我们认为是相同的
      break;
    }
  
    //
    if ([stringA isEqualToString:stringB]) {
      break;
    }
  
    return NO;
  } while (NO);

  return YES;
}


@end
