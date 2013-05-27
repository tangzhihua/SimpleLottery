//
//  HomepageActivity.h
//  gameqa
//
//  Created by user on 12-9-11.
//
//
//  修改记录:
//          1) 20130122 完成第一版本正式代码
//

#import <UIKit/UIKit.h>
#import "CustomControlDelegate.h"

@interface MainNavigationActivity : Activity <UITabBarDelegate, CustomControlDelegate>{
  
}

//
@property (weak, nonatomic) IBOutlet UIView *titleBarPlaceholder;
// tabhost 的 content区域
@property (weak, nonatomic) IBOutlet UIView *tabContent;
// tabhost 的 tabbar区域
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end
