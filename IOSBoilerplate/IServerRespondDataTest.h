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
 * 检测从服务器端返回的数据是否有效(这里是当服务器正常返回了数据后, 我们要检测返回的数据中是否有之前约定好的错误码存在, 来确认本次数据是否是真正有效的.)
 * @author zhihua.tang
 *
 */
@protocol IServerRespondDataTest <NSObject>
- (NetErrorBean *) testServerRespondDataIsValid:(NSString *)serverRespondDataOfUTF8String;
@end
