//
//  INetRespondDataToNSDictionary.h
//  ruyicai
//
//  Created by tangzhihua on 13-6-25.
//
//

#import <Foundation/Foundation.h>

// 将网络响应数据转成 NSDictionary 数据
@protocol INetRespondDataToNSDictionary <NSObject>
- (NSDictionary *) netRespondDataToNSDictionary:(in NSString *)serverRespondDataOfUTF8String;
@end
