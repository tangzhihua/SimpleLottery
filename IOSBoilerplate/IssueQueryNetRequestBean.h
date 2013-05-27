//
//  AloneNetRequestBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//

#import <Foundation/Foundation.h>

@interface IssueQueryNetRequestBean : NSObject {
	
}


//彩种编号
@property (nonatomic, readonly, strong) NSString *lotteryCode;

#pragma mark -
#pragma mark 方便构造
+(id)issueQueryNetRequestBeanWithLotteryCode:(NSString *)lotteryCode;

@end
