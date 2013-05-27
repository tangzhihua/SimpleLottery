//
//  VersionNetRespondBean.m
//  airizu
//
//  Created by 唐志华 on 13-2-17.
//
//

#import "VersionNetRespondBean.h"


static const NSString *const TAG = @"<VersionNetRespondBean>";

@implementation VersionNetRespondBean

- (id)initWithNewVersion:(NSString *) latestVersion
             andFileSize:(NSString *) fileSize
        andUpdateContent:(NSString *) updateContent
      andDownloadAddress:(NSString *) downloadAddress {
  
  if ((self = [super init])) {
		PRPLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    _latestVersion = [latestVersion copy];
    _fileSize = [fileSize copy];
    _updateContent = [updateContent copy];
    _downloadAddress = [downloadAddress copy];
  }
  
  return self;
}

+(id)versionNetRespondBeanWithNewVersion:(NSString *)latestVersion
                             andFileSize:(NSString *)fileSize
                        andUpdateContent:(NSString *)updateContent
                      andDownloadAddress:(NSString *)downloadAddress {
  return [[VersionNetRespondBean alloc] initWithNewVersion:latestVersion
                                                andFileSize:fileSize
                                           andUpdateContent:updateContent
																				andDownloadAddress:downloadAddress];
}

- (NSString *)description {
  return descriptionForDebug(self);
}

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id)init
{
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}
@end
