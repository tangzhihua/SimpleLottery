//
//  NSData+ZIP.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import <Foundation/Foundation.h>

@interface NSData (ZIP)
+ (NSData *)uncompressZippedData:(NSData*)compressedData;
@end
