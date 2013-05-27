//
//  Message.m
//  airizu
//
//  Created by 唐志华 on 12-12-26.
//
//

#import "Message.h"

static const NSString *const TAG = @"<Message>";

@implementation Message

- (id)init {
  if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
    _what = -1;
    _data = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

+ (Message *) obtain {
  return [[Message alloc] init];
}
@end
