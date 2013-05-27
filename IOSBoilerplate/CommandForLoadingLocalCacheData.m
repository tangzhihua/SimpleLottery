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



static CommandForLoadingLocalCacheData *singletonInstance = nil;










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
  
  if (!_isExecuted) {
    _isExecuted = YES;
		
    // 创建本地缓存目录
    [LocalCacheDataPathConstant createLocalCacheDirectories];
    
    // 启动 "加载本地缓存的数据" 子线程, 这里加载的缓存数据是次要的, 如 "城市列表" "字典"
    [NSThread detachNewThreadSelector:@selector(childThreadForLoadingLocalCacheData) toTarget:self withObject:nil];
    
    /********            这里加载最重要的信息, 不加载完, 是不能进入App的.           ************/
		
		// 读取App配置文件
    [GlobalDataCacheForNeedSaveToFileSystem readAppConfigInfoToGlobalDataCacheForMemorySingleton];
		
  }
  
}

+(id)commandForLoadingLocalCacheData {
  if (nil == singletonInstance) {
    singletonInstance = [[CommandForLoadingLocalCacheData alloc] init];
    singletonInstance.isExecuted = NO;
    singletonInstance.netRequestIndexForDictionary = IDLE_NETWORK_REQUEST_ID;
  }
  return singletonInstance;
}

#pragma mark -
#pragma mark 子线程 ------> "加载那些次要的本地缓存数据"
- (void) childThreadForLoadingLocalCacheData {
  
	@autoreleasepool {
    
	}
}

#pragma mark -
#pragma mark 实现 IDomainNetRespondCallback 接口



//
- (void) clearNetRequestIndexByRequestEvent:(NSUInteger) requestEvent {
  if (kNetRequestTagEnum_Dictionary == requestEvent) {
    _netRequestIndexForDictionary = IDLE_NETWORK_REQUEST_ID;
  }
}

/**
 * 此方法处于非UI线程中
 *
 * @param requestEvent
 * @param errorBean
 * @param respondDomainBean
 */
- (void) domainNetRespondHandleInNonUIThread:(in NSUInteger) requestEvent
														 netRequestIndex:(in NSInteger) netRequestIndex
                                   errorBean:(in NetErrorBean *) errorBean
                           respondDomainBean:(in id) respondDomainBean {
  
  PRPLog(@" -> domainNetRespondHandleInNonUIThread --- start ! ");
  [self clearNetRequestIndexByRequestEvent:requestEvent];
  
  if (errorBean.errorType != NET_ERROR_TYPE_SUCCESS) {
    return;
  }
  
  if (requestEvent == kNetRequestTagEnum_Dictionary) {
    
    PRPLog(@"自动登录成功!");
    
    
  }
  
}

@end
