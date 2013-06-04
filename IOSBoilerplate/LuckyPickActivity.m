//
//  LuckyPickActivity.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-4.
//
//

#import "LuckyPickActivity.h"

#import "cocos2d.h"

#import "CustomControlDelegate.h"



#import "TitleBar.h"
#import "LuckyPickScene.h"






@interface LuckyPickActivity () <CustomControlDelegate, CCDirectorDelegate>
@property (nonatomic, weak) TitleBar *titleBar;
@end











@implementation LuckyPickActivity

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  
  [self initTitleBar];
  
  [self loadCocos2dView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setTitleBarPlaceholder:nil];
  [self setBodyLayout:nil];
  [super viewDidUnload];
}





#pragma mark -
#pragma mark Activity 生命周期
-(void)onCreate:(Intent *)intent {
  PRPLog(@"--> onCreate ");
  
  
}
-(void)onPause {
  PRPLog(@"--> onPause ");
  
  
}
-(void)onResume {
  PRPLog(@"--> onResume ");
  
}

-(void) loadCocos2dView {

	
	// Create a Navigation Controller with the Director
	[self.bodyLayout addSubview:[CCDirector sharedDirector].view];
  
	// for rotation and other messages
	[[CCDirector sharedDirector] setDelegate:self];
}

#pragma mark -
#pragma mark 初始化 UI
//
- (void) initTitleBar {
  TitleBar *titleBar = [TitleBar titleBar];
  titleBar.delegate = self;
	[titleBar setTitleByString:@"幸运选号"];
  [titleBar setRightButtonTitle:@"返回"];
  [self.titleBarPlaceholder addSubview:titleBar];
  
  // 要缓存 TitleBar 对象
  self.titleBar = titleBar;
}

#pragma mark -
#pragma mark 实现 CustomControlDelegate 接口
-(void)customControl:(id)control onAction:(NSUInteger)action {
  switch (action) {
      
    case kTitleBarActionEnum_RightButtonClicked:{// "返回"
      [[CCDirector sharedDirector] setDelegate:nil];
      [self finish];
    }break;
      
    default: {
      RNAssert(NO, @"switch 执行了 default 分支.");
    }break;
  }
}



#pragma mark -
#pragma mark 实现 CCDirectorDelegate 接口
// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director {
	if(director.runningScene == nil) {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		[director runWithScene: [LuckyPickScene scene]];
	}
}
@end
