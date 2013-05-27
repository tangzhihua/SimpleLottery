//
//  LabelForTitleBar.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-21.
//
//

#import "LabelForTitleBar.h"

@implementation LabelForTitleBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (NSString *) nibName {
  return NSStringFromClass([self class]);
}

+ (UINib *) nib {
  NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
  return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}


+(id)labelForTitleBar {
  NSArray *nibObjects = [[self nib] instantiateWithOwner:nil options:nil];
  LabelForTitleBar *labelForTitleBar = [nibObjects objectAtIndex:0];
  return labelForTitleBar;
}

-(void)setTitleWithMainTitle:(NSString *)mainTitle
										subTitle:(NSString *)subTitle
					isHasAnimationIcon:(BOOL)isHasAnimationIcon {
	
}
@end
