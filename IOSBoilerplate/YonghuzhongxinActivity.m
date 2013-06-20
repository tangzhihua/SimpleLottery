//
//  YonghuzhongxinActivity.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-19.
//
//

#import "YonghuzhongxinActivity.h"
#import "SignUpActivity.h"
@interface YonghuzhongxinActivity ()

@end

@implementation YonghuzhongxinActivity

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonLis:(id)sender {
  Intent *intent = [Intent intentWithSpecificComponentClass:[SignUpActivity class]];
  [self startActivity:intent];
}

@end
