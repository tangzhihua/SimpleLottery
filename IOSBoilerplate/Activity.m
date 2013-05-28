//
//  Activity.m
//  gameqa
//
//  Created by user on 12-9-14.
//
//

#import "Activity.h"
#import "Intent.h"
#import "IntentFilter.h"
#import "LocalActivityManagerSingleton.h"

// 登录界面
//#import "LoginActivity.h"









static const NSString *const TAG = @"<Activity>";








@interface Activity ()

@property (nonatomic, assign) int resultCode;
@property (nonatomic, retain) Intent *resultData;

@end









@implementation Activity

#pragma mark -
#pragma mark 实例方法群
- (id)init {
  if ((self = [super init])) {
		//PRPLog(@"%@: %@", NSStringFromSelector(_cmd), self);
    
    _requestCode = kRequestCode_None;
    _resultCode = kActivityResultCode_RESULT_CANCELED;
    _resultData = nil;
    
  }
  
  return self;
}

+(id)activity {
  return [[Activity alloc] init];
}

+(id)activityFromSubclass:(Class)cls intent:(Intent *)intent {
  Activity *newActivity = [[cls alloc] init];
  if ([newActivity isKindOfClass:[Activity class]]) {
    //
    [newActivity setIntent:intent];
    [newActivity onCreate:intent];
    return newActivity;
  } else {
    NSAssert(NO, @"创建目标 Activity 失败 ! newActivity 为 nil, 或者类型不是 Activity.");
    return nil;
  }
}

#pragma mark -
#pragma mark 实例方法群

/**
 * Launch a new activity.  You will not receive any information about when
 * the activity exits.  This implementation overrides the base version,
 * providing information about
 * the activity performing the launch.  Because of this additional
 * information, the {@link Intent#FLAG_ACTIVITY_NEW_TASK} launch flag is not
 * required; if not specified, the new activity will be added to the
 * task of the caller.
 *
 * <p>This method throws {@link android.content.ActivityNotFoundException}
 * if there was no Activity found to run the given Intent.
 *
 * @param intent The intent to start.
 *
 * @throws android.content.ActivityNotFoundException
 *
 * @see #startActivityForResult
 */
- (void) startActivity:(Intent *) intent {
  
  /*
   startActivity 只是对 startActivityForResult 的封装。其中参数 -1（可为任何负值）
   表示被启动的 target activity finished 的时候，不向调用者反馈任何通知。
   */
  [self startActivityForResult:intent requestCode:kRequestCode_None];
}

/**
 * Launch an activity for which you would like a result when it finished.
 * When this activity exits, your
 * onActivityResult() method will be called with the given requestCode.
 * Using a negative requestCode is the same as calling
 * {@link #startActivity} (the activity is not launched as a sub-activity).
 *
 * <p>Note that this method should only be used with Intent protocols
 * that are defined to return a result.  In other protocols (such as
 * {@link Intent#ACTION_MAIN} or {@link Intent#ACTION_VIEW}), you may
 * not get the result when you expect.  For example, if the activity you
 * are launching uses the singleTask launch mode, it will not run in your
 * task and thus you will immediately receive a cancel result.
 *
 * <p>As a special case, if you call startActivityForResult() with a requestCode
 * >= 0 during the initial onCreate(Bundle savedInstanceState)/onResume() of your
 * activity, then your window will not be displayed until a result is
 * returned back from the started activity.  This is to avoid visible
 * flickering when redirecting to another activity.
 *
 * <p>This method throws {@link android.content.ActivityNotFoundException}
 * if there was no Activity found to run the given Intent.
 *
 * @param intent The intent to start.
 * @param requestCode If >= 0, this code will be returned in
 *                    onActivityResult() when the activity exits.
 *
 * @throws android.content.ActivityNotFoundException
 *
 * @see #startActivity
 */
- (void) startActivityForResult:(Intent *) intent
                    requestCode:(int) requestCode {
  @synchronized(self) {
    [[LocalActivityManagerSingleton sharedInstance] startActivityForResult:intent requestCode:requestCode];
  }
}

/**
 * This is called when a child activity of this one calls its
 * {@link #startActivity} or {@link #startActivityForResult} method.
 *
 * <p>This method throws {@link android.content.ActivityNotFoundException}
 * if there was no Activity found to run the given Intent.
 *
 * @param child The activity making the call.
 * @param intent The intent to start.
 * @param requestCode Reply request code.  < 0 if reply is not requested.
 *
 * @throws android.content.ActivityNotFoundException
 *
 * @see #startActivity
 * @see #startActivityForResult
 */
- (void) startActivityFromChild:(Activity *) child intent:(Intent *) intent requestCode:(int) requestCode {
  
}

/**
 * Call this to set the result that your activity will return to its
 * caller.
 *
 * @param resultCode The result code to propagate back to the originating
 *                   activity, often RESULT_CANCELED or RESULT_OK
 *
 * @see #RESULT_CANCELED
 * @see #RESULT_OK
 * @see #RESULT_FIRST_USER
 * @see #setResult(int, Intent)
 */
- (void) setResult:(int) resultCode {
  @synchronized(self) {
    self.resultCode = resultCode;
    self.resultData = nil;
  }
}

/**
 * Call this to set the result that your activity will return to its
 * caller.
 *
 * @param resultCode The result code to propagate back to the originating
 *                   activity, often RESULT_CANCELED or RESULT_OK
 * @param data The data to propagate back to the originating activity.
 *
 * @see #RESULT_CANCELED
 * @see #RESULT_OK
 * @see #RESULT_FIRST_USER
 * @see #setResult(int)
 */
