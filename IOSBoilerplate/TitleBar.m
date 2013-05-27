//
//  TitleBar.m
//  airizu
//
//  Created by 唐志华 on 12-12-24.
//
//

#import "TitleBar.h"

#import "CustomControlDelegate.h"

//
@interface TitleBar ()
@property (nonatomic) CGRect rightButtonFrameForTwoWord;
 
@end

@implementation TitleBar

+ (NSString *) nibName {
  return NSStringFromClass([self class]);
}

+ (UINib *) nib {
  NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
  return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}

- (IBAction)buttonForTitleBarOnClickListener:(UIButton *)sender {
  if ([_delegate conformsToProtocol:@protocol(CustomControlDelegate)]) {
    if ([_delegate respondsToSelector:@selector(customControl:onAction:)]) {
      [_delegate customControl:self onAction:sender.tag];
    }
  }
}

+(id)titleBar {
  NSArray *nibObjects = [[self nib] instantiateWithOwner:nil options:nil];
  TitleBar *titleBar = [nibObjects objectAtIndex:0];
  titleBar.rightButton.tag = kTitleBarActionEnum_RightButtonClicked;
  titleBar.rightButtonFrameForTwoWord = titleBar.rightButton.frame;

	 
	[titleBar.rightButton setBackgroundImage:[[UIImage imageNamed:@"button_brown_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
																	forState:UIControlStateNormal];
	[titleBar.rightButton setBackgroundImage:[[UIImage imageNamed:@"button_brown_pressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]
																	forState:UIControlStateHighlighted];
  return titleBar;
}


 
-(void)setTitleByString:(NSString *)titleNameString {
	_titleLabel.hidden = NO;
	[_titleLabel setText:titleNameString];
}

-(void)setRightButtonTitle:(NSString *)titleNameString {
	
	if ([NSString isEmpty:titleNameString]) {
		_rightButton.hidden = YES;
	} else {
		
		if ([titleNameString length] > 2) {
			_rightButton.frame
			= CGRectMake(CGRectGetMinX(_rightButtonFrameForTwoWord) - CGRectGetWidth(_rightButtonFrameForTwoWord),
									 CGRectGetMinY(_rightButton.frame),
									 CGRectGetWidth(_rightButtonFrameForTwoWord) * 2,
									 CGRectGetHeight(_rightButton.frame));
			
		} else {
			_rightButton.frame = _rightButtonFrameForTwoWord;
			 
		}
		
		_rightButton.hidden = NO;
		[_rightButton setTitle:titleNameString forState:UIControlStateNormal];
	}
	
}

-(void)hideRightButton:(BOOL)hide {
  _rightButton.hidden = hide;
}

-(void)hideRightLabel:(BOOL)hide {
	_rightLabel.hidden = hide;
}
@end
