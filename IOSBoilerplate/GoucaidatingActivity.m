//
//  GoucaidatingActivity.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-19.
//
//

#import "GoucaidatingActivity.h"

#import "LotteryListTableCell.h"
#import "LotteryDictionary.h"
#import "CurrentLotteryIssueCountDownManager.h"
#import "CurrentIssueCountDown.h"
#import "CurrentIssueCountDownDatabaseFieldsConstant.h"


#import "LotterySalesStatusNetRequestBean.h"
#import "LotterySalesStatusNetRespondBean.h"
#import "LotterySalesStatus.h"

#import "ShuangSeQiuBettingActivity.h"

#import "CustomControlDelegate.h"

@interface GoucaidatingActivity () <UITableViewDelegate, UITableViewDataSource, CustomControlDelegate, UIAlertViewDelegate>

// 彩票列表 - cell 对应的 nib
@property (nonatomic, strong) UINib *lotteryListTableCellNib;


// 彩票列表 cell 缓存列表, 提前初始化好, 提高效率
@property (nonatomic, strong) NSMutableArray *cellArrayOfLotteryList;

// 彩票销售状态信息
@property (nonatomic, strong) LotterySalesStatusNetRespondBean *lotterySalesStatusNetRespondBean;
@property (nonatomic, assign) NSInteger netRequestIndexForLotterySalesStatus;
@end






@implementation GoucaidatingActivity

@synthesize lotteryListTableCellNib;
-(UINib *)lotteryListTableCellNib {
  if (lotteryListTableCellNib == nil) {
    self.lotteryListTableCellNib = [LotteryListTableCell nib];
  }
  return lotteryListTableCellNib;
}

typedef NS_ENUM(NSInteger, NetRequestTagEnum) {
  // 2.2.83	购买大厅(实际应该是 获取彩票销售状态信息)
  kNetRequestTagEnum_LotterySalesStatus = 0
};


#pragma mark -
#pragma mark 生命周期
-(void)dealloc{
  
  [self removeAllObserversOfCurrentIssueCountDown];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		self.netRequestIndexForLotterySalesStatus = NETWORK_REQUEST_ID_OF_IDLE;
		
		// 初始化 彩票列表所有的cell
		[self initCellArrayOfLotteryList];
    
    // 注册 "KVO"
    [self addAllObserversOfCurrentIssueCountDown];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	
	//[self.table setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	
	[super viewDidUnload];
}


#pragma mark -
#pragma mark Activity 生命周期

-(void)onCreate:(Intent *)intent{
  PRPLog(@"--> onCreate ");
  
	
}

-(void)onResume {
  PRPLog(@"--> onResume ");
  if (self.lotterySalesStatusNetRespondBean == nil) {
		if (self.netRequestIndexForLotterySalesStatus == NETWORK_REQUEST_ID_OF_IDLE) {
			[self requestLotterySalesStatus];
		}
	}
	
}

-(void)onPause {
  PRPLog(@"--> onPause ");
  
  if (_reloading) {
    [super doneLoadingTableViewData];
  }
  
  [SVProgressHUD dismiss];
  
	[[DomainBeanNetworkEngineSingleton sharedInstance] cancelNetRequestByRequestIndex:self.netRequestIndexForLotterySalesStatus];
	
  self.netRequestIndexForLotterySalesStatus = NETWORK_REQUEST_ID_OF_IDLE;
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
    
		// 重置彩票排期观察者
    [[CurrentLotteryIssueCountDownManager sharedInstance] resetObserver];
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSUInteger fromRow = sourceIndexPath.row;
	NSUInteger toRow = destinationIndexPath.row;
	
	while (fromRow < toRow) {
		[self.cellArrayOfLotteryList exchangeObjectAtIndex:fromRow withObjectAtIndex:fromRow + 1];
		
		fromRow++;
	}
	
	while (fromRow > toRow) {
		[self.cellArrayOfLotteryList exchangeObjectAtIndex:fromRow withObjectAtIndex:fromRow -1];
		
		fromRow--;
	}
}

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSLog(@"执行删除操作");
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
    
    LotteryListTableCell *cell = self.cellArrayOfLotteryList[indexPath.row];
		NSString *lotteryKey = cell.lotteryKey;
		PRPLog(@"当前选中的彩票的 key = %@", lotteryKey);
		if ([NSString isEmpty:lotteryKey]) {
			// 异常
			RNAssert(NO, @"LotteryListTableCell 中的 lotteryKey 不能为空");
			break;
		}
		
		Class lotteryActivityClass = [[GlobalDataCacheForDataDictionarySingleton sharedInstance].lotteryActivityClassDictionaryUseLotteryKeyQuery objectForKey:cell.lotteryKey];
		if (nil == lotteryActivityClass) {
			// 异常
			//NSAssert(NO, @"未找到目标彩票的Activity Class");
			break;
		}
		
		Intent *intent = [Intent intentWithSpecificComponentClass:lotteryActivityClass];
		[self startActivity:intent];
    return;
  } while (NO);
  
}

