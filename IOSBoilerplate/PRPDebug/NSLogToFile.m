//
//  NSLogToFile.m
//  airizu
//
//  Created by 唐志华 on 13-3-5.
//
//

#import "NSLogToFile.h"

@implementation NSLogToFile

+(void)redirectNSLogToDocumentFolder {
  
  NSString *fileName =[NSString stringWithFormat:@"%@.log",[NSDate date]];
  NSString *logFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
  freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}
@end
