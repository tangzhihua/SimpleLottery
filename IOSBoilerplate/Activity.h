//
//  Activity.h
//  airizu
//
//  Created by user on 12-9-14.
//
//
#import <Foundation/Foundation.h>

@class Intent;
@class IntentFilter;











// 广播消息接收器的代理
@protocol BroadcastReceiverDelegate <NSObject>
-(void)onReceive:(Intent *)intent;
@end









typedef enum {
  
  /** Standard activity result: operation succeeded. */
  kActivityResultCode_RESULT_OK = -1,
  /** Standard activity result: operation canceled. */
  kActivityResultCode_RESULT_CANCELED = 0,
  /** Start of user-defined activity results. */
  kActivityResultCode_RESULT_FIRST_USER = 1
}ActivityResultCode;

///////////////////////////////////////////////////////////////////////////////////////////
@interface Activity : UIViewController <BroadcastReceiverDelegate>{
  
}

@property (nonatomic, strong) Intent *intent;

// requestCode  If >= 0, this code will be returned in onActivityResult() when the activity exits.
@property (nonatomic) int requestCode;


///
+(id)activity;
///
+(id)activityFromSubclass:(Class)cls intent:(Intent *)intent;


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
- (void) startActivity:(Intent *) intent;

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
- (void) startActivityForResult:(Intent *)intent
                    requestCode:(int)requestCode;


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
- (void) startActivityFromChild:(Activity *)child
                         intent:(Intent *)intent
                    requestCode:(int)requestCode;

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
- (void) setResult:(int)resultCode;

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
- (void) setResult:(int)resultCode
              data:(Intent *)data;

/**
 * Call this when your activity is done and should be closed.  The
 * ActivityResult is propagated back to whoever launched you via
 * onActivityResult().
 */
// "如果想要关闭当前Activity后, 启动一个新的Activity, 必须先调用 finish方法, 然后在调用 startActivity 方法
- (void) finish;

// 关闭自身, 并且启动一个新的Activity
- (void)finishSelfAndStartNewActivity:(Intent *)intent;

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
                     data:(Intent *) data;


#pragma mark -
#pragma mark Broadcast
// 发送一条广播消息
-(void)sendBroadcast:(Intent *)intent;


// 说明 : 当您向通知中心注册一个对象的时候, 通知中心会存储一个对该对象的弱引用, 并且在适当的消息发布时,
//       还会向该对象发送消息. 当对象被回收时, 您需要向通知中心 解注册该对象,
//       以防通知中心向这个已经不存在的对象继续发送消息.

/*
 note : 发现如果 反复调用 registerReceiver 注册接收 "同一个消息", 就会重复收到这个消息,
 所以要保证只注册同一消息一次, 或者及时 调用 unregisterReceiverWithActionName 注销目标消息
 这个应该是 iOS系统本身的问题, 或者我还没没弄明白
 */
// 注册要接收的广播消息(可以接收多条)
-(void)registerReceiver:(IntentFilter *)intentFilter;
// 注销广播消息接收器(不再接收任何广播消息)
-(void)unregisterReceiver;
// 注销目标 actionName 对应的广播消息接收
-(void)unregisterReceiverWithActionName:(NSString *)actionName;

#pragma mark -
#pragma mark Activity 生命周期 (Activity 子类进行覆写)
/*
 生命周期说明 :
 
 启动一个 Activity 时的生命周期方法调用顺序
 1. onCreate
 2. viewDidLoad
 3. onResume
 
 将一个 Activity "压栈" 时的生命周期方法调用顺序
 1. onPause
 
 将一个 Activity "移动到栈顶" 时的生命周期方法调用顺序
 1. onResume
 
 将一个 Activity "弹栈" 时的生命周期方法调用顺序
 1. onPause
 2. dealloc
 
 */
-(void)onCreate:(Intent *)intent;
// 在使用ARC后, dealloc 变的不适用了
-(void)onDestroy;

// Activity 进入前台时, 在 viewDidLoad 之前进入这里
-(void)onResume;

// Activity 进入后台时 (也包括Activity退出时, 也会在 dealloc 之前进入这里
-(void)onPause;

/*
 --------     Warning     --------
 
 1) 一定不要在 "生命周期" 方法中, 调用 finish/startActivity 这样的方法, 因为此时还未初始化彻底完成,
 如果想要调用上述方法, 请使用 performSelector:withObject:afterDelay: 方法进行异步调用.
 note:生命周期方法包括 : onCreate/onResume/onPause/viewDidLoad/dealloc
 
 ---------------------------------
 */


#pragma mark -
#pragma mark Session 过期后的处理方法
// 20130304 add, 目前临时这么处理
// session 过期后的处理方法, 目前会自动跳转到 "登录界面", 如果用户在登录界面点击返回按钮, 就直接返回 "推荐首页"
-(void)processForSessionHasExpiredInNonUIThread;


#pragma mark -
#pragma mark 为 爱日租 项目做的一个界面特殊跳转(新订单的订单详情界面, 点击 "订单管理" 按钮后, 返回 "订单中心", 此时订单中心还未被创建
// 创建一个新的Activity, 并且插入到targetActivity之上, 并且移除targetActivity之上原来所有的Activity
-(void)startActivityByIntent:(Intent *)intent andMoveToTheAboveTargetActivityClass:(Class)targetActivityClass;
@end
