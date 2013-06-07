//
//  LotteryAnnouncementNetRespondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface LotteryAnnouncementNetRespondBean : JSONModel
@property (nonatomic, readonly, strong) NSString *noticeTime;
@property (nonatomic, readonly, strong) NSMutableDictionary *lotteryAnnouncementMap;
 
@end
