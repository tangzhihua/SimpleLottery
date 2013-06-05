//
//  BroadcastMessageNetReapondBean.m
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import "BroadcastMessageNetReapondBean.h"
#import "SoftwareUpdateDatabaseFieldsConstant.h"

@interface BroadcastMessageNetReapondBean ()
// 消息ID 客户端保存的id与返回的id比较，如果不同则弹出广播消息
@property (nonatomic, readwrite, strong) NSNumber *messageID;
// 消息标题
@property (nonatomic, readwrite, strong) NSString *title;
// 消息内容
@property (nonatomic, readwrite, strong) NSString *message;
@end



@implementation BroadcastMessageNetReapondBean

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  if([key isEqualToString:k_BroadcastMessage_RespondKey_id]) {
    self.messageID = value;
  } else {
    [super setValue:value forUndefinedKey:key];
  }
}

- (NSString *)description {
  return descriptionForDebug(self);
}

@end
