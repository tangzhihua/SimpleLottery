//
//  CustomControlDelegate.h
//  airizu
//
//  Created by 唐志华 on 13-1-22.
//
//

#import <Foundation/Foundation.h>

// 函数式编程, 这是一个能够让代码变得更易读的强大范式, 而且也可以让你写更少的代码.
// 函数式编程将是继面向对象编程之后又一大编程范式的变革.
// 苹果通常比竞争对手更快地抛弃过时技术.
// 类似地,可能几年后现有方法会有基于块的变体,但新增类将只接受基于块的参数,最终开发者只能用块.
// 像这种编程范式的变化确实挺困难,但越早适应越好.
typedef void(^CustomControlCallbackBlock)(id control, NSUInteger action);



// 过去的方式, 已经废弃, 现在要使用上面的 "块", 使用函数编程范式
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
