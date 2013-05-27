//
//  AdImageInWelcomePageNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>

@interface AdImageInWelcomePageNetRespondBean : NSObject

// 是否要显示从网络侧下载的广告图片
@property (nonatomic, readonly, assign) BOOL isShowAdImageFromServer;
// 客户端根据返回的id判断是否需要下载新图片
@property (nonatomic, readonly, strong) NSString *ID;
// 图片地址
@property (nonatomic, readonly, strong) NSString *imageUrl;


#pragma mark -
#pragma mark 方便构造

+(id)adImageInWelcomePageNetRespondBeanWithIsShowAdImageFromServer:(BOOL)isShowAdImageFromServer
																																ID:(NSString *)ID
																													imageUrl:(NSString *)imageUrl;

@end
