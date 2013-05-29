//
//  CommandForNewAppVersionCheck.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForNewAppVersionCheck.h"
#import "BrowserViewController.h"
#import "VersionNetRespondBean.h"


static CommandForNewAppVersionCheck *singletonInstance = nil;


@interface CommandForNewAppVersionCheck ()

// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
@end

@implementation CommandForNewAppVersionCheck {
	
	
	// 检查当前App的版本信息
	VersionNetRespondBean *_versionBean;
}

typedef NS_ENUM(NSInteger, AlertTypeEnum) {
  // 新版本升级提示
  kAlertTypeEnum_DownloadNewVersion = 0
};

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  if (!_isExecuted) {
		_isExecuted = YES;
		
    //[NSThread detachNewThreadSelector:@selector(childThreadForNewAppVersionCheck) toTarget:self withObject:nil];
  }  
}

+(id)commandForNewAppVersionCheck {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandForNewAppVersionCheck alloc] init];
    singletonInstance.isExecuted = NO;
  }
  return singletonInstance;
}

#pragma mark -
#pragma mark 子线程 ------> App新版本检查
- (void) childThreadForNewAppVersionCheck {
  
	@autoreleasepool {
    do {
			_versionBean = [ToolsFunctionForThisProgect synchronousRequestAppNewVersionAndReturnVersionBean];
			if (![_versionBean isKindOfClass:[VersionNetRespondBean class]]) {
				break;
			}
			
			if ([_versionBean.latestVersion isEqualToString:[ToolsFunctionForThisProgect localAppVersion]]) {
				break;
			}
			
			// 在iOS5.0的系统之上时, UI操作都必须回到 MainThread
			[self performSelectorOnMainThread:@selector(newAppUpdateHint) withObject:nil waitUntilDone:NO];
			
		} while (NO);
	}
}

-(void)newAppUpdateHint{
  UIAlertView *alert
  = [[UIAlertView alloc] initWithTitle:nil
                               message:@"有新的版本更新，是否前往更新？"
                              delegate:self
                     cancelButtonTitle:@"关闭"
                     otherButtonTitles:@"更新", nil];
  alert.tag = kAlertTypeEnum_DownloadNewVersion;
  [alert show];
}

#pragma mark -
#pragma mark 实现 UIAlertViewDelegate 接口
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  switch (alertView.tag) {
    case kAlertTypeEnum_DownloadNewVersion:{
      if (buttonIndex != [alertView cancelButtonIndex]) {
        MyApplication *application = (MyApplication *)[UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:_versionBean.downloadAddress] forceOpenInSafari:YES];
      }
    }break;
			
    default:
      break;
  }
  
}
@end
