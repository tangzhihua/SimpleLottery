//
//  LotteryCurrentBatchCodeNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>

@interface LotteryCurrentIssueNetRespondBean : NSObject
@property (nonatomic, readonly, strong) NSDictionary *issueDictionary;

+(id)lotteryCurrentIssueNetRespondBeanWithIssueDictionary:(NSDictionary *)issueDictionary;
@end
