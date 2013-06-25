//
//  INetRequestEntityDataPackage.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>

/**
 * 将业务数据字典集合, 打包成传递到服务器的实体数据, (可以在这里完成数据的加密工作)
 * @author zhihua.tang
 *
 */
@protocol INetRequestEntityDataPackage <NSObject>
- (NSData *) packageNetRequestEntityDataWithDomainDataDictionary:(in NSDictionary *)domainDD;
@end


