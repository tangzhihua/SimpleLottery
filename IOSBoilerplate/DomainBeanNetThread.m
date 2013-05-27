//
//  DomainBeanNetThread.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "DomainBeanNetThread.h"
#import "INetThreadToNetHelperCallback.h"
#import "NetRequestEvent.h"
#import "NetRespondEvent.h"
#import "NetErrorBean.h"
#import "NetErrorTypeEnum.h"
#import "HttpNetworkEngineParameterEnum.h"
#import "IHttpNetworkEngine.h"
#import "HttpNetworkEngineFactoryMethodSingleton.h"
#import "NetConnectionManageTools.h"
#import "DomainBeanNetRequestErrorBeanHandle.h"

static const NSString *const TAG = @"<DomainBeanNetThread>";

static const NSString *const kThreadIsInterrupted = @"kThreadIsInterrupted";

@interface DomainBeanNetThread()

// 这两个对象一定要在使用完及时 release, 否则会形成 retain cycle
// 20130207 : requestEvent 是在 DomainProtocolNetHelperSingleton类中被创建并且强引用的,
//            而 DomainProtocolNetHelperSingleton 是当前类的 父对象(就是说, DomainProtocolNetHelperSingleton
//            创建了 当前类对象, 并且强引用之).
//            所以这里对 requestEvent 和 networkCallback(就是DomainProtocolNetHelperSingleton对象),
//            都要使用弱引用, 否则会形成 "循环引用", 之前这里就导致了 "死屏" 的一个严重bug.

// 注意 : 再向一个弱引用的对象发送消息时, 一定要小心, 如果在一个对象被回收后向其发送消息, 程序会崩溃.

// 目前的设计已经避免了这种问题:
// DomainProtocolNetHelperSingleton 会创建 NetRequestEvent 和 DomainBeanNetThread, 然后强引用之,
// 然后 DomainBeanNetThread 对 NetRequestEvent 和 DomainProtocolNetHelperSingleton 是一种弱引用关系,
// 当 DomainBeanNetThread 调用 netThreadToNetHelperCallbackWithNetRespondEvent 回调方法返回
// DomainProtocolNetHelperSingleton后, DomainProtocolNetHelperSingleton会释放它创建的
// NetRequestEvent 和 DomainBeanNetThread, 然后程序返回到当前类的 main 方法继续执行, 之后的执行代码,
// 就不能再使用和 NetRequestEvent 有关的数据了, 目前也是这么设计的.
@property (nonatomic, weak) NetRequestEvent *requestEvent;
@property (nonatomic, weak) id networkCallback;
@end

@implementation DomainBeanNetThread



- (id)initWithNetRequestEvent:(NetRequestEvent *) requestEvent
              networkCallback:(id) networkCallback {
  
  if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
    _requestEvent = requestEvent;
    _networkCallback = networkCallback;
  }
  
  return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)domainBeanNetThreadWithNetRequestEvent:(NetRequestEvent *)requestEvent
                            networkCallback:(id)networkCallback {
  return [[DomainBeanNetThread alloc] initWithNetRequestEvent:requestEvent networkCallback:networkCallback];
}

#pragma mark
#pragma mark 不能使用默认的init方法初始化对象, 而必须使用当前类特定的 "初始化方法" 初始化所有参数
- (id)init
{
  NSAssert(NO, @"Can not use the default init method!");
  
  return nil;
}

