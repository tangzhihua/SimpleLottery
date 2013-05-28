//
//  GlobalConstant.m
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import "GlobalDataCacheForDataDictionarySingleton.h"
#import "ToolsFunctionForThisProgect.h"
#import "NetConnectionManageTools.h"
#import "UIDevice+IdentifierAddition.h"


//
#import "ShuangSeQiuBettingActivity.h"


 

@implementation GlobalDataCacheForDataDictionarySingleton

- (void) initPublicNetRequestParameters:(NSMutableDictionary *) dictionary {
	UIDevice *device = [UIDevice currentDevice];
	NSString *deviceName = [device model];
	
	/*
	 IMEI(International Mobile Equipment Identity)是国际移动设备身份码的缩写，国际移动装备辨识码，是由15位数字组成的"电子串号"，
	 它与每台手机一一对应，而且该码是全世界唯一的。每一只手机在组装完成后都将被赋予一个全球唯一的一组号码，这个号码从生产到交付使用都将被制造生产的厂商所记录。
	 国际移动设备识别码（IMEI：International Mobile Equipment Identification Number）是区别移动设备的标志，储存在移动设备中，可用于监控被窃或无效的移动设备。
	 IMEI俗称“串号”，存储在手机的EEPROM（俗称“码片”）里，熟悉并了解这个号码对我们今后识别手机会起到非常大的作用。
	 */
	NSString *deviceImei = [device uniqueDeviceIdentifier];
	/*
	 国际移动用户识别码（IMSI：International Mobile SubscriberIdentification Number）是区别移动用户的标志，储存在SIM卡中，
	 可用于区别移动用户的有效信息。其总长度不超过15位，同样使用0～9的数字。其中MCC是移动用户所属国家代号，占3位数字，中国的MCC规定为460；
	 MNC是移动网号码，最多由两位数字组成，用于识别移动用户所归属的移动通信网；MSIN是移动用户识别码，用以识别某一移动通信网中的移动用户。
	 */
	NSString *deviceImsi = [device uniqueGlobalDeviceIdentifier];
	
	 
	[dictionary setObject:kPlatform forKey:@"platform"];
	[dictionary setObject:[ToolsFunctionForThisProgect localAppVersion] forKey:@"softwareversion"];
	[dictionary setObject:deviceName forKey:@"machineid"];
	[dictionary setObject:deviceImei forKey:@"imei"];
	[dictionary setObject:deviceImsi forKey:@"imsi"];
	[dictionary setObject:kCoopid forKey:@"coopid"];
	// 是否加密
	[dictionary setObject:@"1" forKey:@"isCompress"];
	// 网卡地址
	[dictionary setObject:[NetConnectionManageTools macAddressString] forKey:@"mac"];
		
}

- (void) initLotteryActivityClassDictionary:(NSMutableDictionary *) dictionary {
	// 双色球
	[dictionary setObject:[ShuangSeQiuBettingActivity class] forKey:kLotteryKey_shuangseqiu];
}

#pragma mark -
#pragma mark 单例方法群

// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  NSAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
    
    //
    _publicNetRequestParameters = [[NSMutableDictionary alloc] init];
    [self initPublicNetRequestParameters:(NSMutableDictionary *)_publicNetRequestParameters];
    
    //
		_lotteryActivityClassDictionaryUseLotteryKeyQuery = [[NSMutableDictionary alloc] init];
		[self initLotteryActivityClassDictionary:(NSMutableDictionary *)_lotteryActivityClassDictionaryUseLotteryKeyQuery];
  }
  
  return self;
}

+ (GlobalDataCacheForDataDictionarySingleton *) sharedInstance {
  static GlobalDataCacheForDataDictionarySingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

@end
