//
//  TitleBar.h
//  airizu
//
//  Created by 唐志华 on 12-12-24.
//
//   
//

#import <UIKit/UIKit.h>




typedef NS_ENUM(NSUInteger, TitleBarActionEnum)  {
  //
  kTitleBarActionEnum_RightButtonClicked
};

@interface TitleBar : UIView {
  
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@property (nonatomic, copy) CustomControlCallbackBlock callbackBlock;

+(id)titleBar;

-(void)setTitleByString:(NSString *)titleNameString;
-(void)setRightButtonTitle:(NSString *)titleNameString;

-(void)hideRightButton:(BOOL)hide;
-(void)hideRightLabel:(BOOL)hide;
@end
