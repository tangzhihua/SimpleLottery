//
//  NSDictionary+SafeValue.h
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import <Foundation/Foundation.h>

/// iOS开发, 一定要保证当前对象类型的准确性, 否则调用当前对方类型的方法时, 会crash, 
/// 所以一定要采用 Bean的方式分隔开后台传递的数据类型和前端的代码, 也就是前端一定相信 Bean中的数据类型的准确性.

// 这里设计的含义是: 确认从字典中获取到的对象是用户期望的数据类型, 否则返回 nil,
// nil 类型是安全的, 但是如果将一个 NSNumber 类型对象 强转成一个 NSArray对象,
// 此时发送任何 NSArray 所特有的消息时, 就会 crash
@interface NSDictionary (SafeValue) {
  
}

// 如果目标key不存在时, 会返回nil, 这种设计是必须的, 如果不想返回nil, 可以使用 withDefaultValue 版本
- (id) safeStringObjectForKey:(id) key;
- (id) safeNumberObjectForKey:(id) key;
- (id) safeArrayObjectForKey:(id) key;
- (id) safeDictionaryObjectForKey:(id) key;

// 带有默认值的情况是, 如果字典中的目标对象无效时(无效指 : 目标key对应的对象不存在, 或者目标对象的数据类型不正确), 会返回默认值给用户
// 警告 : 如果不想设置默认值, 就传入 nil, 不要传入非法的数据类型对象
// 备注 : 如果返回默认值给用户, 会创建默认值的一份拷贝对象返给用户, 所以不用担心内存问题
// 注意 : 这里的 NSArray 和 NSDictionary 都是浅拷贝
- (id) safeStringObjectForKey:(id) key withDefaultValue:(NSString *) defaultValue;
- (id) safeNumberObjectForKey:(id) key withDefaultValue:(NSNumber *) defaultValue;
- (id) safeArrayObjectForKey:(id) key withDefaultValue:(NSArray *) defaultValue;
- (id) safeDictionaryObjectForKey:(id) key withDefaultValue:(NSDictionary *) defaultValue;
@end
