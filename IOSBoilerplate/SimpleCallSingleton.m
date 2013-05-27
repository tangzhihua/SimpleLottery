//
//  SimpleCallSingleton.m
//  airizu
//
//  Created by 唐志华 on 12-12-25.
//
//

#import "SimpleCallSingleton.h"
#import "MacroConstantForString.h"

static const NSString *const TAG = @"<SimpleCallSingleton>";




@interface SimpleCallSingleton()
@property (nonatomic, copy) NSString *phoneNumber;
@end

@implementation SimpleCallSingleton


#pragma mark -
#pragma mark 单例方法群
static SimpleCallSingleton *singletonInstance = nil;

- (void) initialize {
  
}

+ (SimpleCallSingleton *) sharedInstance
{
  if (singletonInstance == nil)
  {
    singletonInstance = [[super allocWithZone:NULL] init];
    
    // initialize the first view controller
    // and keep it with the singleton
    [singletonInstance initialize];
  }
  
  return singletonInstance;
}

/*
+ (id) allocWithZone:(NSZone *)zone
{
  return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*)zone
{
  return self;
}

- (id) retain
{
  return self;
}

- (NSUInteger) retainCount
{
  return NSUIntegerMax;
}

- (oneway void) release
{
  // do nothing
}

- (id) autorelease
{
  return self;
}
*/
#pragma mark - 
#pragma mark
- (void) callCustomerServicePhoneAndShowInThisView:(UIView *) view {
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"直接拨打房间预定电话"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:kCustomerServicePhoneNumber
                                                  otherButtonTitles:nil, nil];
	actionSheet.delegate = self;
	[actionSheet showInView:view];
	 
}

// 拨打指定电话
- (void) callWithPhoneNumber:(NSString *)phoneNumber {
  NSURL *phoneNSURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
  if ([[UIApplication sharedApplication] canOpenURL:phoneNSURL]) {
    
    [[UIApplication sharedApplication] openURL:phoneNSURL];
    
  } else {
    
    UIAlertView *noPhoneFunctionAlert = [[UIAlertView alloc] initWithTitle:nil
                                                                   message:@"设备没有电话功能"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"确定"
                                                         otherButtonTitles:nil];
    [noPhoneFunctionAlert show];
     
  }
}

#pragma mark - 
#pragma mark 实现 UIActionSheetDelegate 接口 (这里只为拨打客服电话服务)
- (void) actionSheet:(UIActionSheet *) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex {
  
	if (buttonIndex == 0) {
    
    [self callWithPhoneNumber:kCustomerServicePhoneNumber];
    
  }
}

@end
