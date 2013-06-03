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
// 使用 Grand Central Dispatch (GCD) 来实现单例, 这样编写方便, 速度快, 而且线程安全.
-(id)init {
  // 禁止调用 -init 或 +new
  RNAssert(NO, @"Cannot create instance of Singleton");
  
  // 在这里, 你可以返回nil 或 [self initSingleton], 由你来决定是返回 nil还是返回 [self initSingleton]
  return nil;
}

// 真正的(私有)init方法
-(id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化代码
  }
  
  return self;
}

+ (SimpleCallSingleton *) sharedInstance {
  static SimpleCallSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}



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
