//
//  GlobalConstant.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//
//  需要全局缓存的 数据字典常量
//
//

#import <Foundation/Foundation.h>

@interface GlobalDataCacheForDataDictionarySingleton : NSObject {
  
}

+ (GlobalDataCacheForDataDictionarySingleton *) sharedInstance;

// 所有网络接口都要使用到的 公有参数
@property (nonatomic, readonly) NSDictionary *publicNetRequestParameters;


// 彩票key对应的彩票Activity class
@property (nonatomic, readonly) NSDictionary *lotteryActivityClassDictionaryUseLotteryKeyQuery;
@end