// 这个方法是返回每个 item 的高度, 这里不能调用 [tableView numberOfRowsInSection:] 会引起死循环
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  return [LotteryListTableCell viewFrameRectFromNib].size.height;
}


#pragma mark -
#pragma mark 私有方法


-(void)addAllObserversOfCurrentIssueCountDown {
  for (LotteryListTableCell *cell in self.cellArrayOfLotteryList) {
    CurrentIssueCountDown *currentIssueCountDown = [[CurrentLotteryIssueCountDownManager sharedInstance].currentIssueCountDownBeanList objectForKey:cell.lotteryKey];
    if (currentIssueCountDown != nil) {
      [currentIssueCountDown addObserver:cell
                              forKeyPath:k_CurrentIssueCountDown_countDownSecond
                                 options:NSKeyValueObservingOptionNew
                                 context:(__bridge void *)cell];
			[currentIssueCountDown addObserver:cell
                              forKeyPath:k_CurrentIssueCountDown_isNetworkDisconnected
                                 options:NSKeyValueObservingOptionNew
                                 context:(__bridge void *)cell];
			[currentIssueCountDown addObserver:cell
                              forKeyPath:k_CurrentIssueCountDown_netRequestIndex
                                 options:NSKeyValueObservingOptionNew
                                 context:(__bridge void *)cell];
			[currentIssueCountDown addObserver:cell
                              forKeyPath:k_CurrentIssueCountDown_countDownSecondOfRerequestNetwork
                                 options:NSKeyValueObservingOptionNew
                                 context:(__bridge void *)cell];
      
    }
  }
}

-(void)removeAllObserversOfCurrentIssueCountDown {
  for (LotteryListTableCell *cell in self.cellArrayOfLotteryList) {
    CurrentIssueCountDown *currentIssueCountDown = [[CurrentLotteryIssueCountDownManager sharedInstance].currentIssueCountDownBeanList objectForKey:cell.lotteryKey];
    if (currentIssueCountDown != nil) {
			
      [currentIssueCountDown removeObserver:cell forKeyPath:k_CurrentIssueCountDown_countDownSecond];
      [currentIssueCountDown removeObserver:cell forKeyPath:k_CurrentIssueCountDown_isNetworkDisconnected];
      [currentIssueCountDown removeObserver:cell forKeyPath:k_CurrentIssueCountDown_netRequestIndex];
      [currentIssueCountDown removeObserver:cell forKeyPath:k_CurrentIssueCountDown_countDownSecondOfRerequestNetwork];
      
    }
  }
}


// 初始化全部的 彩票列表 cell
-(void)initCellArrayOfLotteryList {
	RNAssert(self.cellArrayOfLotteryList == nil, @"不能重复初始化cellArrayOfLotteryList");
	
	self.cellArrayOfLotteryList = [NSMutableArray arrayWithCapacity:[GlobalDataCacheForMemorySingleton sharedInstance].lotteryDictionaryList.count];
	
	// 彩票字典列表
	NSArray *lotteryDictionaryList = [GlobalDataCacheForMemorySingleton sharedInstance].lotteryDictionaryList;
	for (LotteryDictionary *lotteryDictionary in lotteryDictionaryList) {
    LotteryListTableCell *cell = [LotteryListTableCell cellFromNib:self.lotteryListTableCellNib];
		
		[cell bind:lotteryDictionary];
		
    //
    [self.cellArrayOfLotteryList addObject:cell];
	}
	
}

// 更新 彩票销售状态 icon
-(void)updateLotterySalesStatusIconForLotteryTable{
	if (self.lotterySalesStatusNetRespondBean == nil) {
		return;
	}
	
	for (LotteryListTableCell *cell in self.cellArrayOfLotteryList) {
    LotterySalesStatus *lotterySalesStatus = [self.lotterySalesStatusNetRespondBean.lotterySaleInformationMap objectForKey:cell.lotteryCode];
		if (lotterySalesStatus != nil) {
			cell.lotteryOpenPrizeStatusEnum = lotterySalesStatus.lotteryOpenPrizeStatusEnum;
		}
	}
}

