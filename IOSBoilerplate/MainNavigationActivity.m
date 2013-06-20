//
//  HomepageActivity.m
//  gameqa
//
//  Created by user on 12-9-11.
//
//

#import "MainNavigationActivity.h"



#import "TitleBar.h"

#import "SimpleLocationHelperForBaiduLBS.h"

#import "IntentFilter.h"



#import "GoucaidatingActivity.h"
#import "HemaidatingActivity.h"
#import "KaijiangzhongxinActivity.h"
#import "YonghuzhongxinActivity.h"
#import "GengduoActivity.h"


#import "CustomControlDelegate.h"


 












@interface MainNavigationActivity () <UITabBarDelegate, CustomControlDelegate>


@end













@implementation MainNavigationActivity {
	// "购彩大厅"
	GoucaidatingActivity *_goucaidatingActivity;
	// "合买大厅"
	HemaidatingActivity *_hemaidatingActivity;
	// "开奖中心"
	KaijiangzhongxinActivity *_kaijiangzhongxinActivity;
	// "用户中心"
	YonghuzhongxinActivity *_yonghuzhongxinActivity;
	// "更多"
	GengduoActivity *_gengduoActivity;
	
	// 独立控件
	
	__weak TitleBar *_titleBar;
	
	// 当前处于显示状态的Activity
	__weak Activity *_activeActivity;
}


// 这里的 tag 一定要跟IB中的 Tab Bar Item 中的tag 一样.
typedef NS_ENUM(NSInteger, TabBarTagEnum) {
  kTabBarTagEnum_Goucaidating     = 0, // "购彩大厅"
  kTabBarTagEnum_Hemaidating      = 1, // "合买大厅"
  kTabBarTagEnum_Kaijiangzhongxin = 2, // "开奖中心"
  kTabBarTagEnum_Yonghuzhongxin   = 3, // "用户中心"
	kTabBarTagEnum_Gengduo          = 4  // "更多"
};

#pragma mark -
#pragma mark 内部方法群

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if ([DeviceInformation isIPhone5]) {
    // 这里决不能设成 autorelease 的, 网上的代码就是 autorelease的, 4.3系统会崩溃, 因为被自动释放了
    self = [super initWithNibName:@"MainNavigationActivity_iphone5" bundle:nibBundleOrNil];
  } else {
    self = [super initWithNibName:@"MainNavigationActivity" bundle:nibBundleOrNil];
  }
  
  if (self) {
    // Custom initialization
    PRPLog(@"init [0x%x]", [self hash]);
    
  }
  return self;
}

- (void)viewDidLoad
{
  PRPLog(@" --> viewDidLoad ");
  
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self initTitleBar];
  [self initTabHost];
  
}

