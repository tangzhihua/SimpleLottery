//
//  GloblaDataCacheForFile.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//  需要固化到文件中
//
//

#import <Foundation/Foundation.h>



// GlobalDataCacheForMemorySingleton 类中有些数据是需要固化到设备中的,
// 本类就是用来完成这些数据固化工作的 "通讯录模式"
@interface GlobalDataCacheForNeedSaveToFileSystem : NSObject {
  
}

///

+ (void)readUserLoginInfoToGlobalDataCacheForMemorySingleton;
+ (void)readAppConfigInfoToGlobalDataCacheForMemorySingleton;

///

+ (void)writeUserLoginInfoToFileSystem;
+ (void)writeAppConfigInfoToFileSystem;

///
+ (void)saveAllCacheDataToFileSystem;
@end
