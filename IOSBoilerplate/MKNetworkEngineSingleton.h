//
//  MKNetworkEngineSingleton.h
//  ruyicai
//
//  Created by 熊猫 on 13-6-17.
//
//

#import "MKNetworkEngine.h"

@interface MKNetworkEngineSingleton : MKNetworkEngine
+ (MKNetworkEngineSingleton *) sharedInstance;
@end
