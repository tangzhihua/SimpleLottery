//
//  AdImageInWelcomePageNetRespondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "AdImageInWelcomePageNetRespondBean.h"
#import "SoftwareUpdateDatabaseFieldsConstant.h"

@interface AdImageInWelcomePageNetRespondBean ()
// 是否要显示从网络侧下载的广告图片
@property (nonatomic, readwrite, assign) BOOL isShowAdImageFromServer;
// 客户端根据返回的id判断是否需要下载新图片
@property (nonatomic, readwrite, strong) NSString *imageID;
// 图片地址
@property (nonatomic, readwrite, strong) NSString *imageUrl;
@end




@implementation AdImageInWelcomePageNetRespondBean
 

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if([key isEqualToString:k_AdImage_RespondKey_errorCode]) {
    BOOL isShowAdImageFromServer = YES;
    if ([value isEqualToString:@"true"]) {
      isShowAdImageFromServer = YES;
    } else {
      isShowAdImageFromServer = NO;
    }
    self.isShowAdImageFromServer = isShowAdImageFromServer;
    
  } else if([key isEqualToString:k_AdImage_RespondKey_id]) {
    self.imageID = value;
  } else {
    [super setValue:value forUndefinedKey:key];
  }
}

- (NSString *)description {
  return descriptionForDebug(self);
}
@end
