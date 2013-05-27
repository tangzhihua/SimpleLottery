//
//  TitleBar.h
//  airizu
//
//  Created by 唐志华 on 12-12-24.
//
//  修改记录:
//          1) 20130122 完成第一版本正式代码
//

#import <UIKit/UIKit.h>


@protocol CustomControlDelegate;

typedef NS_ENUM(NSUInteger, TitleBarActionEnum)  {
  //
  kTitleBarActionEnum_RightButtonClicked
};

@interface TitleBar : UIView {
  
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@property (nonatomic, weak) id<CustomControlDelegate> delegate;

+(id)titleBar;

-(void)setTitleByString:(NSString *)titleNameString;
-(void)setRightButtonTitle:(NSString *)titleNameString;

-(void)hideRightButton:(BOOL)hide;
-(void)hideRightLabel:(BOOL)hide;
@end
