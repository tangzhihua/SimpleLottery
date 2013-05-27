//
//  AloneParseNetRespondStringToDomainBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-21.
//
//

#import <Foundation/Foundation.h>
#import "IParseNetRespondStringToDomainBean.h"

@interface IssueQueryParseNetRespondStringToDomainBean : NSObject <IParseNetRespondStringToDomainBean> {
  
}

#pragma mark 实现 IParseNetRespondStringToDomainBean 接口
- (id) parseNetRespondStringToDomainBean:(in NSString *) netRespondString;
@end
