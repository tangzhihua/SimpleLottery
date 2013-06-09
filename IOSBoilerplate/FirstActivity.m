//
//  FirstActivity.m
//  airizu
//
//  Created by 唐志华 on 12-12-22.
//
//

#import "FirstActivity.h"

#import "BeginnerGuideActivity.h"
#import "MainNavigationActivity.h"

#import "SoftwareUpdateNetRespondBean.h"
#import "AdImageInWelcomePageNetRespondBean.h"
#import "GlobalDataCacheForMemorySingleton.h"
#import "LocalCacheDataPathConstant.h"

static const NSString *const TAG = @"<FirstActivity>";

@interface FirstActivity ()

@end

@implementation FirstActivity

- (void)dealloc {
	 
  
  PRPLog(@"dealloc: %@ [0x%x]", TAG, [self hash]);
  
  // 一定要注销广播消息接收器
  [self unregisterReceiver];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  //if ([DeviceInformation isIPhone5]) {
    // 这里决不能设成 autorelease 的, 网上的代码就是 autorelease的, 4.3系统会崩溃, 因为被自动释放了
    self = [super initWithNibName:@"FirstActivity_iphone5" bundle:nibBundleOrNil];
  //} else {
    //self = [super initWithNibName:@"FirstActivity" bundle:nibBundleOrNil];
  //}
  
  return self;
}

- (void)viewDidLoad
{
  PRPLog(@"%@ --> viewDidLoad ", TAG);
  
  [super viewDidLoad];
  
	if ([GlobalDataCacheForMemorySingleton sharedInstance].isShowAdImageFromServer) {
		
		NSString *imagePath = [LocalCacheDataPathConstant importantDataCachePath];
		imagePath = [imagePath stringByAppendingFormat:@"/%@", kAdImageNameForWelcomePage];
		UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
		if (image != nil) {
			_adImage.image = image;
		}
		
	}
	
	if ([GlobalDataCacheForMemorySingleton sharedInstance].isFirstStartApp) {
		[GlobalDataCacheForMemorySingleton sharedInstance].isFirstStartApp = NO;
		// ??? 上AppStore 必须提示
		UIAlertView *alert = [[UIAlertView alloc]
													initWithTitle:@"尊敬的用户"
													message:@"博雅彩客户端将访问您的设备识别符"
													delegate:self
													cancelButtonTitle:@"确定"
													otherButtonTitles:nil];
		[alert show];
  }

  // 20130312 : 决不能在 viewDidLoad 中关闭自己或者启动新的Activity, 必须要使用异步机制.
  [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  
  [super viewDidUnload];
}

#pragma mark -
#pragma mark Activity 生命周期
-(void)onCreate:(Intent *)intent {
  PRPLog(@"%@ --> onCreate ", TAG);
	
	// 接收 : "从服务器获取重要信息成功"
  [self registerBroadcastReceiver];
	
}
-(void)onPause {
  PRPLog(@"%@ --> onPause ", TAG);
	
}
-(void)onResume {
  PRPLog(@"%@ --> onResume ", TAG);
	
}

#pragma mark -
#pragma mark
-(Intent *)intentForGotoBeginnerGuideActivity {
  return [Intent intentWithSpecificComponentClass:[BeginnerGuideActivity class]];
}

-(Intent *)intentForGotoMainActivity {
  return [Intent intentWithSpecificComponentClass:[MainNavigationActivity class]];
}

-(void)doneLoadingTableViewData{
	
  Intent *intent = nil;
  if ([GlobalDataCacheForMemorySingleton sharedInstance].isNeedShowBeginnerGuide) {
    intent = [self intentForGotoBeginnerGuideActivity];
  } else {
    intent = [self intentForGotoMainActivity];
  }
  
  [self finishSelfAndStartNewActivity:intent];
}

//
-(void)registerBroadcastReceiver {
  
  IntentFilter *intentFilter = [IntentFilter intentFilter];
  // 向通知中心注册通知 : "从服务器获取重要信息成功"
  [intentFilter.actions addObject:[[NSNumber numberWithUnsignedInteger:kUserNotificationEnum_GetImportantInfoFromServerSuccess] stringValue]];
  
  [self registerReceiver:intentFilter];
}

#pragma mark -
#pragma mark 实现 BroadcastReceiverDelegate 代理
-(void)onReceive:(Intent *)intent {
  NSInteger userNotificationEnum = [[intent action] integerValue];
  switch (userNotificationEnum) {
    case kUserNotificationEnum_GetImportantInfoFromServerSuccess:{
      //
		 
			
    }break;
      
			
			
    default:{
      
    }break;
  }
}


@end
