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
  RNAssert(NO, @"Cannot create instance of Singleton");
  
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
 
 
 无论是爱还是恨，你都需要单例。实际上每个iOS或Mac OS应用都至少会有UIApplication或NSApplication.
 什么是单例呢？Wikipedia是如此定义的：
 在软件工程中，单例是一种用于实现单例的数学概念，即将类的实例化限制成仅一个对象的设计模式。
 或者我的理解是：
 单例是一种类，该类只能实例化一个对象。
 尽管这是单例的实际定义，但在Foundation框架中不一定是这样。比如NSFileManger和NSNotificationCenter，
 分别通过它们的类方法defaultManager和defaultCenter获取。尽管不是严格意义的单例，
 这些类方法返回一个可以在应用的所有代码中访问到的类的共享实例。在本文中我们也会采用该方法。
 
 使用Objective-C实现单例模式的最佳方式向来有很多争论，开发者（包括Apple在内）似乎每几年就会改变他们的想法。
 当Apple引入了Grand Central Dispatch (GCD)（Mac OS 10.6和iOS4.0），他们也引入了一个很适合用于实现单例模式的函数。
 
 该函数就是dispatch_once：
 void dispatch_once( dispatch_once_t *predicate, dispatch_block_t block);
 
 该函数接收一个dispatch_once用于检查该代码块是否已经被调度的谓词（是一个长整型，实际上作为BOOL使用）。
 它还接收一个希望在应用的生命周期内仅被调度一次的代码块，对于本例就用于shared实例的实例化。
 
 dispatch_once不仅意味着代码仅会被运行一次，而且还是线程安全的，
 这就意味着你不需要使用诸如@synchronized之类的来防止使用多个线程或者队列时不同步的问题。
 
 
 Apple的GCD Documentation证实了这一点:
 如果被多个线程调用，该函数会同步等等直至代码块完成。
 
 实际要如何使用这些呢?
 好吧，假设有一个AccountManager类，你想在整个应用中访问该类的共享实例。你可以按如下代码简单实现一个类方法：
 + (AccountManager *)sharedManager {
 static AccountManager *sharedAccountManagerInstance = nil;
 
 static dispatch_once_t predicate;
 dispatch_once(&predicate, ^{
 sharedAccountManagerInstance = [[self alloc] init];
 });
 
 return sharedAccountManagerInstance;
 
 }
 
 这就意味着你任何时候访问共享实例，需要做的仅是：
 AccountManager *accountManager = [AccountManager sharedManager];
 
 就这些，你现在在应用中就有一个共享的实例，该实例只会被创建一次。
 
 该方法有很多优势:
 1 线程安全
 2 很好满足静态分析器要求
 3 和自动引用计数（ARC）兼容
 4 仅需要少量代码
 
 该方法的劣势就是它仍然运行创建一个非共享的实例：
 AccountManager *accountManager = [[AccountManager alloc] init];
 
 有些时候你希望有这种行为，但如果正在想要的是仅一个实例被实例化就需要注意这点。
 
 */

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
