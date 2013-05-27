//
//  NSObject+DeepCopyingSupport.m
//  airizu
//
//  Created by 唐志华 on 13-3-2.
//
//

#import "NSObject+DeepCopyingSupport.h"

@implementation NSObject (DeepCopyingSupport)

- (id) deepCopy {
  return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}
@end
