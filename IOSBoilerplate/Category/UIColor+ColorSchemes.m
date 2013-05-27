//
//  UIColor+ColorSchemes.m
//  airizu
//
//  Created by 唐志华 on 13-1-18.
//
//

#import "UIColor+ColorSchemes.h"

@implementation UIColor (ColorSchemes)


// 标签文本 亮色
+(UIColor *)colorForLabelBrightColorText {
  return [UIColor colorWithWhite:102/255.0 alpha:1];
}
// 标签文本 暗色
+(UIColor *)colorForLabelDarkColorText {
  return [UIColor colorWithWhite:51/255.0 alpha:1];
}
// 标签文本 橘红色
+(UIColor *)colorForLabelOrangeText {
  return [UIColor colorWithRed:245/255.0 green:98/255.0 blue:20/255.0 alpha:1];
}

 
@end
