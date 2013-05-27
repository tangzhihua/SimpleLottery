//
//  NSObject+Serialization.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "NSObject+Serialization.h"

@implementation NSObject (Serialization)

-(void)serializeObjectToFileWithFileName:(NSString *)fileName directoryPath:(NSString *)directoryPath{
  
  @synchronized(self) {
    if ([NSString isEmpty:fileName] || [NSString isEmpty:directoryPath]) {
      return;
    }

    NSString *fileFullPath = [directoryPath stringByAppendingPathComponent:fileName];
    BOOL isSaveSuccessful = [NSKeyedArchiver archiveRootObject:self toFile:fileFullPath];
    PRPLog(@"保存对象结果 = %@", [[NSNumber numberWithBool:isSaveSuccessful] description]);
  }
}

+(id)deserializeObjectFromFileWithFileName:(NSString *)fileName directoryPath:(NSString *)directoryPath {
  @synchronized(self) {
    if ([NSString isEmpty:fileName] || [NSString isEmpty:directoryPath]) {
      return nil;
    }

    NSString *fileFullPath = [directoryPath stringByAppendingPathComponent:fileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileFullPath];
  }
}
@end
