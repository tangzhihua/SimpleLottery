//
//  Util.m
//  Util
//
//  Created by YongQing Gu on 12/31/11.
//  Copyright (c) 2011 CSDN. All rights reserved.
//

#import "Util.h"
#include <sys/stat.h>
#include <dirent.h>

@interface Util(Private)
+ (long long) _folderSizeAtPath: (const char*)folderPath;
@end

@implementation Util

// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString*) filePath{
  NSFileManager* manager = [NSFileManager defaultManager];
  if ([manager fileExistsAtPath:filePath]){
    return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
  }
  return 0;
}

// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString*) filePath{
  struct stat st;
  if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
    return st.st_size;
  }
  return 0;
}


#pragma mark 获取目录大小


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString*) folderPath{
  NSFileManager* manager = [NSFileManager defaultManager];
  if (![manager fileExistsAtPath:folderPath]) return 0;
  NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
  NSString* fileName;
  long long folderSize = 0;
  while ((fileName = [childFilesEnumerator nextObject]) != nil){
    NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
    if ([self fileSizeAtPath1:fileAbsolutePath] != [self fileSizeAtPath2:fileAbsolutePath]){
      NSLog(@"%@, %lld, %lld", fileAbsolutePath,
            [self fileSizeAtPath1:fileAbsolutePath],
            [self fileSizeAtPath2:fileAbsolutePath]);
    }
    folderSize += [self fileSizeAtPath1:fileAbsolutePath];
  }
  return folderSize;
}


// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString*) folderPath{
  NSFileManager* manager = [NSFileManager defaultManager];
  if (![manager fileExistsAtPath:folderPath]) return 0;
  NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
  NSString* fileName;
  long long folderSize = 0;
  while ((fileName = [childFilesEnumerator nextObject]) != nil){
    NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
    folderSize += [self fileSizeAtPath2:fileAbsolutePath];
  }
  return folderSize;
}


// 方法3：完全使用unix c函数
+ (long long) folderSizeAtPath3:(NSString*) folderPath{
  return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}

/*
 + (long long) freeDiskSpaceInBytes{
 struct statfs buf;
 long long freespace = -1;
 if(statfs("/var", &buf) >= 0){
 freespace = (long long)(buf.f_bsize * buf.f_bfree);
 }
 return freespace;
 }
 */

+ (void) deleteFolderAtPath:(NSString *)folderPath {
  
  do {
    if ([NSString isEmpty:folderPath]) {
      break;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) {
      break;
    }
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:folderPath error:NULL];
    NSEnumerator *filesEnumerator = [contents objectEnumerator];
    NSString *filename = nil;
    
    while ((filename = [filesEnumerator nextObject])) {
      
      [fileManager removeItemAtPath:[folderPath stringByAppendingPathComponent:filename] error:NULL];
    }
  } while (NO);
	
}


 

+(UIImage *)imageWithFilename:(NSString *)filename{
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"MyApp"];
	path = [path stringByAppendingPathComponent:filename];
	
	return [UIImage imageWithContentsOfFile:path];
}
@end




@implementation Util(Private)
+ (long long) _folderSizeAtPath: (const char*)folderPath{
  long long folderSize = 0;
  DIR* dir = opendir(folderPath);
  if (dir == NULL) return 0;
  struct dirent* child;
  while ((child = readdir(dir))!=NULL) {
    if (child->d_type == DT_DIR && (
                                    (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                    (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                    )) continue;
    
    int folderPathLength = strlen(folderPath);
    char childPath[1024]; // 子文件的路径地址
    stpcpy(childPath, folderPath);
    if (folderPath[folderPathLength-1] != '/'){
      childPath[folderPathLength] = '/';
      folderPathLength++;
    }
    stpcpy(childPath+folderPathLength, child->d_name);
    childPath[folderPathLength + child->d_namlen] = 0;
    if (child->d_type == DT_DIR){ // directory
      folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
      // 把目录本身所占的空间也加上
      struct stat st;
      if(lstat(childPath, &st) == 0) folderSize += st.st_size;
    }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
      struct stat st;
      if(lstat(childPath, &st) == 0) folderSize += st.st_size;
    }
  }
  return folderSize;
}


@end