- (void)viewDidUnload
{
  PRPLog(@" --> viewDidUnload ");
	
  _goucaidatingActivity = nil;
	_hemaidatingActivity = nil;
	_kaijiangzhongxinActivity = nil;
	_yonghuzhongxinActivity = nil;
	_gengduoActivity = nil;
  
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Activity 生命周期
-(void)onCreate:(Intent *)intent {
  PRPLog(@"--> onCreate ");
  
  // 接收 : 用户登录成功
  // 接收 : 获取用户地址成功
  // 接收 : 跳转到 "推荐首页"
  [self registerBroadcastReceiver];
}
-(void)onDestroy {
  PRPLog(@" --> onDestroy ");
  
  // 一定要注销广播消息接收器
  [self unregisterReceiver];
  
  //
  _activeActivity = nil;
}
-(void)onPause {
  PRPLog(@"--> onPause ");
  
  if (_activeActivity != nil) {
    [_activeActivity onPause];
  }
}
-(void)onResume {
  PRPLog(@"--> onResume ");
  
  if (_activeActivity != nil) {
    [_activeActivity onResume];
  } else {
    // 如果 _activeActivity 为 nil的话, 证明是第一次进入此界面
    // 设置第一个被选中的 item
    NSArray *items = self.tabBar.items;
    self.tabBar.selectedItem = items[kTabBarTagEnum_Goucaidating];
    [self tabBar:items[kTabBarTagEnum_Goucaidating] didSelectItem:self.tabBar.selectedItem];
  }
}

#pragma mark -
#pragma mark 覆写父类 Activity 的方法
- (void) onActivityResult:(int) requestCode
               resultCode:(int) resultCode
                     data:(Intent *) data {
  [_activeActivity onActivityResult:requestCode resultCode:resultCode data:data];
}

#pragma mark -
#pragma mark 初始化 UI
//
- (void) initTitleBar {
  TitleBar *titleBar = [TitleBar titleBar];
  titleBar.delegate = self;
	
  [_titleBarPlaceholder addSubview:titleBar];
  
  // 要缓存 TitleBar 对象
  _titleBar = titleBar;
}

- (void) updateTitleBarUIByTabItemTag:(TabBarTagEnum) tag {
	
  switch (tag) {
    case kTabBarTagEnum_Goucaidating:{// "购彩大厅"
      [_titleBar setRightButtonTitle:@"登录注册"];
      [_titleBar hideRightButton:NO];
      [_titleBar setTitleByString:@"购彩大厅"];
    }break;
      
    case kTabBarTagEnum_Hemaidating:{// "合买大厅"
      
      [_titleBar setRightButtonTitle:@"筛选"];
      [_titleBar hideRightButton:NO];
      [_titleBar setTitleByString:@"合买大厅-所有彩种"];
      
    }break;
      
    case kTabBarTagEnum_Kaijiangzhongxin:{// "开奖中心"
      
			
      [_titleBar hideRightButton:YES];
      [_titleBar setTitleByString:@"开奖中心"];
      
    }break;
      
    case kTabBarTagEnum_Yonghuzhongxin:{// "用户中心"
      
      
      [_titleBar hideRightButton:YES];
      [_titleBar setTitleByString:@"用户中心"];
      
    }break;
			
		case kTabBarTagEnum_Gengduo:{// "更多"
      
      
      [_titleBar hideRightButton:YES];
      [_titleBar setTitleByString:@"更多"];
      
    }break;
    default:
      break;
  }
}

- (void) initTabHost {
  _goucaidatingActivity = [[GoucaidatingActivity alloc] init];
	_hemaidatingActivity = [[HemaidatingActivity alloc] init];
	_kaijiangzhongxinActivity = [[KaijiangzhongxinActivity alloc] init];
	_yonghuzhongxinActivity = [[YonghuzhongxinActivity alloc] init];
	_gengduoActivity = [[GengduoActivity alloc] init];
}

#pragma mark -
#pragma mark 实现 CustomControlDelegate 接口
-(void)customControl:(id)control onAction:(NSUInteger)action {
  switch (action) {
      
    case kTitleBarActionEnum_RightButtonClicked:{// "拨打订购热线"
      [[SimpleCallSingleton sharedInstance] callCustomerServicePhoneAndShowInThisView:self.view.window];
    }break;
      
    default:
      break;
  }
}

#pragma mark -
#pragma mark 实现 UITabBarDelegate 接口

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
  NSInteger tabBarItemTag = [item tag];
  
  [self.tabBar setHidden:NO];
  [self updateTitleBarUIByTabItemTag:tabBarItemTag];
  
  BOOL isNeedChangeTabContent = NO;
  Activity *newTargetTabContent = nil;
  UIView *oldTabContentView = [[_tabContent subviews] lastObject];
  switch (tabBarItemTag) {
      
    case kTabBarTagEnum_Goucaidating:{// "购彩大厅"
      
      if (oldTabContentView != _goucaidatingActivity.view) {
        isNeedChangeTabContent = YES;
        newTargetTabContent = _goucaidatingActivity;
      }
      
    }break;
      
    case kTabBarTagEnum_Hemaidating:{// "合买大厅"
      
      if (oldTabContentView != _hemaidatingActivity.view) {
        isNeedChangeTabContent = YES;
        newTargetTabContent = _hemaidatingActivity;
      }
    }break;
      
    case kTabBarTagEnum_Kaijiangzhongxin:{// "开奖公告"
      
      if (oldTabContentView != _kaijiangzhongxinActivity.view) {
        
        isNeedChangeTabContent = YES;
        newTargetTabContent = _kaijiangzhongxinActivity;
      }
    }break;
      
    case kTabBarTagEnum_Yonghuzhongxin:{// "用户中心"
      
      if (oldTabContentView != _yonghuzhongxinActivity.view) {
        isNeedChangeTabContent = YES;
        newTargetTabContent = _yonghuzhongxinActivity;
      }
    }break;
      
		case kTabBarTagEnum_Gengduo:{// "更多"
      
      if (oldTabContentView != _gengduoActivity.view) {
        isNeedChangeTabContent = YES;
        newTargetTabContent = _gengduoActivity;
      }
    }break;
			
    default:{
      
    }break;
  }
  
  if (isNeedChangeTabContent) {
    
    Activity *lastActivity = _activeActivity;
    [lastActivity onPause];
    [oldTabContentView removeFromSuperview];
    
    // 更换 tabContent
    _activeActivity = newTargetTabContent;
    [_tabContent addSubview:newTargetTabContent.view];
    [_activeActivity onResume];
    
  }
}

//
-(void)registerBroadcastReceiver {
  
  IntentFilter *intentFilter = [IntentFilter intentFilter];
  // 向通知中心注册通知 : "返回 推荐界面"
  [intentFilter.actions addObject:[[NSNumber numberWithUnsignedInteger:kUserNotificationEnum_GotoGoucaidatingActivity] stringValue]];
  
  [self registerReceiver:intentFilter];
}

#pragma mark -
#pragma mark 实现 BroadcastReceiverDelegate 代理
-(void)onReceive:(Intent *)intent {
  NSInteger userNotificationEnum = [[intent action] integerValue];
  switch (userNotificationEnum) {
    case kUserNotificationEnum_GotoGoucaidatingActivity:{
      //
      NSArray *items = self.tabBar.items;
      self.tabBar.selectedItem = items[kTabBarTagEnum_Goucaidating];
      [self tabBar:items[kTabBarTagEnum_Goucaidating] didSelectItem:self.tabBar.selectedItem];
    }break;
      
			
			
    default:{
      
    }break;
  }
}

@end
