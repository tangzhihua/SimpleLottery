//
//  LotteryDictionary.h
//  ruyicai
//
//  Created by 熊猫 on 13-5-4.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LotteryDictionary : NSObject {
	
}

@property (nonatomic, readonly, strong) NSString *key;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *code;
@property (nonatomic, readonly, strong) UIImage *icon;
@property (nonatomic, readonly, strong) NSString *ad;
@property (nonatomic, readonly, assign) BOOL enable;

// 彩票 固定信息(比如竞彩足球, 就是会固定显示 "返奖率高达69%")
@property (nonatomic, readonly, strong) NSString *fixedInformation;

#pragma mark -
#pragma mark 方便构造
+(id)lotteryDictionaryWithKey:(NSString *)key
												 name:(NSString *)name
												 code:(NSString *)code
												 icon:(NSString *)icon
													 ad:(NSString *)ad
											 enable:(BOOL)enable
						 fixedInformation:(NSString *)fixedInformation;
@end
