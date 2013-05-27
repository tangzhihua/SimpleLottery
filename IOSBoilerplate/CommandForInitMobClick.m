//
//  CommandForInitMobClick.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForInitMobClick.h"
#import "MobClick.h"

@implementation CommandForInitMobClick
/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  [MobClick startWithAppkey:@"510f598c527015239500000c" reportPolicy:BATCH channelId:kCoopid];
}

+(id)commandForInitMobClick {
  return [[CommandForInitMobClick alloc] init];
}
@end
