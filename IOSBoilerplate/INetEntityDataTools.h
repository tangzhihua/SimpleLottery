//
//  INetEntityDataTools.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

/**
 * 网络访问过程中, 请求和返回的 "实体数据" 相关的工具类
 * @author zhihua.tang
 *
 */
@protocol INetRequestEntityDataPackage;
@protocol INetRespondRawEntityDataUnpack;
@protocol IServerRespondDataTest;
@protocol IServerRespondDataTestNew;

@protocol INetEntityDataTools <NSObject>
- (id<INetRequestEntityDataPackage>) getNetRequestEntityDataPackage;
- (id<INetRespondRawEntityDataUnpack>) getNetRespondEntityDataUnpack;
- (id<IServerRespondDataTest>) getServerRespondDataTest;
- (id<IServerRespondDataTestNew>) getServerRespondDataTestNew;
@end