- (void)main NS_AVAILABLE(10_5, 2_0) {	// thread body method
  
  @autoreleasepool {
    NSInteger threadID = [_requestEvent threadID];
		
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@"%@%i%@", @"<<<<<<<<<<     http request thread begin (" ,threadID , @")     >>>>>>>>>>");
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@" ");
		
		NSData *netRespondRawEntityData = nil;
		NetErrorBean *netErrorBean = [NetErrorBean netErrorBean];
		
		
		do {
			
			
			
			// 1) 判断当前网络是否可用
			// ----------------------------------------------------------------------------
			if ([self isInterrupted]) {
				break;
			}
			NetConnectionManageTools *netConnectionTest = [NetConnectionManageTools netConnectionManageTools];
			if (![netConnectionTest isNetAvailable]) {
				PRPLog(@"当前网络不可用(可能是当前没有网络, 或者用户在飞行模式.)");
				[netErrorBean setErrorType:NET_ERROR_TYPE_NET_UNAVAILABLE];
				break;
			}
			// ----------------------------------------------------------------------------
			
			
			
			// 2) 调用系统的网络引擎, 发起一个网络请求(系统的网络引擎, 可以是 HttpConnection 或者 HttpClient
			// ----------------------------------------------------------------------------
			if ([self isInterrupted]) {
				break;
			}
			
			// 调用系统的网络引擎(比如 HttpClient/HttpURLConnection), 发起网络请求
			// note : 获取网络响应输入流(网络响应输入流是可能没有的, 此时服务器只是给客户端一个响应, 而不给任何数据,
			// 所以要以netError.getErrorType()作为此次网络访问的判断条件, 而 netRespondRawEntityData 是可能为null的)
			
			id httpNetworkEngine = [[HttpNetworkEngineFactoryMethodSingleton sharedInstance] getHttpNetworkEngine];
			if (![httpNetworkEngine conformsToProtocol:@protocol(IHttpNetworkEngine)]) {
				PRPLog(@"-> 必须要实现 IHttpNetworkEngine 接口!");
				break;
			}
			netRespondRawEntityData
			= [httpNetworkEngine requestNetByHttpWithHttpRequestParameter:[_requestEvent httpRequestParameterMap] outputNetErrorBean:netErrorBean];
			if ([netErrorBean errorType] != NET_ERROR_TYPE_SUCCESS) {
				PRPLog(@"-> 调用具体的网络引擎发起网络请求执行失败(具体的网络引擎可能是HttpClient/HttpURLConnection).!");
				break;
			}
			// ----------------------------------------------------------------------------
			
			
			
		} while (false);
		
		if ([self isInterrupted]) {
			// 外部取消了当前线程
			PRPLog(@"-> 本次网络请求, 被取消");
			[netErrorBean setErrorType:NET_ERROR_TYPE_THREAD_IS_CANCELED];
		}
		
		// 根据错误类型, 错误代码, 获取对应的详细错误信息(因为错误信息可能分为 debug 版本和 release 版本.
		[DomainBeanNetRequestErrorBeanHandle handleNetRequestErrorBean:netErrorBean];
		
		PRPLog(@"-> 本次网络请求结果->%@", [netErrorBean description]);
		
		NetRespondEvent *respondEvent
		= [NetRespondEvent netRespondEventWithThreadID:threadID
													 netRespondRawEntityData:netRespondRawEntityData
																					netError:netErrorBean];
		
		// 这里之前会直接切换回UI线程(主线程), 但是发现现在切回去, 还有很多初始化UI的工作要做,
		// 所以这里不切回UI线程, 让Activity来自己通过Handler切换回UI线程
		// 注意 : 一定调用 当前方法后, 就不能在进行其他代码处理了, 最好就是 执行 [pool drain],
		//       因为调用此方法后, NetRequestEvent 和 DomainBeanNetThread 的强引用就会全部终止.
		[_networkCallback netThreadToNetHelperCallbackWithNetRespondEvent:respondEvent andThread:self];
		
		// 这两个对象一定要在使用完及时 release, 否则会形成 retain cycle
		//[_requestEvent release], _requestEvent = nil;
		//[_networkCallback release], _networkCallback = nil;
		_requestEvent = nil;
		_networkCallback = nil;
		
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@"%@%i%@", @"<<<<<<<<<<     http request thread end (" , threadID, @")     >>>>>>>>>>");
		PRPLog(@" ");
		PRPLog(@" ");
		PRPLog(@" ");
	}
}

- (BOOL) isInterrupted {
  NSString *interruptString = [[self threadDictionary] objectForKey:kThreadIsInterrupted];
  if ([interruptString isEqualToString:(NSString *)kThreadIsInterrupted]) {
    return YES;
  } else {
    return NO;
  }
}

- (void) interrupt {
  [[self threadDictionary] setObject:kThreadIsInterrupted forKey:kThreadIsInterrupted];
}
@end
