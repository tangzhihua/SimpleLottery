//
//  ShuangSeQiuBettingActivity.m
//  ruyicai
//
//  Created by 熊猫 on 13-5-21.
//
//

#import "ShuangSeQiuBettingActivity.h"

//
#import "TitleBarOfBetView.h"

@interface ShuangSeQiuBettingActivity ()
@property (nonatomic, weak) TitleBarOfBetView *titleBar;
@end

@implementation ShuangSeQiuBettingActivity

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
	
	// 初始化UI
  [self initTitleBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Activity 生命周期

-(void)onCreate:(Intent *)intent{
  PRPLog(@"--> onCreate ");
  
	
}

-(void)onResume {
  PRPLog(@"--> onResume ");
   
	
}

-(void)onPause {
  PRPLog(@"--> onPause ");
  
 
  
  [SVProgressHUD dismiss];
  
  [[DomainProtocolNetHelperSingleton sharedInstance] cancelAllNetRequestWithThisNetRespondDelegate:self];
 
}

- (void) onActivityResult:(int) requestCode
               resultCode:(int) resultCode
                     data:(Intent *) data {
  PRPLog(@"--> onActivityResult");
  
	
}
- (void)viewDidUnload {
	[self setTitleBarPlaceholder:nil];
	[self setBodyLayout:nil];
	[self setBettingInfoBarPlaceholder:nil];
	[super viewDidUnload];
}

#pragma mark -
#pragma mark 初始化UI
//
- (void) initTitleBar {
  TitleBarOfBetView *titleBar = [TitleBarOfBetView titleBarOfBetView];
  titleBar.delegate = self;
	titleBar.leftButton.hidden = NO;
	[titleBar.leftButton setTitle:@"购彩大厅" forState:UIControlStateNormal];
	titleBar.titleViewPlaceholder.hidden = NO;
	titleBar.rightButtonOne.hidden = NO;
	
  [self.titleBarPlaceholder addSubview:titleBar];
  
  self.titleBar = titleBar;
}

#pragma mark -
#pragma mark 实现 CustomControlDelegate 接口
-(void)customControl:(id)control onAction:(NSUInteger)action {
	
	if (control == self.titleBar) {
		switch (action) {
				
			case kTitleBarOfBetViewActionEnum_LeftButtonClicked:{
				[self finish];
			}break;
				
			case kTitleBarOfBetViewActionEnum_RightButtonClickedOne:{
				// 跳往 帮助界面
			}break;
			default:
				break;
		}
	}
  
}
@end
