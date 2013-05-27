//
//  Util.h
//  airizu
//
//  Created by 唐志华 on 13-3-23.
//
//

#import <Foundation/Foundation.h>

@interface Util : NSObject {
  
}

// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString *) filePath;
// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString *) filePath;


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString *) folderPath;
// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString *) folderPath;
// 方法3：完全使用unix c函数(在folderSizeAtPath2基础之上，去除文件路径相关的字符串拼接工作)
+ (long long) folderSizeAtPath3:(NSString *) folderPath;

+ (void) deleteFolderAtPath:(NSString *)folderPath;
 
@end
