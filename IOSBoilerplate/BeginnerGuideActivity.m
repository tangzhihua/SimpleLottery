//
//  FirstLoginHelpActivity.m
//  airizu
//
//  Created by 唐志华 on 13-3-9.
//
//

#import "BeginnerGuideActivity.h"
#import "MainNavigationActivity.h"









@interface BeginnerGuideActivity ()

@end









@implementation BeginnerGuideActivity

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
  
  [self initImageGallery];
}

- (void)viewDidUnload {
  
  [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)initImageGallery {
  
	 
  NSArray *imageNameArray = [NSArray arrayWithObjects:@"beginner_guide_1.png", @"beginner_guide_2.png", @"beginner_guide_3.png", @"beginner_guide_4.png", @"beginner_guide_5.png",  nil];
  
  // 设置 scrollView
  CGRect scrollViewOriginalFrame = _imageScrollView.frame;
  
  _imageScrollView.contentSize
  = CGSizeMake(scrollViewOriginalFrame.size.width * imageNameArray.count,
               scrollViewOriginalFrame.size.height);
  
  CGSize imageSize
  = CGSizeMake(scrollViewOriginalFrame.size.width,
               scrollViewOriginalFrame.size.height);
  
  for (int i=0; i<imageNameArray.count; i++) {
    NSString *imageUrlString = [imageNameArray objectAtIndex:i];
    UIImageView *roomPhotoImageView
    = [[UIImageView alloc] initWithFrame:CGRectMake(i * scrollViewOriginalFrame.size.width,
                                                    0,
                                                    imageSize.width,
                                                    imageSize.height)];
    //
    [roomPhotoImageView setUserInteractionEnabled:YES];
    //
    [roomPhotoImageView setImage:[UIImage imageNamed:imageUrlString]];
    [roomPhotoImageView setContentMode:UIViewContentModeScaleToFill];
    [_imageScrollView addSubview:roomPhotoImageView];
     
  }
  
  //点击 按钮
  UIButton *buttonForBeganToExperience = [UIButton buttonWithType:UIButtonTypeCustom];
  
  CGFloat xOffset = (_imageScrollView.contentSize.width - scrollViewOriginalFrame.size.width) + (scrollViewOriginalFrame.size.width - 172)/2;
  CGFloat yOffset = [UIScreen mainScreen].bounds.size.height - 150;
  buttonForBeganToExperience.frame
  = CGRectMake(xOffset,
               yOffset,
               375/2,
               172/2);
  [buttonForBeganToExperience setBackgroundImage:[UIImage imageNamed:@"beginner_guide_button.png"] forState:UIControlStateNormal];
  
  [buttonForBeganToExperience addTarget:self action:@selector(buttonForBeganToExperienceButtonOnClickListener) forControlEvents:UIControlEventTouchUpInside];
  [_imageScrollView addSubview:buttonForBeganToExperience];
  
}

// 点击按钮事件
-(void)buttonForBeganToExperienceButtonOnClickListener {
  
  // 下次不再显示 "新手帮助"
  [GlobalDataCacheForMemorySingleton sharedInstance].isNeedShowBeginnerGuide = NO;
  
  // 关闭自身, 并且启动 MainNavigationActivity
  Intent *intent = [Intent intentWithSpecificComponentClass:[MainNavigationActivity class]];
  [self finishSelfAndStartNewActivity:intent];
}

#pragma mark -
#pragma mark Activity 生命周期
-(void)onCreate:(Intent *)intent {
  PRPLog(@" --> onCreate ");
  
}
-(void)onDestroy {
  PRPLog(@" --> onDestroy ");
}
-(void)onPause {
  PRPLog(@" --> onPause ");
  
}
-(void)onResume {
  PRPLog(@" --> onResume ");
  
}
@end
