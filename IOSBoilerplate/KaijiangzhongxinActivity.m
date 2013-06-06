//
//  KaijiangzhongxinActivity.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-19.
//
//

#import "KaijiangzhongxinActivity.h"

#import "CustomControlDelegate.h"

#import "LotteryAnnouncement.h"
#import "LotteryAnnouncementNetRequestBean.h"
#import "LotteryAnnouncementNetRespondBean.h"

#import "DomainProtocolNetHelperOfMKNetworkKitSingleton.h"

@interface KaijiangzhongxinActivity () <UITableViewDelegate, UITableViewDataSource, IDomainNetRespondCallback, CustomControlDelegate, UIAlertViewDelegate>

// 彩票列表 cell 缓存列表, 提前初始化好, 提高效率
@property (nonatomic, strong) NSMutableArray *cellArrayOfLotteryList;

// 开奖公告
@property (nonatomic, strong) LotteryAnnouncementNetRespondBean *lotteryAnnouncementNetRespondBean;
@property (nonatomic, assign) NSInteger netRequestIndexForLotteryAnnouncement;
@end

@implementation KaijiangzhongxinActivity

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		_netRequestIndexForLotteryAnnouncement = IDLE_NETWORK_REQUEST_ID;
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
		if (self.netRequestIndexForLotteryAnnouncement == IDLE_NETWORK_REQUEST_ID) {
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
  
  [[DomainProtocolNetHelperSingleton sharedInstance] cancelAllNetRequestWithThisNetRespondDelegate:self];
  self.netRequestIndexForLotteryAnnouncement = IDLE_NETWORK_REQUEST_ID;
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
  
  return self.cellArrayOfLotteryList.count;
}

- (UITableViewCell *)tableView:(UITableView *) tableView
         cellForRowAtIndexPath:(NSIndexPath *) indexPath {
	
	return [self.cellArrayOfLotteryList objectAtIndex:indexPath.row];
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
  
  return 10;
}



#pragma mark -

-(void)requestLotteryAnnouncement {
	LotteryAnnouncementNetRequestBean *netRequestBean = [[LotteryAnnouncementNetRequestBean alloc] init];
	[[DomainProtocolNetHelperOfMKNetworkKitSingleton sharedInstance] requestDomainProtocolWithContext:self requestDomainBean:netRequestBean requestEvent:11 extraHttpRequestParameterMap:nil successedBlock:NULL failedBlock:NULL];
}
@end
