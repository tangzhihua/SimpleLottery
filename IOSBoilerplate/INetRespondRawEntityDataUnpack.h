//
//  INetRespondRawEntityDataUnpack.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

/**
 * 将网络返回的数据, 解压成可识别的字符串(在这里完成数据的解密)
 * @author zhihua.tang
 *
 */
@protocol INetRespondRawEntityDataUnpack <NSObject>
- (NSString *) unpackNetRespondRawEntityData:(in NSData *) rawData;
@end

