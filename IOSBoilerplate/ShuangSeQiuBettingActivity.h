//
//  ShuangSeQiuBettingActivity.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-21.
//
//

#import "Activity.h"
#import "CustomControlDelegate.h"

@interface ShuangSeQiuBettingActivity : Activity <CustomControlDelegate>{
	
}


@property (weak, nonatomic) IBOutlet UIView *titleBarPlaceholder;
@property (weak, nonatomic) IBOutlet UIView *bodyLayout;
@property (weak, nonatomic) IBOutlet UIView *bettingInfoBarPlaceholder;


@end
