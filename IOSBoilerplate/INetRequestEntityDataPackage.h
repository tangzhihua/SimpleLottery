//
//  INetRequestEntityDataPackage.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

/**
 * 将数据字典集合, 打包成网络请求字符串, (可以在这里完成数据的加密工作)
 * @author zhihua.tang
 *
 */
@protocol INetRequestEntityDataPackage <NSObject>
- (NSData *) packageNetRequestEntityData:(NSDictionary *) domainDD;
@end


