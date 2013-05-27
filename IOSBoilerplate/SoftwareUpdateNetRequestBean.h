//
//  SoftwareUpdateNetRequestBean.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-29.
//
//

#import <Foundation/Foundation.h>

@interface SoftwareUpdateNetRequestBean : NSObject

// 随机数 可选 用于自动登录
@property (nonatomic, readonly, strong) NSString *randomNumber;
// 是否是模拟器 可选 true是模拟器,false不是模拟器
@property (nonatomic, readonly, strong) NSNumber *isEmulator;

#pragma mark -
#pragma mark 方便构造
+(id)softwareUpdateNetRequestBeanWithRandomNumber:(NSString *)randomNumber isEmulator:(NSNumber *)isEmulator;
@end
