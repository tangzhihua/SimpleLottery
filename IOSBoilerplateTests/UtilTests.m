//
//  UtilTests.m
//  UtilTests
//
//  Created by YongQing Gu on 12/31/11.
//  Copyright (c) 2011 CSDN. All rights reserved.
//

#import "UtilTests.h"
#import "Util.h"


@implementation UtilTests
static NSMutableArray* performanceProfiles = nil;
+ (void) performanceProfileStart{
  if (performanceProfiles == nil) {
    performanceProfiles = [[NSMutableArray alloc] init];
  }
  [performanceProfiles addObject:[NSDate date]];
}

+ (void) performanceProfileEnd:(NSString *)message{
  NSDate* start = [performanceProfiles objectAtIndex: performanceProfiles.count-1];
  NSLog(@"[%.3f] %@", -[start timeIntervalSinceNow], message);
  [performanceProfiles removeLastObject];
}



- (void)setUp{
  [super setUp];
}

- (void)tearDown{
  [super tearDown];
}

- (void)testExample{
  NSLog(@"\n\n\n\n\n\n"); // 让结果输出清楚些
  
  NSString* testFilePath = @"/Users/york/test.html";
  NSString* testFolderPath = @"/Users/york/Desktop";
  STAssertEquals([Util fileSizeAtPath1:testFilePath], [Util fileSizeAtPath2:testFilePath], @"两种方法获取的文件大小不同");
  
  int testTimes = 1000;
  for(int i=0; i<testTimes; i++)[Util fileSizeAtPath1:testFilePath];; // 先让系统进入状态
  
  
  [UtilTests performanceProfileStart];
  for(int i=0; i<testTimes; i++)[Util fileSizeAtPath1:testFilePath];
  [UtilTests performanceProfileEnd:@"使用NSFileManager获取文件大小"];
  
  [UtilTests performanceProfileStart];
  for(int i=0; i<testTimes; i++)[Util fileSizeAtPath2:testFilePath];
  [UtilTests performanceProfileEnd:@"使用unix c函数获取文件大小"];

  
  
  
  
  testTimes = 10;
  
  // 这三种方法分别获取到的目录大小
  NSLog(@"folderSizeAtPath1: %lld", [Util folderSizeAtPath1:testFolderPath]);
  NSLog(@"folderSizeAtPath2: %lld", [Util folderSizeAtPath2:testFolderPath]);
  NSLog(@"folderSizeAtPath3: %lld", [Util folderSizeAtPath3:testFolderPath]);  
  
  
  // 开始进行耗时测试
  [UtilTests performanceProfileStart];
  for(int i=0; i<testTimes; i++)[Util folderSizeAtPath1:testFolderPath];
  [UtilTests performanceProfileEnd:@"使用subpathsAtPath然后循环调用NSFileManager获取目录总大小"];
  
  [UtilTests performanceProfileStart];
  for(int i=0; i<testTimes; i++)[Util folderSizeAtPath2:testFolderPath];
  [UtilTests performanceProfileEnd:@"使用subpathsAtPath然后循环调用unix c函数获取目录总大小"];
  
  [UtilTests performanceProfileStart];
  for(int i=0; i<testTimes; i++)[Util folderSizeAtPath3:testFolderPath];
  [UtilTests performanceProfileEnd:@"使用纯unix c递归获取目录总大小"];
  
  
  NSLog(@"\n\n\n\n\n\n"); // 让结果输出清楚些
}

@end
