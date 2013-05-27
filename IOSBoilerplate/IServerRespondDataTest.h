//
//  IServerRespondDataTest.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
@class NetErrorBean;
/**
 * 测试从服务器端返回的数据是否是有效的(数据要先解包, 然后再根据错误码做判断)
 * @author zhihua.tang
 *
 */
@protocol IServerRespondDataTest <NSObject>
- (NetErrorBean *) testServerRespondDataError:(NSString *) netUnpackedData;
@end
