//
//  CustomControlDelegate.h
//  airizu
//
//  Created by 唐志华 on 13-1-22.
//
//

#import <Foundation/Foundation.h>

@protocol CustomControlDelegate <NSObject>

/**
 * 自定义控件事件回调代理
 *
 * @param control : 自定义控件对象
 * @param action  : 动作枚举
 */
@required
-(void)customControl:(id)control onAction:(NSUInteger)action;
@end
