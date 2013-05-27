//
//  DomainBeanNetRequestErrorMessageHandle.m
//  airizu
//
//  Created by 唐志华 on 13-1-9.
//
//

#import "DomainBeanNetRequestErrorBeanHandle.h"
#import "NetErrorBean.h"
#import "NetErrorTypeEnum.h"

static const NSString *const TAG = @"<DomainBeanNetRequestErrorBeanHandle>";

@implementation DomainBeanNetRequestErrorBeanHandle

+ (void) handleNetRequestErrorBean:(NetErrorBean *)netErrorBean {
  if (![netErrorBean isKindOfClass:[NetErrorBean class]]) {
    return;
  }
  
  NSString *errorMessage = nil;
  switch (netErrorBean.errorType)
  {
			// 网络访问成功
    case NET_ERROR_TYPE_SUCCESS: {
      errorMessage = @"访问成功";
    }break;
			
			// 客户端 网络访问错误
    case NET_ERROR_TYPE_CLIENT_NET_ERROR: {
      switch (netErrorBean.errorCode)
      {
        case 404:
          
					break;
					
        default:
					break;
      }
      errorMessage = netErrorBean.errorMessage;
    }break;
			
			// 服务器端 网络访问错误
    case NET_ERROR_TYPE_SERVER_NET_ERROR: {
      switch (netErrorBean.errorCode)
      {
        case 1000:
          // errorMessage = "操作失败";
					break;
        case 2000:
          // errorMessage = "处理异常";
					break;
        case 3000:
          // errorMessage = "无结果返回";
					break;
        case 4000:
          // errorMessage = "需要登录";
					break;
					
        default:
					break;
      }
      
      errorMessage = netErrorBean.errorMessage;
    }break;
			
			// 客户端发生了异常
    case NET_ERROR_TYPE_CLIENT_EXCEPTION: {
      errorMessage = @"客户端发生了异常";
    }break;
			
			// 网络未连接
    case NET_ERROR_TYPE_NET_UNAVAILABLE: {
      errorMessage = @"当前网络不可用";
    }break;
      
    default: {
      
    }break;
  }
  
  netErrorBean.errorMessage = errorMessage;
}
@end
