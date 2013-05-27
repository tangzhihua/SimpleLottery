//
//  LocalCacheDataPathConstant.h
//  airizu
//
//  Created by 唐志华 on 13-3-23.
//
//

#import <Foundation/Foundation.h>

@interface LocalCacheDataPathConstant : NSObject {
  
}

// 房间详情 (可以被清除) : 本地缓存目录路径
+(NSString *)roomDetailCachePath;
// 项目中图片缓存目录 (可以被清除)
+(NSString *)imageCachePath;
// 那些需要始终被保存, 不能由用户进行清除的文件
+(NSString *)importantDataCachePath;

// 能否被用户清空的目录数组(可以从这里获取用户可以直接清空的文件夹路径数组)
+(NSArray *)directoriesCanBeClearByTheUser;

// 创建本地数据缓存目录(一次性全部创建, 不会重复创建)
+(void)createLocalCacheDirectories;
@end
