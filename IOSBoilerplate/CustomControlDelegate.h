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

// 对于自定义控件的开发, V 和 C 之间的通信可以通过 CustomControlCallbackBlock 来完成.
// 这个块拥有两个参数
// control : 控件本身的对象
// action  : 触发了自定义控件的哪个 "UI事件"
// 至于该 "UI事件" 对应的一些信息数据(比如单选列表被点击后, 被点击的cell索引号),
// 可以在自定义控件中编写一个方法来提供(如 lastSelectedCellIndex),
// 在 C 层的回调块中 使用 [control lastSelectedCellIndex] 方式获取.

// 如上设计只是想统一 自定义控件V 和 C 层通信的规则而已,
// 也可以在 自定义控件中 自定义其特有的CallbackBlock,
// 没有一定的好, 也没有一定的坏, 收发随心好了.








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
