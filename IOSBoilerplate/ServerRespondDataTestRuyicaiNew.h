//
//  ServerRespondDataTestRuyicaiNew.h
//  ruyicai
//
//  Created by tangzhihua on 13-6-9.
//
//

#import <Foundation/Foundation.h>
#import "IServerRespondDataTestNew.h"

@class NetRequestErrorBean;
@interface ServerRespondDataTestRuyicaiNew : NSObject <IServerRespondDataTestNew>
#pragma mark 实现 IServerRespondDataTest 接口
- (NetRequestErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String;
@end
