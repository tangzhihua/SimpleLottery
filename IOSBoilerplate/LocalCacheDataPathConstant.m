//
//  LocalCacheDataPathConstant.m
//  airizu
//
//  Created by 唐志华 on 13-3-23.
//
//

#import "LocalCacheDataPathConstant.h"

@implementation LocalCacheDataPathConstant



// 房间详情 (可以被清除) : 本地缓存目录路径
static NSString *_roomDetailCachePath = nil;
+(NSString *)roomDetailCachePath {
  if (nil == _roomDetailCachePath) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"RoomDetailCache"];
    _roomDetailCachePath = [fullPath copy];
  }
  
  return _roomDetailCachePath;
}

// 项目中图片缓存目录 (可以被清除)
static NSString *_imageCachePath = nil;
+(NSString *)imageCachePath {
  if (nil == _imageCachePath) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"ImageCache"];
    _imageCachePath = [fullPath copy];
  }
  
  return _imageCachePath;
}

// 那些需要始终被保存, 不能由用户进行清除的文件
static NSString *_importantDataCachePath = nil;
+(NSString *)importantDataCachePath {
  if (nil == _importantDataCachePath) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"ImportantDataCache"];
    _importantDataCachePath = [fullPath copy];
  }
  
  return _importantDataCachePath;
}

// 能否被用户清空的目录数组(可以从这里获取用户可以直接清空的文件夹路径数组)
+(NSArray *)directoriesCanBeClearByTheUser {
  NSArray *directories = [NSArray arrayWithObjects:[self roomDetailCachePath], [self imageCachePath], nil];
  return directories;
}

// 创建本地数据缓存目录(一次性全部创建, 不会重复创建)
+(void)createLocalCacheDirectories {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath:[LocalCacheDataPathConstant roomDetailCachePath]]) {
    [fileManager createDirectoryAtPath:[LocalCacheDataPathConstant roomDetailCachePath] withIntermediateDirectories:YES attributes:nil error:nil];
  }
  
  if (![fileManager fileExistsAtPath:[LocalCacheDataPathConstant imageCachePath]]) {
    [fileManager createDirectoryAtPath:[LocalCacheDataPathConstant imageCachePath] withIntermediateDirectories:YES attributes:nil error:nil];
  }
  
  if (![fileManager fileExistsAtPath:[LocalCacheDataPathConstant importantDataCachePath]]) {
    [fileManager createDirectoryAtPath:[LocalCacheDataPathConstant importantDataCachePath] withIntermediateDirectories:YES attributes:nil error:nil];
  }
}
@end
