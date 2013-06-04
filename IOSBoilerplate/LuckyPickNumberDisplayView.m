//
//  LuckyPickNumberDisplayView.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-4.
//
//

#import "LuckyPickNumberDisplayView.h"

@implementation LuckyPickNumberDisplayView

+ (NSString *) nibName {
  return NSStringFromClass([self class]);
}

+ (UINib *) nib {
  NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
  return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}

 
+(id)luckyPickNumberDisplayView {
  NSArray *nibObjects = [[self nib] instantiateWithOwner:nil options:nil];
  LuckyPickNumberDisplayView *titleBar = [nibObjects objectAtIndex:0];
   
  return titleBar;
}
@end
