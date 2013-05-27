//
//  NetRequestEvent.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

@protocol IDomainNetRespondCallback;

// NetRequestEvent 类, 是用于 DomainProtocolNetHelperSingleton 和 DomainBeanNetThread 两层之间通信的载体,
// 控制层 创建 DatabaseProtocol 目录下的具体一个业务接口的 "网络请求业务Bean", 如 RoomSearchNetRequestBean,
// 然后调用 DomainProtocolNetHelperSingleton 的 requestDomainProtocol 方法发起一个网络请求,
// 在这个方法内, 会根据传入 "网络请求业务Bean" 和 "其他参数", 来创建一个 NetRequestEvent 对象, 然后将这个对象
// 发送给 DomainBeanNetThread (网络访问线程).
@interface NetRequestEvent : NSObject {
  
}

// 当前业务网络请求事件对应的 下载线程的线程ID
@property (nonatomic, readonly) NSInteger threadID;
// 将 "网络请求业务Bean" 的 getClassName() 作为和这个业务Bean对应的抽象工厂产品的唯一识别Key
@property (nonatomic, readonly, strong) NSString *abstractFactoryMappingKey;
// 控制层 对此次网络请求的标识
@property (nonatomic, readonly) NSUInteger requestEventEnum;
// 控制层 的代理对象
@property (nonatomic, readonly, strong) id<IDomainNetRespondCallback> netRespondDelegate;
// Http请求参数集合
@property (nonatomic, readonly, strong) NSDictionary *httpRequestParameterMap;

#pragma mark -
#pragma mark 方便构造
+(id)netRequestEventWithThreadID:(NSInteger)threadID
       abstractFactoryMappingKey:(NSString *)abstractFactoryMappingKey
                requestEventEnum:(NSUInteger)requestEventEnum
              netRespondDelegate:(id<IDomainNetRespondCallback>)netRespondDelegate
         httpRequestParameterMap:(NSDictionary *)httpRequestParameterMap;
@end