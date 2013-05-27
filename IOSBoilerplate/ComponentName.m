//
//  ComponentName.m
//  airizu
//
//  Created by 唐志华 on 13-1-9.
//
//

#import "ComponentName.h"

static const NSString *const TAG = @"<ComponentName>";

@implementation ComponentName

- (id) initWithClassName:(NSString *) className {
  
  if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
    _className = [className copy];
  }
  
  return self;
}

- (NSString *)description {
  return descriptionForDebug(self);
}

#pragma mark -
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id) init {
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

#pragma mark -
#pragma mark 方便构造
+(id)componentNameWithClass:(Class) cls {
  NSString *className = NSStringFromClass(cls);
  return [[ComponentName alloc] initWithClassName:className];
}

+(id)componentNameWithClassName:(NSString *) className {
  return [[ComponentName alloc] initWithClassName:className];
}
@end
