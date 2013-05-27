//
//  NSObject+DeepCopyingSupport.h
//  airizu
//
//  Created by 唐志华 on 13-3-2.
//
//

#import <Foundation/Foundation.h>
// 给符合 NSCoding 协议的每个对象添加了对深复制的支持, 记住如果想使用当前类别, 必须实现 NSCoding, 否则会引发一个异常

/*
 取之于 Cocoa设计模式 第12章 复制
 这里使用类别模式以及归档和解档模式来提供 深复制. 没有使用正式的 NSDeepCopying 协议.
 */
@interface NSObject (DeepCopyingSupport)

- (id) deepCopy;
@end
