//
//  UIImageView+MKNetworkKitAdditions.m
//  MKNetworkKitDemo
//
//  Created by Mugunth Kumar (@mugunthkumar) on 18/01/13.
//  Copyright (C) 2011-2020 by Steinlogic Consulting and Training Pte Ltd

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "UIImageView+MKNetworkKitAdditions.h"

#import "MKNetworkEngine.h"

#import <objc/runtime.h>
#import "LocalCacheDataPathConstant.h"

static MKNetworkEngine *imageDownloadEngine(){
  return [DownloadThumbnailNetworkEngine sharedInstance];
}
static char imageFetchOperationKey;

const float kFromCacheAnimationDuration = 0.1f;
const float kFreshLoadAnimationDuration = 0.35f;

@interface UIImageView (/*Private Methods*/)
@property (strong, nonatomic) MKNetworkOperation *imageFetchOperation;
@end

@implementation UIImageView (MKNetworkKitAdditions)

-(MKNetworkOperation*) imageFetchOperation {
  
  return (MKNetworkOperation*) objc_getAssociatedObject(self, &imageFetchOperationKey);
}

-(void) setImageFetchOperation:(MKNetworkOperation *)imageFetchOperation {
  
  objc_setAssociatedObject(self, &imageFetchOperationKey, imageFetchOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



-(MKNetworkOperation*) setImageFromURL:(NSURL*) url {
  
  return [self setImageFromURL:url placeHolderImage:nil];
}

-(MKNetworkOperation*) setImageFromURL:(NSURL*) url placeHolderImage:(UIImage*) image {
  
  return [self setImageFromURL:url placeHolderImage:image usingEngine:imageDownloadEngine() animation:YES];
}

-(MKNetworkOperation*) setImageFromURL:(NSURL*) url placeHolderImage:(UIImage*) image animation:(BOOL) yesOrNo {
  
  return [self setImageFromURL:url placeHolderImage:image usingEngine:imageDownloadEngine() animation:yesOrNo];
}

-(MKNetworkOperation*) setImageFromURL:(NSURL*) url placeHolderImage:(UIImage*) image usingEngine:(MKNetworkEngine*) imageCacheEngine animation:(BOOL) animation {
  
  if(image) self.image = image;
  [self.imageFetchOperation cancel];
  if(!imageCacheEngine) imageCacheEngine = imageDownloadEngine();
  
  if(imageCacheEngine) {
    self.imageFetchOperation = [imageCacheEngine imageAtURL:url
                                                       size:self.frame.size
                                          completionHandler:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
                                            
                                            if(animation) {
                                              [UIView transitionWithView:self.superview
                                                                duration:isInCache?kFromCacheAnimationDuration:kFreshLoadAnimationDuration
                                                                 options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction
                                                              animations:^{
                                                                self.image = fetchedImage;
                                                              }
                                                              completion:nil];
                                            } else {
                                              self.image = fetchedImage;
                                            }
                                            
                                          } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                                            
                                            DLog(@"%@", error);
                                          }];
  } else {
    
    DLog(@"No default engine found and imageCacheEngine parameter is null")
  }
  
  return self.imageFetchOperation;
}


@end











@interface DownloadThumbnailNetworkEngine ()
@property (nonatomic, assign) BOOL isConfigFinish;
@end

@implementation DownloadThumbnailNetworkEngine
-(void)config {
  [self useCache];
}

#pragma mark -
#pragma mark Singleton Implementation

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

+ (DownloadThumbnailNetworkEngine *) sharedInstance {
  static DownloadThumbnailNetworkEngine *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initWithHostName:nil];});
  
  if (!singletonInstance.isConfigFinish) {
    [singletonInstance config];
    singletonInstance.isConfigFinish = YES;
  }
  return singletonInstance;
}

// 设置缩略图缓存目录
-(NSString *) cacheDirectoryName {
	NSString *cacheDirectoryName = [LocalCacheDataPathConstant thumbnailCachePath];
	return cacheDirectoryName;
}

@end
