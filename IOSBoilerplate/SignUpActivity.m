//
//  SignUpActivity.m
//  ruyicai
//
//  Created by tangzhihua on 13-6-19.
//
//

#import "SignUpActivity.h"

#import "TitleBar.h"

@interface SignUpActivity () <UITextFieldDelegate>
@property (nonatomic, weak) TitleBar *titleBar;
@end

@implementation SignUpActivity
 

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
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setUserNameTextField:nil];
  [self setRealNameTextField:nil];
  [self setIdentityCardTextField:nil];
  [self setBodyLayout:nil];
  [self setTitleBarPlaceholder:nil];
  [self setBodyLayout:nil];
  [super viewDidUnload];
}

#pragma mark -
#pragma mark Activity 生命周期

-(void)onCreate:(Intent *)intent{
  PRPLog(@"--> onCreate ");
  [self registerKeyBoardNotification];
	
}
-(void)onDestroy {
  PRPLog(@" --> onDestroy ");
  
  [self unregisterKeyBoardNotification]; 
}
-(void)onResume {
  PRPLog(@"--> onResume ");
  
	
}

-(void)onPause {
  PRPLog(@"--> onPause ");
  
  
  [SVProgressHUD dismiss];
  
}

- (void) onActivityResult:(int) requestCode
               resultCode:(int) resultCode
                     data:(Intent *) data {
  PRPLog(@"--> onActivityResult");
  
	
}

#pragma mark -
#pragma mark 注册输入框事件观察者
-(void)registerKeyBoardNotification {
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  //
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}
-(void)unregisterKeyBoardNotification {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillShowNotification
                                                object:nil];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
}

-(void)keyboardWillShow:(NSNotification *)notification{
  CGRect keyboardFrame;
  [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
  keyboardFrame = [self.view convertRect:keyboardFrame toView:nil];
  double keyboardHeight = keyboardFrame.size.height;
  
  double animationDuration;
  UIViewAnimationCurve animationCurve;
  [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
  [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
  
  [UIView animateWithDuration:animationDuration delay:0.0f options:animationCurve animations:^{
    CGRect frame = self.bodyLayout.frame;
    frame.origin.y -= keyboardHeight;
    self.bodyLayout.frame = frame;
  } completion:^(BOOL finished) {
    
  }];
}
-(void)keyboardWillHide:(NSNotification *)notification{
  CGRect keyboardFrame;
  [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
  keyboardFrame = [self.view convertRect:keyboardFrame toView:nil];
  double keyboardHeight = keyboardFrame.size.height;
  
  double animationDuration;
  UIViewAnimationCurve animationCurve;
  [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
  [[notification.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
  
  [UIView animateWithDuration:animationDuration delay:0.0f options:animationCurve animations:^{
    CGRect frame = self.bodyLayout.frame;
    frame.origin.y += keyboardHeight;
    self.bodyLayout.frame = frame;
  } completion:^(BOOL finished) {
    
  }];

}
#pragma mark -
#pragma mark 初始化 UI
//
- (void) initTitleBar {
  TitleBar *titleBar = [TitleBar titleBar];
  titleBar.callbackBlock = ^(id control, NSUInteger action) {
    switch (action) {
        
      case kTitleBarActionEnum_RightButtonClicked:{// "返回"
        
        [self finish];
      }break;
        
      default: {
        RNAssert(NO, @"switch 执行了 default 分支.");
      }break;
    }
    
  };

	[titleBar setTitleByString:@"幸运选号"];
  [titleBar setRightButtonTitle:@"返回"];
  [self.titleBarPlaceholder addSubview:titleBar];
  
  // 要缓存 TitleBar 对象
  self.titleBar = titleBar;
}

- (IBAction)closeAllTextFieldKeyboard:(id)sender {
  [self resignFirstResponderForAllTextField];
}

-(void)resignFirstResponderForAllTextField {
   
  
  [self.userNameTextField resignFirstResponder];
  [self.realNameTextField resignFirstResponder];
  [self.identityCardTextField resignFirstResponder];
}
// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  return YES;
}
// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField {
  
}
// return YES to allow editing to stop and to resign first responder status.
// NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  return YES;
}
// may be called if forced even if shouldEndEditing returns NO
// (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField {
  
}
// return NO to not change text
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
// called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldClear:(UITextField *)textField;

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  return YES;
}


@end
