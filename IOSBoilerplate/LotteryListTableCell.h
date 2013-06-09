//
//  LotteryListTableCell.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-3.
//
//

#import "PRPNibBasedTableViewCell.h"
#import "MacroConstantForThisProject.h"
#import "ICurrentIssueCountDownEventReceiver.h"

@class LotteryDictionary;
@interface LotteryListTableCell : PRPNibBasedTableViewCell <ICurrentIssueCountDownEventReceiver>{
	
}

// 彩票 icon
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
// 彩票 名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 彩票 广告
@property (weak, nonatomic) IBOutlet UILabel *adLabel;
// 本期彩票截止时间
@property (weak, nonatomic) IBOutlet UILabel *countdownForCurrentIssueToEnd;
// 彩票 销售状态
@property (weak, nonatomic) IBOutlet UIImageView *lotterySaleStatusImageView;

// 当前彩票销售状态(在设置这个枚举时, 会同时更新 lotterySaleStatusImageView
@property (assign, nonatomic) LotteryOpenPrizeStatusEnum lotteryOpenPrizeStatusEnum;



// 彩票代码 (这个是为了查询数据源方便而设置, 这个不是给程序员识别的)
@property (nonatomic, copy) NSString *lotteryCode;
// 彩票 key (key是给程序员识别的彩票关键字, 例如 : 时时彩 的 key 是 shishicai
@property (nonatomic, copy) NSString *lotteryKey;



// "数据绑定 (data binding)"
// 数据绑定最好的办法是将你的数据模型对象传递到自定义的表视图单元并让其绑定数据.
-(void) bind:(LotteryDictionary *)lotteryDictionaryToBeDisplayed;
@end
