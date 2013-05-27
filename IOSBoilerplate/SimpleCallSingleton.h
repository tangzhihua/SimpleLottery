//
//  SimpleCallSingleton.h
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import <Foundation/Foundation.h>

@interface SimpleCallSingleton : NSObject <UIActionSheetDelegate> {
  
}

+ (SimpleCallSingleton *) sharedInstance;

// 拨打客服电话
- (void) callCustomerServicePhoneAndShowInThisView:(UIView *) view;
// 拨打指定电话
- (void) callWithPhoneNumber:(NSString *)phoneNumber;
@end
