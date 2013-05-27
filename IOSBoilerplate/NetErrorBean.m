//
//  NetErrorBean.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "NetErrorBean.h"
 
@implementation NetErrorBean

-(NSString *)errorMessage{
  if (_errorMessage == nil) {
    self.errorMessage = @"";
  }
  return _errorMessage;
}

- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init [0x%x]", [self hash]);
    
    _errorType = NET_ERROR_TYPE_SUCCESS;
    _errorCode = 200;
    _errorMessage = @"OK";
	}
	
	return self;
}

- (NSString *)description {
  return descriptionForDebug(self);
}

#pragma mark -
#pragma mark 方便构造
+(id)netErrorBean {
  return [[NetErrorBean alloc] init];
}

#pragma mark -
#pragma mark 实现 NSCopying 接口
- (id)copyWithZone:(NSZone *)zone {
  NetErrorBean *copy = [[[self class] allocWithZone:zone] init];
  copy.errorType = _errorType;
  copy.errorCode = _errorCode;
  copy.errorMessage = _errorMessage;
  
  return copy;
}
@end
