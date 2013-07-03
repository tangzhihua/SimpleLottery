//
//  CommandForLoadingLocalCacheData.m
//  airizu
//
//  Created by 唐志华 on 13-3-22.
//
//

#import "CommandForLoadingLocalCacheData.h"

#import "GlobalDataCacheForMemorySingleton.h"
#import "GlobalDataCacheForNeedSaveToFileSystem.h"

#import "LocalCacheDataPathConstant.h"


 






@interface CommandForLoadingLocalCacheData ()
// 这个命令只能执行一次
@property (nonatomic, assign) BOOL isExecuted;
// 数据字典 网络请求
@property (nonatomic, assign) NSInteger netRequestIndexForDictionary;
@end










@implementation CommandForLoadingLocalCacheData

//
typedef NS_ENUM(NSInteger, NetRequestTagEnum) {
  // 2.8 初始化字典
  kNetRequestTagEnum_Dictionary
};


/**
 
 * 执行命令对应的操作
 
 */
-(void)execute {
  
  if (!self.isExecuted) {
    self.isExecuted = YES;
		
    // 创建本地缓存目录
    [LocalCacheDataPathConstant createLocalCacheDirectories];
    
    // 启动 "加载本地缓存的数据" 子线程, 这里加载的缓存数据是次要的, 如 "城市列表" "字典"
    //__weak id weakSelf = self;
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      // 这里异步加载次要的数据, 不阻塞主线程
    });
    
    
    
    
    /********            这里加载最重要的信息, 不加载完, 是不能进入App的.           ************/
		
		// 读取App配置文件
    [GlobalDataCacheForNeedSaveToFileSystem readAppConfigInfoToGlobalDataCacheForMemorySingleton];
		// 读取彩票字典数据
    [GlobalDataCacheForNeedSaveToFileSystem readLotteryDictionaryInfoToGlobalDataCacheForMemorySingleton];
  }
  
}

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
    _isExecuted = NO;
		_netRequestIndexForDictionary = NETWORK_REQUEST_ID_OF_IDLE;
  }
  
  return self;
}

+(id)commandForLoadingLocalCacheData {
	
  static CommandForLoadingLocalCacheData *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark 子线程 ------> "加载那些次要的本地缓存数据"


#pragma mark -
#pragma mark 实现 IDomainNetRespondCallback 接口



//
- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_Dictionary == requestEvent) {
    _netRequestIndexForDictionary = NETWORK_REQUEST_ID_OF_IDLE;
  }
}

 

@end
