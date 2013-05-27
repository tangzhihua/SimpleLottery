//
//  CommandForEnableAFNetwork.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForSettingAFNetwork.h"


@implementation CommandForSettingAFNetwork
/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
	// 让sharedManager可以自动的显示出网络活动指示器（ network activity indicator）
  [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

+(id)commandForSettingAFNetwork {
  return [[CommandForSettingAFNetwork alloc] init];
}
@end
