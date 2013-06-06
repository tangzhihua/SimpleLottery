//
//  NetRequestEntityDataPackageForAirizu.h
//  airizu
//
//  Created by 唐志华 on 12-12-18.
//
//

#import <Foundation/Foundation.h>
#import "INetRequestEntityDataPackage.h"

@interface NetRequestEntityDataPackageForAirizu : NSObject <INetRequestEntityDataPackage> {
  
}

#pragma mark INetRequestEntityDataPackage 接口方法
- (NSData *) packageNetRequestEntityDataWithDomainDataDictionary:(NSDictionary *) domainDD;
@end