#pragma mark -
#pragma mark 网络访问方法群
- (NSInteger) requestLotterySalesStatus {
  //
  LotterySalesStatusNetRequestBean *netRequestBean = [[LotterySalesStatusNetRequestBean alloc] init];
  NSInteger netRequestIndex
  = [[DomainBeanNetworkEngineSingleton sharedInstance] requestDomainProtocolWithRequestDomainBean:netRequestBean requestEvent:kNetRequestTagEnum_LotterySalesStatus successedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, id respondDomainBean) {
		[self clearNetRequestIndexByRequestEvent:requestEvent];
		
		if (requestEvent == kNetRequestTagEnum_LotterySalesStatus) {// 彩票销售状态
			LotterySalesStatusNetRespondBean *lotterySalesStatusNetRespondBean = respondDomainBean;
			
			PRPLog(@"%@", lotterySalesStatusNetRespondBean);
			
			// 刷新 推荐城市 TableView
			Message *msg = [Message obtain];
			msg.what = kHandlerMsgTypeEnum_GetLotterySalesStatusSuccessful;
			[msg.data setObject:lotterySalesStatusNetRespondBean
									 forKey:[NSNumber numberWithUnsignedInteger:kHandlerExtraDataTypeEnum_LotterySalesStatusNetRespondBean]];
			[self handleMessage:msg];
		}
		
	} failedBlock:^(NSUInteger requestEvent, NSInteger netRequestIndex, NetRequestErrorBean *error) {
		[self clearNetRequestIndexByRequestEvent:requestEvent];
		
		Message *msg = [Message obtain];
    msg.what = kHandlerMsgTypeEnum_ShowNetErrorMessage;
    [msg.data setObject:error.message
                 forKey:[NSNumber numberWithUnsignedInteger:kHandlerExtraDataTypeEnum_NetErrorMessage]];
    [msg.data setObject:[NSNumber numberWithUnsignedInteger:requestEvent]
                 forKey:[NSNumber numberWithUnsignedInteger:kHandlerExtraDataTypeEnum_NetRequestTag]];
		[self handleMessage:msg];
    
	}];
  
  return netRequestIndex;
}

typedef enum {
  //
  kHandlerMsgTypeEnum_ShowNetErrorMessage = 0,
  // 获取 彩票销售信息成功
  kHandlerMsgTypeEnum_GetLotterySalesStatusSuccessful
} HandlerMsgTypeEnum;

typedef enum {
  //
  kHandlerExtraDataTypeEnum_NetRequestTag = 0,
  //
  kHandlerExtraDataTypeEnum_NetErrorMessage,
  //
  kHandlerExtraDataTypeEnum_LotterySalesStatusNetRespondBean
} HandlerExtraDataTypeEnum;

- (void) handleMessage:(Message *) msg {
  
  // 关闭 EGORefreshTableHeader
  if (_reloading) {
    [super doneLoadingTableViewData];
  }
  
  switch (msg.what) {
    case kHandlerMsgTypeEnum_ShowNetErrorMessage:{
      
      NSString *netErrorMessageString = [msg.data objectForKey:[NSNumber numberWithUnsignedInteger:kHandlerExtraDataTypeEnum_NetErrorMessage]];
      
      [SVProgressHUD showErrorWithStatus:netErrorMessageString];
      
    }break;
      
    case kHandlerMsgTypeEnum_GetLotterySalesStatusSuccessful:{
      LotterySalesStatusNetRespondBean *lotterySalesStatusNetRespondBean
      = [msg.data objectForKey:[NSNumber numberWithUnsignedInteger:kHandlerExtraDataTypeEnum_LotterySalesStatusNetRespondBean]];
      
      //
      self.lotterySalesStatusNetRespondBean = lotterySalesStatusNetRespondBean;
      
      //
      [self updateLotterySalesStatusIconForLotteryTable];
      
      [SVProgressHUD dismiss];
    }break;
      
    default:
      break;
  }
}

- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_LotterySalesStatus == requestEvent) {
    _netRequestIndexForLotterySalesStatus = NETWORK_REQUEST_ID_OF_IDLE;
  }
}

@end
