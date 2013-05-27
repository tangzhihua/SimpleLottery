//
//  LabelForTitleBar.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-21.
//
//

#import <UIKit/UIKit.h>

@interface LabelForTitleBar : UIView {
	
	
}

+(id)labelForTitleBar;

-(void)setTitleWithMainTitle:(NSString *)mainTitle
										subTitle:(NSString *)subTitle
					isHasAnimationIcon:(BOOL)isHasAnimationIcon;
@end
