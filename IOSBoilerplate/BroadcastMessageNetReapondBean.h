//
//  BroadcastMessageNetReapondBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>

@interface BroadcastMessageNetReapondBean : NSObject

// 消息ID 客户端保存的id与返回的id比较，如果不同则弹出广播消息
@property (nonatomic, readonly, strong) NSNumber *ID;
// 消息标题
@property (nonatomic, readonly, strong) NSString *title;
// 消息内容
@property (nonatomic, readonly, strong) NSString *message;

#pragma mark -
#pragma mark 方便构造
+(id)broadcastMessageNetReapondBeanWithID:(NSNumber *)ID title:(NSString *)title message:(NSString *)message;

@end
