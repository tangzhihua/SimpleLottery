//
//  ServerRespondDataTestRuyicai.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import <Foundation/Foundation.h>
#import "IServerRespondDataTest.h"

@interface ServerRespondDataTestRuyicai : NSObject <IServerRespondDataTest> {
  
}

#pragma mark 实现 IServerRespondDataTest 接口
- (NetErrorBean *) testServerRespondDataError:(NSString *) netUnpackedData;
@end