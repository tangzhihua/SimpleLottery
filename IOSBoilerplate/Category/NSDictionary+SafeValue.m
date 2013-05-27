//
//  NSDictionary+SafeValue.m
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import "NSDictionary+SafeValue.h"

@implementation NSDictionary (SafeValue)

- (id) safeStringObjectForKey:(id) key {
  id result = [self objectForKey:key];
  if ([result isKindOfClass:[NSString class]]) {
    return result;
  } else {
    return nil;
  }
}

- (id) safeNumberObjectForKey:(id) key {
  id result = [self objectForKey:key];
  if ([result isKindOfClass:[NSNumber class]]) {
    return result;
  } else {
    return nil;
  }
}

- (id) safeArrayObjectForKey:(id) key {
  id result = [self objectForKey:key];
  if ([result isKindOfClass:[NSArray class]]) {
    return result;
  } else {
    return nil;
  }
}

- (id) safeDictionaryObjectForKey:(id) key {
  id result = [self objectForKey:key];
  if ([result isKindOfClass:[NSDictionary class]]) {
    return result;
  } else {
    return nil;
  }
}

#pragma mark -
#pragma mark 带默认值的方法群
- (id) safeStringObjectForKey:(id) key withDefaultValue:(NSString *) defaultValue {
  id result = [self safeStringObjectForKey:key];
  
  do {
    if (result != nil) {
      break;
    }
    
    // result 等于 nil, 此时需要返回 "默认值" 给用户
    // 但是返回之前要做数据类型检测, 如果用户传入的默认值的数据类型不正确, 就返回nil
    if (![defaultValue isKindOfClass:[NSString class]]) {
      break;
    }
    
    // 必须创建默认值的一个 拷贝对象, 否则可能出现内存问题
    return [NSString stringWithString:defaultValue];
  } while (NO);
  
  return result;
}

- (id) safeNumberObjectForKey:(id) key withDefaultValue:(NSNumber *) defaultValue {
  id result = [self safeNumberObjectForKey:key];
  
  do {
    if (result != nil) {
      break;
    }
    
    // result 等于 nil, 此时需要返回 "默认值" 给用户
    // 但是返回之前要做数据类型检测, 如果用户传入的默认值的数据类型不正确, 就返回nil
    if (![defaultValue isKindOfClass:[NSNumber class]]) {
      break;
    }
    
    // NSNumber 本身是不可修改的, 所以不用做深拷贝
    return [defaultValue copy];
    
  } while (NO);
  
  return result;
}
  
- (id) safeArrayObjectForKey:(id) key withDefaultValue:(NSArray *) defaultValue {
  id result = [self safeArrayObjectForKey:key];
  
  do {
    if (result != nil) {
      break;
    }
    
    // result 等于 nil, 此时需要返回 "默认值" 给用户
    // 但是返回之前要做数据类型检测, 如果用户传入的默认值的数据类型不正确, 就返回nil
    if (![defaultValue isKindOfClass:[NSArray class]]) {
      break;
    }
    
    // 必须创建默认值的一个 拷贝对象, 否则可能出现内存问题
    return [NSMutableArray arrayWithArray:defaultValue];
    
  } while (NO);
  
  return result;
}
  
- (id) safeDictionaryObjectForKey:(id) key withDefaultValue:(NSDictionary *) defaultValue {
  id result = [self safeDictionaryObjectForKey:key];
  
  do {
    if (result != nil) {
      break;
    }
    
    // result 等于 nil, 此时需要返回 "默认值" 给用户
    // 但是返回之前要做数据类型检测, 如果用户传入的默认值的数据类型不正确, 就返回nil
    if (![defaultValue isKindOfClass:[NSDictionary class]]) {
      break;
    }
    
    // 必须创建默认值的一个 拷贝对象, 否则可能出现内存问题
    return [NSMutableDictionary dictionaryWithDictionary:defaultValue];
    
  } while (NO);
  
  return result;
}
@end
