//
//  LocalCacheDataPathConstant.m
//  airizu
//
//  Created by 唐志华 on 13-3-23.
//
//

#import "LocalCacheDataPathConstant.h"

@implementation LocalCacheDataPathConstant

// 静态初始化方法
+(void) initialize {
  
}

// 房间详情 (可以被清除) : 本地缓存目录路径
static NSString *_roomDetailCachePath = nil;
+(NSString *)roomDetailCachePath {
  if (nil == _roomDetailCachePath) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"RoomDetailCache"];
    _roomDetailCachePath = [fullPath copy];
  }
  
  return _roomDetailCachePath;
}

// 项目中图片缓存目录 (可以被清除)
static NSString *_thumbnailCachePath = nil;
+(NSString *)thumbnailCachePath {
  if (nil == _thumbnailCachePath) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"ThumbnailCachePath"];
    _thumbnailCachePath = [fullPath copy];
  }
  
  return _thumbnailCachePath;
}

// 广告图片缓存目录 (可以被清除)
static NSString *_adCachePath = nil;
+(NSString *)adCachePath {
  if (nil == _adCachePath) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:@"AdCachePath"];
    _adCachePath = [fullPath copy];
  }
  
  return _adCachePath;
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
  NSArray *directories = [NSArray arrayWithObjects:[self roomDetailCachePath], [self thumbnailCachePath], nil];
  return directories;
}

// 创建本地数据缓存目录(一次性全部创建, 不会重复创建)
+(void)createLocalCacheDirectories {
  // 创建本地数据缓存目录(一次性全部创建, 不会重复创建)
  NSArray *directories = [NSArray arrayWithObjects:[self roomDetailCachePath], [self thumbnailCachePath], [self adCachePath], [self importantDataCachePath], nil];
  
  NSFileManager *fileManager = [NSFileManager defaultManager];
  for (NSString *path in directories) {
    if (![fileManager fileExistsAtPath:path]) {
      [fileManager createDirectoryAtPath:path
             withIntermediateDirectories:YES
                              attributes:nil
                                   error:nil];
    }
  }

}
@end
