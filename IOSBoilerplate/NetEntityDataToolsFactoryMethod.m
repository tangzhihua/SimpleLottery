//
//  NetEntityDataToolsFactoryMethod.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "NetEntityDataToolsFactoryMethod.h"

// 爱日租项目
#import "NetRequestEntityDataPackageForAirizu.h"
#import "NetRespondEntityDataUnpackAirizu.h"
#import "ServerRespondDataTestAirizu.h"

// 如意彩项目
#import "NetRequestEntityDataPackageForRuyicai.h"
#import "NetRespondEntityDataUnpackForRuyicai.h"
#import "ServerRespondDataTestForRuyicai.h"
#import "NetRespondDataToNSDictionaryForRuyicai.h"

@interface NetEntityDataToolsFactoryMethod()

@end

@implementation NetEntityDataToolsFactoryMethod

#pragma mark
#pragma mark 实现 INetEntityDataTools 接口的方法
- (id<INetRequestEntityDataPackage>) getNetRequestEntityDataPackageStrategyAlgorithm {
  return [[NetRequestEntityDataPackageForRuyicai alloc] init];
}
- (id<INetRespondRawEntityDataUnpack>) getNetRespondEntityDataUnpackStrategyAlgorithm {
  return [[NetRespondEntityDataUnpackForRuyicai alloc] init];
}
- (id<IServerRespondDataTest>) getServerRespondDataTestStrategyAlgorithm {
  return [[ServerRespondDataTestForRuyicai alloc] init];
}
- (id<INetRespondDataToNSDictionary>) getNetRespondDataToNSDictionaryStrategyAlgorithm {
  return [[NetRespondDataToNSDictionaryForRuyicai alloc] init];
}
@end
