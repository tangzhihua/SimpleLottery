//
//  NetRequestEntityDataPackageForRuyicai.h
//  ruyicai
//
//  Created by 熊猫 on 13-4-20.
//
//

#import <Foundation/Foundation.h>
#import "INetRequestEntityDataPackage.h"

@interface NetRequestEntityDataPackageForRuyicai : NSObject <INetRequestEntityDataPackage> {
  
}

#pragma mark INetRequestEntityDataPackage 接口方法
- (NSData *) packageNetRequestEntityData:(NSDictionary *) domainDD;
@end