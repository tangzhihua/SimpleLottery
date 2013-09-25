//
//  KaijiangzhongxinActivity.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-19.
//
//

#import "KaijiangzhongxinActivity.h"


#import "LotteryAnnouncement.h"
#import "LotteryAnnouncementNetRequestBean.h"
#import "LotteryAnnouncementNetRespondBean.h"

#import "DomainBeanNetworkEngineSingleton.h"

#import "UIImageView+MKNetworkKitAdditions.h"








@interface KaijiangzhongxinActivity () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

// 彩票列表 cell 缓存列表, 提前初始化好, 提高效率
@property (nonatomic, strong) NSMutableArray *cellArrayOfLotteryList;

// 开奖公告
@property (nonatomic, strong) LotteryAnnouncementNetRespondBean *lotteryAnnouncementNetRespondBean;
@property (nonatomic, assign) NSInteger netRequestIndexForLotteryAnnouncement;

@property (atomic, strong) DomainNetRespondHandleInUIThreadSuccessedBlock domainNetRespondHandleInUIThreadSuccessedBlock;
@property (atomic, strong) DomainNetRespondHandleInUIThreadFailedBlock domainNetRespondHandleInUIThreadFailedBlock;
@end













@implementation KaijiangzhongxinActivity {
  
}

static NSArray* flickrPhotos;
+(void)initialize {
  // 这是为了子类化当前类后, 父类的initialize方法会被调用2次
  if (self == [KaijiangzhongxinActivity class]) {
    flickrPhotos = [[NSArray alloc] initWithObjects:
                    @"http://farm4.static.flickr.com/3483/4017988903_84858e0e6e_s.jpg",
                    @"http://farm3.static.flickr.com/2436/4015786038_7b530f9cce_s.jpg",
                    @"http://farm3.static.flickr.com/2643/4025878602_85f7cd1724_s.jpg",
                    @"http://farm3.static.flickr.com/2494/4011329502_09e6d03b4d_s.jpg",
                    @"http://farm4.static.flickr.com/3103/4027083130_b187516f48_s.jpg",
                    @"http://farm3.static.flickr.com/2557/4007449481_59d7a8d848_s.jpg",
                    @"http://farm4.static.flickr.com/3479/4021202695_381ff2e9bc_s.jpg",
                    @"http://farm3.static.flickr.com/2598/4010566163_1426fa3389_s.jpg",
                    @"http://farm3.static.flickr.com/2589/4015601052_ba81c7544b_s.jpg",
                    @"http://farm3.static.flickr.com/2551/4025950491_20a7615b69_s.jpg",
                    @"http://farm3.static.flickr.com/2534/4009711388_66ae983c7e_s.jpg",
                    @"http://farm3.static.flickr.com/2469/4008746903_e90b09241d_s.jpg",
                    @"http://farm3.static.flickr.com/2432/4025384253_0e521644dd_s.jpg",
                    @"http://farm3.static.flickr.com/2585/4023151655_d63ecd4025_s.jpg",
                    @"http://farm3.static.flickr.com/2421/4019640142_7ee56e4b1c_s.jpg",
                    @"http://farm4.static.flickr.com/3511/4016743839_69370584f3_s.jpg",
                    @"http://farm3.static.flickr.com/2547/4016748951_f52700aeaa_s.jpg",
                    @"http://farm4.static.flickr.com/3639/4014434499_b832e04061_s.jpg",
                    @"http://farm3.static.flickr.com/2190/4018090737_846760e3da_s.jpg",
                    @"http://farm4.static.flickr.com/3524/4018550718_c4f43a83d0_s.jpg",
                    @"http://farm4.static.flickr.com/3511/4008358164_a5def010c7_s.jpg",
                    @"http://farm3.static.flickr.com/2792/4023230831_34b3dfc1ea_s.jpg",
                    @"http://farm3.static.flickr.com/2438/4021904945_c3706a652a_s.jpg",
                    @"http://farm3.static.flickr.com/2655/4012063376_5e120a4428_s.jpg",
                    @"http://farm3.static.flickr.com/2637/4009152189_9fd9034b60_s.jpg",
                    @"http://farm3.static.flickr.com/2673/4017117612_ae364923b0_s.jpg",
                    @"http://farm3.static.flickr.com/2495/4020233997_453672b620_s.jpg",
                    @"http://farm3.static.flickr.com/2586/4014510731_47e9a9b73d_s.jpg",
                    @"http://farm3.static.flickr.com/2739/4025489621_65264987f8_s.jpg",
                    @"http://farm3.static.flickr.com/2577/4016420951_def68019dd_s.jpg",
                    @"http://farm3.static.flickr.com/2500/4026353518_15268c4488_s.jpg",
                    @"http://farm3.static.flickr.com/2453/4008435378_8e16c06970_s.jpg",
                    @"http://farm3.static.flickr.com/2745/4026003536_31da429e13_s.jpg",
                    @"http://farm3.static.flickr.com/2674/4019640830_31e067d771_s.jpg",
                    @"http://farm3.static.flickr.com/2671/4017291336_b39b72224c_s.jpg",
                    @"http://farm3.static.flickr.com/2665/4015357692_6d31ab729b_s.jpg",
                    @"http://farm3.static.flickr.com/2475/4009936307_9a6039aec7_s.jpg",
                    @"http://farm3.static.flickr.com/2436/4019681008_a5da6093d0_s.jpg",
                    @"http://farm3.static.flickr.com/2475/4012817856_0e97e6718b_s.jpg",
                    @"http://farm3.static.flickr.com/2458/4011407242_0073aa2d22_s.jpg",
                    @"http://farm4.static.flickr.com/3509/4017070907_cea45a8d3a_s.jpg",
                    @"http://farm4.static.flickr.com/3488/4020067072_7c60a7a60a_s.jpg",
                    @"http://farm4.static.flickr.com/3503/4011136126_80c3b02986_s.jpg",
                    @"http://farm3.static.flickr.com/2751/4021887851_c5626ff59a_s.jpg",
                    @"http://farm3.static.flickr.com/2700/4020348292_856262abc7_s.jpg",
                    @"http://farm3.static.flickr.com/2620/4010967777_005fdd1867_s.jpg",
                    @"http://farm4.static.flickr.com/3517/4011690509_4ce02b32cf_s.jpg",
                    @"http://farm3.static.flickr.com/2454/4012955142_7177f21bf4_s.jpg",
                    @"http://farm3.static.flickr.com/2538/4014440923_a2b9824628_s.jpg",
                    @"http://farm3.static.flickr.com/2635/4010051525_74df73bbd7_s.jpg",
                    @"http://farm3.static.flickr.com/2752/4020781123_baaa208689_s.jpg",
                    @"http://farm3.static.flickr.com/2622/4014471899_05043a20e3_s.jpg",
                    @"http://farm3.static.flickr.com/2780/4022823482_26e5530c84_s.jpg",
                    @"http://farm4.static.flickr.com/3515/4016721686_c828925456_s.jpg",
                    @"http://farm3.static.flickr.com/2575/4022946879_977e8df918_s.jpg",
                    @"http://farm3.static.flickr.com/2648/4018130671_8390158767_s.jpg",
                    @"http://farm3.static.flickr.com/2493/4022863018_6197f81c8d_s.jpg",
                    @"http://farm4.static.flickr.com/3216/4018267822_e90308c44c_s.jpg",
                    @"http://farm3.static.flickr.com/2530/4009339944_4d9eb769fc_s.jpg",
                    @"http://farm3.static.flickr.com/2577/4026000780_e615efd67c_s.jpg",
                    @"http://farm4.static.flickr.com/3499/4018569395_a4483387b0_s.jpg",
                    @"http://farm4.static.flickr.com/3509/4019095546_c0f110bc1c_s.jpg",
                    @"http://farm3.static.flickr.com/2579/4022669316_42065ea829_s.jpg",
                    @"http://farm3.static.flickr.com/2560/4009382268_7d8812fe98_s.jpg",
                    @"http://farm3.static.flickr.com/2645/4025740346_03e948466f_s.jpg",
                    @"http://farm3.static.flickr.com/2800/4021259282_122075711c_s.jpg",
                    @"http://farm3.static.flickr.com/2430/4019625100_b23147c748_s.jpg",
                    @"http://farm3.static.flickr.com/2527/4026734100_e52fc21603_s.jpg",
                    @"http://farm3.static.flickr.com/2635/4020892994_e6101d0f0e_s.jpg",
                    @"http://farm3.static.flickr.com/2672/4008379269_157e86729e_s.jpg",
                    @"http://farm3.static.flickr.com/2620/4009289798_bdcf26500a_s.jpg",
                    @"http://farm3.static.flickr.com/2455/4024701539_9ee5b7fac6_s.jpg",
                    @"http://farm3.static.flickr.com/2588/4010668107_97207ceb22_s.jpg",
                    @"http://farm3.static.flickr.com/2459/4023575284_cd01deba10_s.jpg",
                    @"http://farm3.static.flickr.com/2613/4019518861_5fbd679d61_s.jpg",
                    @"http://farm3.static.flickr.com/2429/4027017756_f9e6102700_s.jpg",
                    @"http://farm3.static.flickr.com/2487/4020209639_81a3a2bbc2_s.jpg",
                    @"http://farm3.static.flickr.com/2670/4013657757_12c694c4ee_s.jpg",
                    @"http://farm3.static.flickr.com/2804/4019095448_049ef023e3_s.jpg",
                    @"http://farm3.static.flickr.com/2197/4011866354_0948246520_s.jpg",
                    @"http://farm3.static.flickr.com/2557/4010652749_1d0c35fabd_s.jpg",
                    @"http://farm3.static.flickr.com/2543/4010847393_9844b1a37f_s.jpg",
                    @"http://farm3.static.flickr.com/2724/4021388365_7c739b9b16_s.jpg",
                    @"http://farm4.static.flickr.com/3484/4018164769_2e68f895dc_s.jpg",
                    @"http://farm3.static.flickr.com/2643/4020492457_84c4140077_s.jpg",
                    @"http://farm3.static.flickr.com/2670/4011966914_e1849fda91_s.jpg",
                    @"http://farm3.static.flickr.com/2653/4015298872_d4ef36c14a_s.jpg",
                    @"http://farm3.static.flickr.com/2710/4024844149_40dca40cd2_s.jpg",
                    @"http://farm3.static.flickr.com/2546/4012296861_146d4805df_s.jpg",
                    nil];
  }
}
//
-(DomainNetRespondHandleInUIThreadSuccessedBlock)domainNetRespondHandleInUIThreadSuccessedBlock{
  if (_domainNetRespondHandleInUIThreadSuccessedBlock == NULL) {
    _domainNetRespondHandleInUIThreadSuccessedBlock = ^(NSUInteger requestEvent, NSInteger netRequestIndex, id respondDomainBean) {
			
    };
  }
  return _domainNetRespondHandleInUIThreadSuccessedBlock;
}
//
-(DomainNetRespondHandleInUIThreadFailedBlock)domainNetRespondHandleInUIThreadFailedBlock{
  if (_domainNetRespondHandleInUIThreadFailedBlock == NULL) {
    _domainNetRespondHandleInUIThreadFailedBlock = ^(NSUInteger requestEvent, NSInteger netRequestIndex, NetRequestErrorBean *error) {
      
    };
  }
  return _domainNetRespondHandleInUIThreadFailedBlock;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		_netRequestIndexForLotteryAnnouncement = NETWORK_REQUEST_ID_OF_IDLE;
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

#pragma mark -
#pragma mark Activity 生命周期

-(void)onCreate:(Intent *)intent{
  PRPLog(@"--> onCreate ");
  
	
}

-(void)onResume {
  PRPLog(@"--> onResume ");
  if (self.lotteryAnnouncementNetRespondBean == nil) {
		if (self.netRequestIndexForLotteryAnnouncement == NETWORK_REQUEST_ID_OF_IDLE) {
			[self requestLotteryAnnouncement];
		}
	}
	
}

-(void)onPause {
  PRPLog(@"--> onPause ");
  
  if (_reloading) {
    [super doneLoadingTableViewData];
  }
  
  [SVProgressHUD dismiss];
  
  [[DomainBeanNetworkEngineSingleton sharedInstance] cancelNetRequestByRequestIndex:self.netRequestIndexForLotteryAnnouncement];
  self.netRequestIndexForLotteryAnnouncement = NETWORK_REQUEST_ID_OF_IDLE;
}

- (void) onActivityResult:(int) requestCode
               resultCode:(int) resultCode
                     data:(Intent *) data {
  PRPLog(@"--> onActivityResult");
  
	
}

#pragma mark -
#pragma mark 实现 ListActivity 向下滑动事件的响应方法

// This is the core method you should implement
- (void)reloadTableViewDataSource {
	_reloading = YES;
  
  do {
    
		
  } while (NO);
  
  // 20130223 tangzhihua : 不能在这里直接调用 doneLoadingTableViewData, 否则关不掉当前界面
  // Here you would make an HTTP request or something like that
  // Call [self doneLoadingTableViewData] when you are done
  [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

#pragma mark -
#pragma mark 实现 UITableViewDataSource 接口

- (NSInteger) numberOfSectionsInTableView:(UITableView *) tableView {
  return 1;
}

- (NSInteger) tableView:(UITableView *) tableView
  numberOfRowsInSection:(NSInteger) section {
  
  return flickrPhotos.count;
}

- (UITableViewCell *)tableView:(UITableView *) tableView
         cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	
	static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
  }
  
  // Configure the cell...
  cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
  cell.detailTextLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
  
  NSString *imageUrl = [flickrPhotos objectAtIndex:indexPath.row];
  cell.imageView.frame = CGRectMake(0, 0, 50, 50);
  [cell.imageView setImageFromURL:[NSURL URLWithString:imageUrl]
                 placeHolderImage:[UIImage imageNamed:@"Icon-Small-50"] animation:YES];
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}


#pragma mark -
#pragma mark 实现 UITableViewDelegate 接口



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  do {
    if (indexPath.row < 0 || indexPath.row >= self.cellArrayOfLotteryList.count) {
			// 异常
			RNAssert(NO, @"tableView:didSelectRowAtIndexPath: 入参 indexPath.row 超出数据源范围");
			break;
		}
    
    
    return;
  } while (NO);
  
}

// 这个方法是返回每个 item 的高度, 这里不能调用 [tableView numberOfRowsInSection:] 会引起死循环
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return 64;
}



#pragma mark -

-(void)requestLotteryAnnouncement {
	LotteryAnnouncementNetRequestBean *netRequestBean = [[LotteryAnnouncementNetRequestBean alloc] init];
	[[DomainBeanNetworkEngineSingleton sharedInstance]
	 requestDomainProtocolWithRequestDomainBean:netRequestBean
	 requestEvent:11
	 successedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, id respondDomainBean) {
		 
	 }
	 failedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, NetRequestErrorBean *error) {
		 
	 }];
}
@end
