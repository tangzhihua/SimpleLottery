//
//  HttpNetworkEngineForNSURLConnection.m
//  airizu
//
//  Created by 唐志华 on 12-12-20.
//
//

#import "HttpNetworkEngineForNSURLConnection.h"

#import "HttpNetworkEngineParameterEnum.h"
#import "NetErrorBean.h"
 

static const NSString *const TAG = @"<HttpNetworkEngineForNSURLConnection>";

@interface HttpNetworkEngineForNSURLConnection ()
@property (nonatomic) long long expectedContentLength;
@property (nonatomic) BOOL finished;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NetErrorBean *netErrorBean;
@end

@implementation HttpNetworkEngineForNSURLConnection

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
    _expectedContentLength = 0;
    _finished = NO;
    _receivedData = [[NSMutableData alloc] init];
    _netErrorBean = [[NetErrorBean alloc] init];
	}
	
	return self;
}

#pragma mark -
#pragma mark 方便构造
+(id)httpNetworkEngineForNSURLConnection {
  return [[HttpNetworkEngineForNSURLConnection alloc] init];
}

#pragma mark 实现 IHttpNetworkEngine 接口
- (NSData *) requestNetByHttpWithHttpRequestParameter:(in NSDictionary *) httpRequestParameterMap
                                   outputNetErrorBean:(out NetErrorBean *) netErrorForOUT {
  
  PRPLog(@"--> 启动 HttpNetworkEngine (NSURLConnection) 开始网络数据请求. ");
  
  do {
    if (![httpRequestParameterMap isKindOfClass:[NSDictionary class]] || ![netErrorForOUT isKindOfClass:[NetErrorBean class]]) {
      PRPLog(@"--> 方法入参异常 ! httpRequestHeadMap/netErrorForOUT 类型不正确 !  ");
      [_netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
      [_netErrorBean setErrorMessage:@"入参非法!"];
			break;
    }
    if ([httpRequestParameterMap count] <= 0) {
      PRPLog(@"--> 方法入参异常 ! httpRequestHeadMap的内容不能为空 !  ");
      [_netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
      [_netErrorBean setErrorMessage:@"入参非法!"];
			break;
		}
		
    // URL
		NSString *urlString = [httpRequestParameterMap objectForKey:kHttpNetworkEngineParameterEnum_URL];
    // RequestMethod
		NSString *requestMethodString = [httpRequestParameterMap objectForKey:kHttpNetworkEngineParameterEnum_REQUEST_METHOD];
    // EntityData
		NSData *entityDataString =[httpRequestParameterMap objectForKey:kHttpNetworkEngineParameterEnum_ENTITY_DATA];
    //NSString *readTimeoutString = [httpRequestParameterMap objectForKey:kHttpNetworkEngineParameterEnum_READ_TIMEOUT];
    // Cookie
		NSString *cookieString = [httpRequestParameterMap objectForKey:kHttpNetworkEngineParameterEnum_COOKIE];
    // ContentType
		NSString *contentTypeString = [httpRequestParameterMap objectForKey:kHttpNetworkEngineParameterEnum_CONTENT_TYPE];
		// final String contentEncodingString = httpRequestParameterMap.get(HttpNetworkEngineParameterEnum.CONTENT_ENCODING.name());
		// final String userAgentString = httpRequestParameterMap.get(HttpNetworkEngineParameterEnum.USER_AGENT.name());
		if ([NSString isEmpty:urlString] || [NSString isEmpty:requestMethodString]) {
      PRPLog(@"--> 主要的Http请求参数不能为空(URL/REQUEST_METHOD) ! ");
      [_netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_EXCEPTION];
      [_netErrorBean setErrorMessage:@"主要的Http请求参数不全!"];
			break;
		}
    
    PRPLog(@"--> 1. 开始构建 NSMutableURLRequest ");
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    // 设置网络请求超时时间 (秒)
    [request setTimeoutInterval:10];
    // 设置Cookie
    if (![NSString isEmpty:cookieString]) {
      [request setValue:cookieString forHTTPHeaderField:@"Cookie"];
    }
    
    //
    [request setURL: url];
    
    // 设置请求类型
    if ([requestMethodString isEqualToString:@"GET"]) {
      [request setHTTPMethod:@"GET"];
    } else {
      [request setHTTPMethod:@"POST"];
      
      NSUInteger dataLength = [entityDataString length];
      if (dataLength > 0) {
        [request setValue:[[NSNumber numberWithUnsignedInteger:dataLength] stringValue] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:entityDataString];
      }
    }
    
    //
    [request setValue:contentTypeString forHTTPHeaderField:@"Content-Type"];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    PRPLog(@"--> 2. 开始构建 NSURLConnection ");
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:true];
    if (connection == nil) {
      [_netErrorBean setErrorType:NET_ERROR_TYPE_CLIENT_NET_ERROR];
      [_netErrorBean setErrorMessage:@"客户端连接网络失败!"];
      break;
    }
    
    //
    while(!_finished) {
      [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
  } while (NO);
  
  [netErrorForOUT setErrorCode:_netErrorBean.errorCode];
  [netErrorForOUT setErrorType:_netErrorBean.errorType];
  [netErrorForOUT setErrorMessage:_netErrorBean.errorMessage];
  return _receivedData;
}

#pragma mark -
#pragma mark NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  PRPLog(@"--> 服务器端给予响应 : connection:didReceiveResponse:");
  if (response != nil) {
    PRPLog(@"--> MIMEType=%@", [response MIMEType]);
    PRPLog(@"--> URL=%@", [response URL]);
    
    // 本次网络请求, 输入流实体数据长度
    _expectedContentLength = [response expectedContentLength];
    PRPLog(@"--> expectedContentLength=%lld", [response expectedContentLength]);
    PRPLog(@"--> textEncodingName=%@", [response textEncodingName]);
    PRPLog(@"--> suggestedFilename=%@", [response suggestedFilename]);
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
  PRPLog(@"--> 单次收到有效数据:connection:didReceiveData:数据长度 length=%d", [data length]);
	[_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  PRPLog(@"--> 本次网络请求完成, connectionDidFinishLoading:");
  
  [_netErrorBean setErrorType:NET_ERROR_TYPE_SUCCESS];
	[_netErrorBean setErrorMessage:@"OK"];
  
  // 正常下载完成
	_finished = YES;
}

#pragma mark -
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  PRPLog(@"--> 本次网络请求失败, connection:didFailWithError");
  // 出现错误
  if (error != nil) {
    PRPLog(@"--> domain=%@", [error domain]);
    PRPLog(@"--> code=%d", [error code]);
    PRPLog(@"--> userInfo=%@", [error userInfo]);
    PRPLog(@"--> localizedDescription=%@", [error localizedDescription]);
    PRPLog(@"--> localizedFailureReason=%@", [error localizedFailureReason]);
    PRPLog(@"--> localizedRecoverySuggestion=%@", [error localizedRecoverySuggestion]);
    PRPLog(@"--> helpAnchor=%@", [error helpAnchor]);
  }
  
  [_netErrorBean setErrorType:NET_ERROR_TYPE_SERVER_NET_ERROR];
  [_netErrorBean setErrorMessage:[error localizedDescription]];
  [_netErrorBean setErrorCode:[error code]];
  
	_finished = YES;
}

@end
