//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 iOS5之后，原来获取iPhone的DeviceId的接口：[UIDevice uniqueIdentifier] 被废弃！
 这个改动会影响非常多的人，尤其是数据分析者。由于iPhone取IMEI困难（属于私有方法），所以大多数应用将DeviceId，也就是uniqueIdentifier作为IMEI来使用。如果这个接口被废弃，那么，我们就需要寻求一个新的方式来标识唯一的设备。
 官方推荐的方法是，每个应用内创建一个UUID来作为唯一标志，并将之存储，但是这个解决方法明显不能接受！原因是，你每次创建的UUID都是不一样的，意味着，你卸载后重新安装这个软件，生成的UUID就不一样了，无法达到我们将之作为数据分析的唯一标识符的要求。
 现有的解决方案是，使用iPhone的Mac地址，因为Mac地址也是唯一的。unix有系统调用可以获取Mac地址。但是有些事情需要注意：
 1.iPhone可能有多个Mac地址，wifi的地址，以及SIM卡的地址。一般来讲，我们取en0的地址，因为他是iPhone的wifi的地址，是肯定存在的。（例外情况依然有：市面上依然存在一部分联通的阉割版无wifi的iPhone）
 2.Mac地址涉及到隐私，不应该胡乱将用户的Mac地址传播！所以我们需要将Mac地址进行hash之后，才能作为DeviceId上传。
 
 网上已经有现成的解决方案：
 https://github.com/gekitz/UIDevice-with-UniqueIdentifier-for-iOS-5
 */
@interface UIDevice (IdentifierAddition)

/*
 * 唯一设备标识符
 * 
 * @method uniqueDeviceIdentifier
 * @description use this method when you need a unique identifier in one app.
 * It generates a hash from the MAC-address in combination with the bundle identifier
 * of your app.
 */

- (NSString *) uniqueDeviceIdentifier;

/*
 * 唯一的全球设备标识符
 *
 * @method uniqueGlobalDeviceIdentifier
 * @description use this method when you need a unique global identifier to track a device
 * with multiple apps. as example a advertising network will use this method to track the device
 * from different apps.
 * It generates a hash from the MAC-address only.
 */

- (NSString *) uniqueGlobalDeviceIdentifier;

@end
