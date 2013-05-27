//
//  CommandOfImportantNetRequestAutoRefresh.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-17.
//
//

#import "CommandOfImportantNetRequestAutoRefresh.h"

 

@interface CommandOfImportantNetRequestAutoRefresh ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;

// 倒计时 Timer
@property (nonatomic, strong) NSTimer *timerForCountDown;

@end










@implementation CommandOfImportantNetRequestAutoRefresh


static CommandOfImportantNetRequestAutoRefresh *singletonInstance = nil;

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  
  if (!_isExecuted) {
    _isExecuted = YES;
		
		
		// 创建 timer
		NSRunLoop *runloop = [NSRunLoop currentRunLoop];
		self.timerForCountDown = [NSTimer timerWithTimeInterval:1.0f
																										 target:self selector:@selector(timerFireMethod:)
																									 userInfo:nil
																										repeats:YES];
		[runloop addTimer:self.timerForCountDown forMode:NSRunLoopCommonModes];
		[runloop addTimer:self.timerForCountDown forMode:UITrackingRunLoopMode];
		
  }
  
}

- (void)timerFireMethod:(NSTimer*)theTimer {
	
	
}


+(id)commandOfImportantNetRequestAutoRefresh {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandOfImportantNetRequestAutoRefresh alloc] init];
    singletonInstance.isExecuted = NO;
		
  }
  return singletonInstance;
}

@end
