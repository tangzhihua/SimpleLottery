//
//  NetErrorBean.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import <Foundation/Foundation.h>
#import "NetErrorTypeEnum.h"

@interface NetErrorBean : NSObject <NSCopying>{
  
}

@property (nonatomic) NetErrorTypeEnum errorType;
@property (nonatomic) NSInteger errorCode;
@property (nonatomic, copy) NSString *errorMessage;

#pragma mark -
#pragma mark 方便构造
+(id)netErrorBean;

#pragma mark -
#pragma mark 实现 NSCopying 接口
- (id)copyWithZone:(NSZone *)zone;

@end
