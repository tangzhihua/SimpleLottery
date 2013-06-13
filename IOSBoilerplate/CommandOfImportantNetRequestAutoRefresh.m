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

+(id)commandOfImportantNetRequestAutoRefresh {
	
  static CommandOfImportantNetRequestAutoRefresh *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}
@end
