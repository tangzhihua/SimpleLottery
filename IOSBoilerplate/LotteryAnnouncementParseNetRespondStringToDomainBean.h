//
//  LotteryAnnouncementParseNetRespondStringToDomainBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-6.
//
//

#import <Foundation/Foundation.h>

#import "IParseNetRespondStringToDomainBean.h"

@interface LotteryAnnouncementParseNetRespondStringToDomainBean : NSObject <IParseNetRespondStringToDomainBean> {
  
}

#pragma mark 实现 IParseNetRespondStringToDomainBean 接口
- (id) parseNetRespondStringToDomainBean:(in NSString *) netRespondString;
@end