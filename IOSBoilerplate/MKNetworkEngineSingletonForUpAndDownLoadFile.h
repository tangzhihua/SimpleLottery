//
//  MKNetworkEngineSingleton.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-17.
//
//

#import "MKNetworkEngine.h"

@interface MKNetworkEngineSingletonForUpAndDownLoadFile : NSObject
+ (MKNetworkEngine *) sharedInstance;
@end
