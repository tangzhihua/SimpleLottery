//
//  SignUpActivity.h
//  ruyicai
//
//  Created by tangzhihua on 13-6-19.
//
//

#import "Activity.h"

@interface SignUpActivity : Activity {
  
}
@property (weak, nonatomic) IBOutlet UIView *titleBarPlaceholder;

@property (weak, nonatomic) IBOutlet UIControl *bodyLayout;
 
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *realNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *identityCardTextField;


@end
