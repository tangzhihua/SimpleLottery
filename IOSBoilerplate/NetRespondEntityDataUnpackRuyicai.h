//
//  NetRespondEntityDataUnpackRuyicai.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//


#import <Foundation/Foundation.h>
#import "INetRespondRawEntityDataUnpack.h"

@interface NetRespondEntityDataUnpackRuyicai : NSObject<INetRespondRawEntityDataUnpack> {
  
}

#pragma mark 实现 INetRespondRawEntityDataUnpack 接口
- (NSString *) unpackNetRespondRawEntityData:(in NSData *) rawData;
@end