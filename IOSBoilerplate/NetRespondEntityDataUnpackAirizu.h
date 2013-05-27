//
//  NetRespondEntityDataUnpackAirizu.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "INetRespondRawEntityDataUnpack.h"

@interface NetRespondEntityDataUnpackAirizu : NSObject<INetRespondRawEntityDataUnpack> {
  
}

#pragma mark 实现 INetRespondRawEntityDataUnpack 接口
- (NSString *) unpackNetRespondRawEntityData:(in NSData *) rawData;
@end
