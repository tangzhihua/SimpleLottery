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
  if (!self.isExecuted) {
		self.isExecuted = YES;

    __weak id weakSelf = self;
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      do {
        _versionBean = [ToolsFunctionForThisProgect synchronousRequestAppNewVersionAndReturnVersionBean];
        if (![_versionBean isKindOfClass:[VersionNetRespondBean class]]) {
          break;
        }
        
        if ([_versionBean.latestVersion isEqualToString:[ToolsFunctionForThisProgect localAppVersion]]) {
          break;
        }
        
        [weakSelf newAppUpdateHint];
        
        // 在iOS5.0的系统之上时, UI操作都必须回到 MainThread
        //[self performSelectorOnMainThread:@selector(newAppUpdateHint) withObject:nil waitUntilDone:NO];
        
      } while (NO);
    });
  }  
}

#pragma mark -
#pragma mark 单例方法群

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
    _isExecuted = NO;

  }
  
  return self;
}

+(id)commandForNewAppVersionCheck {
	
  static CommandForNewAppVersionCheck *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark 子线程 ------> App新版本检查
 

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