- (void) setResult:(int) resultCode data:(Intent *) resultData {
  @synchronized(self) {
    self.resultCode = resultCode;
    self.resultData = resultData;
  }
}

/**
 * Call this when your activity is done and should be closed.  The
 * ActivityResult is propagated back to whoever launched you via
 * onActivityResult().
 */
- (void) finish {
  
  @synchronized (self) {
    [[LocalActivityManagerSingleton sharedInstance] finishActivity:self
                                                        resultCode:self.resultCode
                                                        resultData:self.resultData];
  }
}

// 关闭自己, 并且启动一个新的Activity
- (void)finishSelfAndStartNewActivity:(Intent *)intent {
  
  // 这里必须要 retain 一次自身, 因为调用 finish 方法后, 就会直接 调用 dealloc 方法, 从而照成崩溃
	// 20130427 改成ARC后, 这里还未测试是否OK
	// 20130428 这里是不需要显式声明 oneself 为 __strong, 因为默认就是 __strong的
  __strong id oneself = self;
  
  [self finish];
  [self startActivity:intent];
  
  oneself = nil;
}

#pragma mark -
#pragma mark 需要子类进行覆写的方法群
/**
 * Called when an activity you launched exits, giving you the requestCode
 * you started it with, the resultCode it returned, and any additional
 * data from it.  The <var>resultCode</var> will be
 * {@link #RESULT_CANCELED} if the activity explicitly returned that,
 * didn't return any result, or crashed during its operation.
 *
 * <p>You will receive this call immediately before onResume() when your
 * activity is re-starting.
 *
 * @param requestCode The integer request code originally supplied to
 *                    startActivityForResult(), allowing you to identify who this
 *                    result came from.
 * @param resultCode The integer result code returned by the child activity
 *                   through its setResult().
 * @param data An Intent, which can return result data to the caller
 *               (various data can be attached to Intent "extras").
 *
 * @see #startActivityForResult
 * @see #createPendingResult
 * @see #setResult(int)
 */
- (void) onActivityResult:(int) requestCode
               resultCode:(int) resultCode
                     data:(Intent *) data {
  // 需要子类必须覆写
}

-(void)sendBroadcast:(Intent *)intent {
  
  if (intent == nil || [NSString isEmpty:intent.action]) {
    // 入参非法
    return;
  }
  
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
  [userInfo setObject:intent forKey:NSStringFromClass([Intent class])];
  NSNotification *userBroadcast = [NSNotification notificationWithName:intent.action object:self userInfo:userInfo];
  [[NSNotificationCenter defaultCenter] postNotification:userBroadcast];
}

-(void)onReceive:(Intent *)intent {
  
}

-(void)onReceiveForBroadcast:(NSNotification *)notification {
  Intent *intent = [[notification userInfo] objectForKey:NSStringFromClass([Intent class])];
  if (![intent isKindOfClass:[Intent class]] || [NSString isEmpty:intent.action]) {
    // 入参非法
    return;
  }
  
  [self onReceive:intent];
}

// 注册要接收的广播消息(可以接收多条)
-(void)registerReceiver:(IntentFilter *)intentFilter {
  if (intentFilter == nil || [intentFilter.actions count] <= 0) {
    // 入参非法
    return;
  }
  
  for (NSString *action in intentFilter.actions) {
    if (![action isKindOfClass:[NSString class]]) {
      // 广播消息非法
      continue;
    }
    
    // 向通知中心注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onReceiveForBroadcast:)
                                                 name:action
                                               object:nil];
  }
}
// 注销广播消息接收器(不再接收任何广播消息)
-(void)unregisterReceiver {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 注销广播消息接收器(不再接收任何广播消息)
-(void)unregisterReceiverWithActionName:(NSString *)actionName {
  if (![actionName isKindOfClass:[NSString class]] && [NSString isEmpty:actionName]) {
    // 入参错误
    return;
  }
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:actionName object:nil];
}

#pragma mark -
#pragma mark Activity 生命周期
-(void)onCreate:(Intent *)intent{
  
}
//-(void)onDestroy;                 ---> dealloc
-(void)onPause {
  // 需要子类必须覆写
}
-(void)onResume {
  // 需要子类必须覆写
}

#pragma mark -
#pragma mark Session 过期后的处理方法
-(void)processForSessionHasExpiredInUIThread {
	/*
	 Intent *intent = [Intent intentWithSpecificComponentClass:[LoginActivity class]];
	 [intent.extras setObject:[NSNumber numberWithBool:YES] forKey:kIntentExtraTagEnum_SessionHasExpired];
	 [self startActivity:intent];
	 */
}

// session 过期后的处理方法, 目前会自动跳转到 "登录界面", 如果用户在登录界面点击返回按钮, 就直接返回 "推荐首页"
-(void)processForSessionHasExpiredInNonUIThread {
  [self performSelectorOnMainThread:@selector(processForSessionHasExpiredInUIThread)
                         withObject:nil
                      waitUntilDone:NO];
}

#pragma mark -
#pragma mark 为 爱日租 项目做的一个界面特殊跳转(新订单的订单详情界面, 点击 "订单管理" 按钮后, 返回 "订单中心", 此时订单中心还未被创建
// 创建一个新的Activity, 并且插入到targetActivity之上, 并且移除targetActivity之上原来所有的Activity
-(void)startActivityByIntent:(Intent *)intent andMoveToTheAboveTargetActivityClass:(Class)targetActivityClass {
  @synchronized(self) {
    [[LocalActivityManagerSingleton sharedInstance] startActivityByIntent:intent
                                     andMoveToTheAboveTargetActivityClass:targetActivityClass];
  }
}
@end
