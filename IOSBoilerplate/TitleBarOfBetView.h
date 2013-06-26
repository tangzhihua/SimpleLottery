//
//  TitleBarOfBetView.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-19.
//
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, TitleBarOfBetViewActionEnum)  {
  //
  kTitleBarOfBetViewActionEnum_LeftButtonClicked = 0,
	kTitleBarOfBetViewActionEnum_TitleChangeButtonClickedOfOpen,
	kTitleBarOfBetViewActionEnum_TitleChangeButtonClickedOfClose,
	kTitleBarOfBetViewActionEnum_RightButtonClickedOne,
	kTitleBarOfBetViewActionEnum_RightButtonClickedTwo
};


@interface TitleBarOfBetView : UIView {
	
}

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButtonOne;

@property (weak, nonatomic) IBOutlet UIButton *rightButtonTwo;
@property (weak, nonatomic) IBOutlet UIView *titleViewPlaceholder;

@property (nonatomic, copy) CustomControlCallbackBlock callbackBlock;

-(void)setTitleWithMainTitle:(NSString *)mainTitle
										subTitle:(NSString *)subTitle
					isHasAnimationIcon:(BOOL)isHasAnimationIcon;


+(id)titleBarOfBetView;
@end
