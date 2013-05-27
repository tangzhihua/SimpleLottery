//
//  ServerRespondDataTestAirizu.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "IServerRespondDataTest.h"

@interface ServerRespondDataTestAirizu : NSObject <IServerRespondDataTest> {
  
}

#pragma mark 实现 IServerRespondDataTest 接口
- (NetErrorBean *) testServerRespondDataError:(NSString *) netUnpackedData;
@end
