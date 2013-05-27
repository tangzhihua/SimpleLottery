//
//  Command.h
//  airizu
//
//  Created by 唐志华 on 13-3-20.
//
//

#import <Foundation/Foundation.h>


/**
 
 * 命令接口，声明执行的操作
 
 */
@protocol Command <NSObject>

/**
 
 * 执行命令对应的操作
 
 */
-(void)execute;
@end
