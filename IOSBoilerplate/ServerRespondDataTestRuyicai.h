//
//  ServerRespondDataTestRuyicaiNew.h
//  ruyicai
//
//  Created by tangzhihua on 13-6-9.
//
//

#import <Foundation/Foundation.h>
#import "IServerRespondDataTest.h"

@class NetRequestErrorBean;
@interface ServerRespondDataTestRuyicai : NSObject <IServerRespondDataTest>
#pragma mark 实现 IServerRespondDataTest 接口
- (NetRequestErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String;
@end
