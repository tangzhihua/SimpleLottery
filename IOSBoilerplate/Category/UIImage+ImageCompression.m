//
//  UIImage+ImageCompression.m
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import "UIImage+ImageCompression.h"

static void addRoundedRectToPath(CGContextRef context,
                                 CGRect rect,
                                 float ovalWidth,
                                 float ovalHeight) {
  
  float fw, fh;
  if (ovalWidth == 0 || ovalHeight == 0) {
    CGContextAddRect(context, rect);
    return;
  }
  
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
  CGContextScaleCTM(context, ovalWidth, ovalHeight);
  fw = CGRectGetWidth(rect) / ovalWidth;
  fh = CGRectGetHeight(rect) / ovalHeight;
  
  CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
#pragma mark change the corner size below...
  CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
  CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
  CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
  CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
  
  CGContextClosePath(context);
  CGContextRestoreGState(context);
}

@implementation UIImage (ImageCompression)
+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size {
  // the size of CGContextRef
  int w = size.width;
  int h = size.height;
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
  CGRect rect = CGRectMake(0, 0, w, h);
  
  CGContextBeginPath(context);
  addRoundedRectToPath(context, rect, 10, 10);
  CGContextClosePath(context);
  CGContextClip(context);
  CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
  CGImageRef imageMasked = CGBitmapContextCreateImage(context);
  CGContextRelease(context);
  CGColorSpaceRelease(colorSpace);
  return [UIImage imageWithCGImage:imageMasked];
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
	UIImage *sourceImage = self;
  UIImage *newImage = nil;
  CGSize imageSize = sourceImage.size;
  CGFloat width = imageSize.width;
  CGFloat height = imageSize.height;
  CGFloat targetWidth = targetSize.width;
  CGFloat targetHeight = targetSize.height;
  CGFloat scaleFactor = 0.0;
  CGFloat scaledWidth = targetWidth;
  CGFloat scaledHeight = targetHeight;
  CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
  
  if (CGSizeEqualToSize(imageSize, targetSize) == NO)
  {
    CGFloat widthFactor = targetWidth / width;
    CGFloat heightFactor = targetHeight / height;
    
    if (widthFactor > heightFactor)
      scaleFactor = widthFactor; // scale to fit height
    else
      scaleFactor = heightFactor; // scale to fit width
    scaledWidth  = width * scaleFactor;
    scaledHeight = height * scaleFactor;
    
    // center the image
    if (widthFactor > heightFactor)
    {
      thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
    }
    else
      if (widthFactor < heightFactor)
      {
        thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
      }
  }
  
  UIGraphicsBeginImageContext(targetSize); // this will crop
  
  CGRect thumbnailRect = CGRectZero;
  thumbnailRect.origin = thumbnailPoint;
  thumbnailRect.size.width  = scaledWidth;
  thumbnailRect.size.height = scaledHeight;
  
  [sourceImage drawInRect:thumbnailRect];
  
  newImage = UIGraphicsGetImageFromCurrentImageContext();
  if(newImage == nil)
    //PRPLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
  return newImage;
}

- (UIImage*)imageByScalingForSize:(CGSize)targetSize
{
	UIImage *sourceImage = self;
  CGSize imageSize = sourceImage.size;
  CGFloat width = imageSize.width;
  CGFloat height = imageSize.height;
  CGFloat targetWidth = targetSize.width;
  CGFloat targetHeight = targetSize.height;
  
  
  if ((width > targetWidth) || (height > targetHeight) )
  {
    
    CGFloat widthFactor = targetWidth / width;
    CGFloat heightFactor = targetHeight / height;
    CGFloat scaleFactor;
    if (widthFactor < heightFactor)
      scaleFactor = widthFactor; // scale to fit height
    else
      scaleFactor = heightFactor; // scale to fit width
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
  }
  
  UIGraphicsBeginImageContext(CGSizeMake(width, height));
  [self drawInRect:CGRectMake(0, 0, width , height)];
  UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return scaledImage;
}
@end
