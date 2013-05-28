//
//  GlobalDataCache.m
//  gameqa
//
//  Created by user on 12-9-13.
//
//

#import "GlobalDataCacheForMemorySingleton.h"
#import "Util.h"
#import "LocalCacheDataPathConstant.h"

@implementation GlobalDataCacheForMemorySingleton



#pragma mark -
#pragma mark 单例方法群

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  NSAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
  }
  
  return self;
}

+ (GlobalDataCacheForMemorySingleton *) sharedInstance {
  static GlobalDataCacheForMemorySingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

/*
 
// 这种方法要在 singletonInstance 中添加一个 @synchronized 已达到线程安全的目的, 但是这种做法在每次调用
// singletonInstance 时, 都会导致性能显著下降.
 
 
static GlobalDataCacheForMemorySingleton *singletonInstance = nil;

- (void) initialize {
  
}
+ (GlobalDataCacheForMemorySingleton *) sharedInstance {
	@synchronized(self) {
		if (singletonInstance == nil) {
			singletonInstance = [[super allocWithZone:NULL] init];
			
			// initialize the first view controller
			// and keep it with the singleton
			[singletonInstance initialize];
		}
		
		return singletonInstance;
	}
}
*/





/*
 // 20130528 : 这里是苹果公司提到了一个单例模式的实现, 它覆盖了主要的内存管理方法.
 // 按照苹果的示例, 多次调用 [[Singleton alloc] init] 返回相同对象, 这非常不恰当, 也几乎没有必要这么做.
 // 苹果在这段代码的说明里是这样解释的, 它只在类只有一个实例的情况下有用, 但这种情况非常少见.
 // 大多数情况下, 它只方便访问类的一个实例. 许多类, 例如 NSNotificationCenter当存在多个实例时可以完美工作.
 // 遗憾的是, 很多开发者没有仔细阅读说明, 而是滥用这个示例.
 
 
 + (id) allocWithZone:(NSZone *)zone {
 return [[self sharedInstance] retain];
 }
 
 - (id) copyWithZone:(NSZone*)zone {
 return self;
 }
 
 - (id) retain {
 return self;
 }
 
 - (NSUInteger) retainCount {
 return NSUIntegerMax;
 }
 
 - (oneway void) release {
 // do nothing
 }
 
 - (id) autorelease {
 return self;
 }
 */

#pragma mark -
#pragma mark
-(NSUInteger)localCacheSize{
  
  NSUInteger size = 0;
  NSArray *directories = [LocalCacheDataPathConstant directoriesCanBeClearByTheUser];
  for(NSString *directory in directories) {
    size += [Util folderSizeAtPath3:directory];
  }
  
  return size;
  
}
@end
