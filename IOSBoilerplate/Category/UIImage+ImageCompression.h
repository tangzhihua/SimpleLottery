//
//  UIImage+ImageCompression.h
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCompression) {
  
}

/*
 功能： 生成圆角图片
 */
+ (id) createRoundedRectImage:(UIImage *) image size:(CGSize) size;
/*
 功能： 图片裁减并压缩
 */
- (UIImage *) imageByScalingAndCroppingForSize:(CGSize) targetSize;
/*
 功能： 图片按比例压缩
 */
- (UIImage *) imageByScalingForSize:(CGSize) targetSize;
@end
