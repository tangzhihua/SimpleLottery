//
//  KaijiangzhongxinActivity.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-19.
//
//

#import "KaijiangzhongxinActivity.h"

@interface KaijiangzhongxinActivity ()

@end

@implementation KaijiangzhongxinActivity

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

- (IBAction)testbutton:(id)sender {
  NSMutableArray *t = [NSMutableArray arrayWithCapacity:2];
  t[100];
}
@end
