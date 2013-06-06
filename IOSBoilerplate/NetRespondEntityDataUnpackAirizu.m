//
//  NetRespondEntityDataUnpackAirizu.m
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import "NetRespondEntityDataUnpackAirizu.h"

static const NSString *const TAG = @"<NetRespondEntityDataUnpackAirizu>";

@implementation NetRespondEntityDataUnpackAirizu
- (id) init {
	
	if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
	}
	
	return self;
}

- (void) dealloc {
	PRPLog(@"dealloc: %@ [0x%x]", TAG, [self hash]);
	
 
}

#pragma mark 实现 INetRespondRawEntityDataUnpack 接口
- (NSString *) unpackNetRespondRawEntityDataToUTF8String:(in NSData *) rawData {
  if (rawData == nil) {
    // 入参异常
    return nil;
  }
  
  return [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
}
@end
