//
//  NetRespondEvent.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

@class NetErrorBean;
@interface NetRespondEvent : NSObject {
  
}

@property (nonatomic, readonly) NSInteger threadID;
@property (nonatomic, readonly, strong) NSData *netRespondRawEntityData;
@property (nonatomic, readonly, strong) NetErrorBean *netError;

#pragma mark -
#pragma mark 方便构造
+(id)netRespondEventWithThreadID:(NSInteger)threadID
         netRespondRawEntityData:(NSData *)netRespondRawEntityData
                        netError:(NetErrorBean *)netError;

@end
