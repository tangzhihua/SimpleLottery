//
//  VersionNetRespondBean.h
//  airizu
//
//  Created by 唐志华 on 13-2-17.
//
//

#import <Foundation/Foundation.h>

@interface VersionNetRespondBean : NSObject {
  
}

@property (nonatomic, readonly, strong) NSString *latestVersion;
@property (nonatomic, readonly, strong) NSString *fileSize;
@property (nonatomic, readonly, strong) NSString *updateContent;
@property (nonatomic, readonly, strong) NSString *downloadAddress;

+(id)versionNetRespondBeanWithNewVersion:(NSString *)latestVersion
                             andFileSize:(NSString *)fileSize
                        andUpdateContent:(NSString *)updateContent
                      andDownloadAddress:(NSString *)downloadAddress;
@end