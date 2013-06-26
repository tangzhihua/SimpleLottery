//
//  TitleBarOfBetView.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-19.
//
//

#import "TitleBarOfBetView.h"
#import "LabelForTitleBar.h"


@interface TitleBarOfBetView ()
@property (nonatomic, weak) LabelForTitleBar *labelForTitleBar;
@end




@implementation TitleBarOfBetView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		
		
		
	}
	return self;
}

- (IBAction)buttonForTitleBarOnClickListener:(UIButton *)sender {
	
	do {
    if (self.callbackBlock == NULL) {
      break;
    }
		
		TitleBarOfBetViewActionEnum actionEnum;
		if (sender == self.leftButton) {
			actionEnum = kTitleBarOfBetViewActionEnum_LeftButtonClicked;
		} else if (sender == self.rightButtonOne) {
			actionEnum = kTitleBarOfBetViewActionEnum_RightButtonClickedOne;
		} else if (sender == self.rightButtonTwo) {
			actionEnum = kTitleBarOfBetViewActionEnum_RightButtonClickedTwo;
		} else {
			
			// 异常
			break;
		}
		
    self.callbackBlock(self, actionEnum);
		
	} while (NO);

	
}


-(void)setTitleWithMainTitle:(NSString *)mainTitle
										subTitle:(NSString *)subTitle
					isHasAnimationIcon:(BOOL)isHasAnimationIcon {
	
}

-(void)loadControlDefaultUI {
	[self.leftButton setBackgroundImage:[[UIImage imageNamed:@"nav_left_btn_bg_default"]
																			 resizableImageWithCapInsets:UIEdgeInsetsMake(15, 22, 15, 22)]
														 forState:UIControlStateNormal];
	[self.leftButton setBackgroundImage:[[UIImage imageNamed:@"nav_left_btn_bg_highlighted"]
																			 resizableImageWithCapInsets:UIEdgeInsetsMake(15, 22, 15, 22)]
														 forState:UIControlStateHighlighted];
	
	[self.rightButtonOne setBackgroundImage:[[UIImage imageNamed:@"nav_right_btn_bg_default"]
																					 resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 20, 15)]
																 forState:UIControlStateNormal];
	[self.rightButtonOne setBackgroundImage:[[UIImage imageNamed:@"nav_right_btn_bg_highlighted"]
																					 resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 20, 15)]
																 forState:UIControlStateHighlighted];
	
	[self.rightButtonTwo setBackgroundImage:[[UIImage imageNamed:@"nav_right_btn_bg_default"]
																					 resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 20, 15)]
																 forState:UIControlStateNormal];
	[self.rightButtonTwo setBackgroundImage:[[UIImage imageNamed:@"nav_right_btn_bg_highlighted"]
																					 resizableImageWithCapInsets:UIEdgeInsetsMake(20, 15, 20, 15)]
																 forState:UIControlStateHighlighted];
	
	//
	self.labelForTitleBar = [LabelForTitleBar labelForTitleBar];
	[self.titleViewPlaceholder addSubview:self.labelForTitleBar];
}

-(void)debugUICode {
	self.leftButton.hidden = YES;
	[self.leftButton setBackgroundColor:[UIColor clearColor]];
	self.rightButtonOne.hidden = YES;
	[self.rightButtonOne setBackgroundColor:[UIColor clearColor]];
	self.rightButtonTwo.hidden = YES;
	[self.rightButtonTwo setBackgroundColor:[UIColor clearColor]];
	
	self.titleViewPlaceholder.hidden = YES;
	[self.titleViewPlaceholder setBackgroundColor:[UIColor clearColor]];
}

-(void)customControl:(id)control onAction:(NSUInteger)action {
	
}

+ (NSString *) nibName {
  return NSStringFromClass([self class]);
}

+ (UINib *) nib {
  NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
  return [UINib nibWithNibName:[self nibName] bundle:classBundle];
}


+(id)titleBarOfBetView {
  NSArray *nibObjects = [[self nib] instantiateWithOwner:nil options:nil];
  TitleBarOfBetView *titleBar = [nibObjects objectAtIndex:0];
	
	[titleBar debugUICode];
	
	
	
	[titleBar loadControlDefaultUI];
  return titleBar;
}
@end
