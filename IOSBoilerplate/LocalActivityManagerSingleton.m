//
//  CoordinatingController.m
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import "LocalActivityManagerSingleton.h"

#import "Intent.h"
#import "GlobalDataCacheForMemorySingleton.h"

#import "Activity.h"

#import "ComponentName.h"
#import "MainNavigationActivity.h"



#import <QuartzCore/QuartzCore.h>








@interface LocalActivityManagerSingleton ()

//
@property(nonatomic, strong) NSMutableArray *activityStack;

/*
 这是当前处于屏幕顶层显示的视图控制器
 */
@property (nonatomic, weak) Activity *activeActivity;

//
@property (nonatomic, assign) int resultCode;
@property (nonatomic, strong) Intent *resultData;

@end












@implementation LocalActivityManagerSingleton

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
    
    // Activity栈
    _activityStack = [[NSMutableArray alloc] initWithCapacity:50];
    
    
    // 这是整个App的根视图(root view), 一切后来者都在这个视图之上, 这个视图就是一个裸 UIViewController 对象
    _rootViewController = [[Activity alloc] init];
    [_activityStack addObject:_rootViewController];
    
    //
    _activeActivity = _rootViewController;
  }
  
  return self;
}

+ (LocalActivityManagerSingleton *) sharedInstance {
  static LocalActivityManagerSingleton *singletonInstance = nil;
  static dispatch_once_t pred;
  dispatch_once(&pred, ^{singletonInstance = [[self alloc] initSingleton];});
  return singletonInstance;
}

#pragma mark -
#pragma mark

- (void) startActivityForResult:(Intent *) intent
                    requestCode:(int) requestCode {
  do {
    
    if (nil == self.activeActivity) {
      RNAssert(NO, @"activeActivity is null!");
      break;
    }
    if (nil == intent) {
      RNAssert(NO, @"入参 intent 不能为空 ! ");
      break;
    }
    if (nil == intent.component) {
      RNAssert(NO, @"入参 intent.component 不能为空 ! ");
      break;
    }
    if ([NSString isEmpty:intent.component.className]) {
      RNAssert(NO, @"入参 intent.component.className 不能为空 ! ");
      break;
    }
    Class targetActivityClass = NSClassFromString(intent.component.className);
    if (nil == targetActivityClass) {
      RNAssert(NO, @"要启动的目标 Activity 无效 ! ");
      break;
    }
    
    // 保存 requestCode, 如果 requestCode 不为 kRequestCode_None, 证明用户是调用 startActivityForResult 方法启动一个Activity,
    // 也就是说当被启动的Activity关闭后, 用户希望得到此Activity返回的数据.
    self.activeActivity.requestCode = requestCode;
    
    // Already have information about the new activity id?
    // 如果目标Activity类型的的Class 未在Activity堆栈中存在, 就直接添加之
    BOOL adding = ![self isContainsTargetActivity:targetActivityClass];
    if (!adding) {
      
      /// 如果要启动的Activity已经在栈顶, 就不会被启动.
      if (intent.flags == FLAG_ACTIVITY_SINGLE_TOP) {
        if ([self.activeActivity class] != targetActivityClass) {
          adding = YES;
        }
      }
      /// 清理目标Activity之上的全部Activity
      else if (intent.flags == FLAG_ACTIVITY_CLEAR_TOP) {
        
        // 弹出目标Activity之上的全部Activity
        [self popAllActivitiesOfAboveTargetActivity:targetActivityClass];
        
        // 一定要后播放 窗口切换动画
        [self playActivityCloseAnimation:self.activeActivity.view];
        
      }
      ///
      else {
        PRPLog(@"无效的 intent.flags, 目前还不支持的 flag");
        // 目前还未 支持 launchMode 属性, 所以这里暂时为支持 LAUNCH_SINGLE_TASK, 而临时处理
        adding = YES;
      }
      
    }
    
    if (adding) {
      // Need to create it...
      
      // 一定要先播放 窗口切换动画
      [self playActivityOpenAnimation:self.activeActivity.view];
      
      Activity *newActivity = [Activity activityFromSubclass:targetActivityClass intent:intent];
      if ([newActivity isKindOfClass:[Activity class]]) {
        [self pushActivity:newActivity];
      }
    }
    
  } while (NO);
}

- (void) finishActivity:(Activity *) sourceActivity
             resultCode:(int) resultCode
             resultData:(Intent *) resultData {
  
  if (![sourceActivity isKindOfClass:[Activity class]]) {
    RNAssert(NO, @"入参 sourceActivity 无效");
    return;
  }
  
  do {
    
    if (sourceActivity != self.activeActivity) {
      RNAssert(NO, @"如果想要关闭当前Activity后, 启动一个新的Activity, 必须先调用 finish方法, 然后在调用 startActivity 方法");
      break;
    }
    self.resultCode = resultCode;
    self.resultData = resultData;
    
    // 先将当前窗口弹栈
    [self popActivity];
    
    // 播放窗体切换动画
    [self playActivityCloseAnimation:self.activeActivity.view];
  } while (NO);
}

// 将 Activity堆栈最顶层的那个 Activity 弹栈
- (void) popActivity {
  
  do {
    if (nil == self.activeActivity || nil == self.activeActivity.view) {
      RNAssert(NO, @"curView or curViewController is null!");
      break;
    }
    
    // 上一个 View
    UIView *prevView = self.activeActivity.view.superview;
    // 上一个 Controller
    Activity *prevActivity = (Activity *)self.activeActivity.parentViewController;
    if (nil == prevView || nil == prevActivity) {
      RNAssert(NO, @"prevView or prevViewController is null!");
      break;
    }
    
    Activity *currentActivity = self.activeActivity;
    
    [currentActivity onPause];// Activity 生命周期
    
    // 将当前最顶层的Activity 弹栈
    [currentActivity.view removeFromSuperview];
    //
    [self.activityStack removeObject:currentActivity];
    //
    [currentActivity onDestroy];
    currentActivity = nil;
    
    //
    self.activeActivity = prevActivity;
    
    [prevActivity onResume];// Activity 生命周期
    
  } while (NO);
  
}

- (void) popAllActivitiesOfAboveTargetActivity:(Class) targetActivityClass {
  if (![self isContainsTargetActivity:targetActivityClass]) {
    // 目标 Activity 不在当前Activity堆栈中.
    return;
  }
  
  Activity *currentlyActivity = self.activeActivity;
  while (currentlyActivity != nil && self.rootViewController != currentlyActivity) {
    if ([currentlyActivity class] == targetActivityClass) {
      // 已经将目标Activity弹到 Activity堆栈的最顶端
      break;
    }
    
    //
    [self popActivity];
    //
    currentlyActivity = self.activeActivity;
  }
}

// 将一个 Activity对象 压栈
- (void) pushActivity:(Activity *) newActivity {
  
  // 将新创建的 activity 对象压栈保存
  [self.activityStack addObject:newActivity];
  
  Activity *currentActivity = self.activeActivity;
  
  [currentActivity onPause];// Activity 生命周期
  
  // 将新 Activity 压栈
  [currentActivity addChildViewController:newActivity];
  UIView *currentActivityView = currentActivity.view;
  UIView *newActivityView = newActivity.view;
  [currentActivityView addSubview:newActivityView];
  
  // 更换当前处于激活状态的Activity对象
  self.activeActivity = newActivity;
  
  [self.activeActivity onResume];// Activity 生命周期
}

// 判断目标Activity是否已经在Activity堆栈中存在
- (BOOL) isContainsTargetActivity:(Class) targetActivityClass {
  
  BOOL result = NO;
  Activity *currentlyActivity = self.activeActivity;
  while (currentlyActivity != nil && self.rootViewController != currentlyActivity) {
    if ([currentlyActivity class] == targetActivityClass) {
      result = YES;
      break;
    }
    
    currentlyActivity = (Activity *)[currentlyActivity parentViewController];
  }
  
  return result;
}

// 创建一个新的Activity, 并且插入到targetActivity之上, 并且移除targetActivity之上原来所有的Activity
-(void) startActivityByIntent:(Intent *)intent andMoveToTheAboveTargetActivityClass:(Class)targetActivityClass {
  
  do {
    if (nil == targetActivityClass) {
      RNAssert(NO, @"activeActivity is null!");
      break;
    }
    if (nil == self.activeActivity) {
      RNAssert(NO, @"activeActivity is null!");
      break;
    }
    if (nil == intent) {
      RNAssert(NO, @"入参 intent 不能为空 ! ");
      break;
    }
    if (nil == intent.component) {
      RNAssert(NO, @"入参 intent.component 不能为空 ! ");
      break;
    }
    if ([NSString isEmpty:intent.component.className]) {
      RNAssert(NO, @"入参 intent.component.className 不能为空 ! ");
      break;
    }
    Class newActivityClass = NSClassFromString(intent.component.className);
    if (nil == newActivityClass) {
      RNAssert(NO, @"要启动的目标 Activity 无效 ! ");
      break;
    }
    
    //
    [self popAllActivitiesOfAboveTargetActivity:targetActivityClass];
    
    Activity *newActivity = [Activity activityFromSubclass:newActivityClass intent:intent];
    if ([newActivity isKindOfClass:[Activity class]]) {
      [self pushActivity:newActivity];
    }
    
    // 一定要后播放 窗口切换动画
    [self playActivityCloseAnimation:self.activeActivity.view];
  } while (NO);
}

#pragma mark -
#pragma mark Activity 切换动画
/*
 setType 可以返回四种类型：
 kCATransitionFade     淡出
 kCATransitionMoveIn   覆盖原图
 kCATransitionPush     推出
 kCATransitionReveal   底部显出来
 
 setSubtype 也可以有四种类型：
 kCATransitionFromRight；
 kCATransitionFromLeft : 默认值
 kCATransitionFromTop；
 kCATransitionFromBottom
 
 而以下为则黑名单：
 
 spewEffect: 新版面在屏幕下方中间位置被释放出来覆盖旧版面.
 
 - genieEffect: 旧版面在屏幕左下方或右下方被吸走, 显示出下面的新版面 (阿拉丁灯神?).
 
 - unGenieEffect: 新版面在屏幕左下方或右下方被释放出来覆盖旧版面.
 
 - twist: 版面以水平方向像龙卷风式转出来.
 
 - tubey: 版面垂直附有弹性的转出来.
 
 - swirl: 旧版面360度旋转并淡出, 显示出新版面.
 
 - charminUltra: 旧版面淡出并显示新版面.
 
 - zoomyIn: 新版面由小放大走到前面, 旧版面放大由前面消失.
 
 - zoomyOut: 新版面屏幕外面缩放出现, 旧版面缩小消失.
 
 - oglApplicationSuspend: 像按"home" 按钮的效果.
 
 */
- (void) playActivityCloseAnimation:(UIView *) sourceView {
  
  /*
   [UIView beginAnimations:@"PopChildView" context:nil];
   [UIView setAnimationCurve:UIViewAnimationCurveLinear];
   [UIView setAnimationDuration:0.5];
   [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:sourceView cache:YES];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
   [UIView commitAnimations];
   */
  
  
  CATransition *animation = [CATransition animation];
  animation.delegate = self;
  animation.duration = 0.5f;
  animation.timingFunction = UIViewAnimationCurveEaseInOut;
  animation.type = kCATransitionPush;
  animation.subtype = kCATransitionFromLeft;
  animation.removedOnCompletion = YES;
  [[self.rootViewController.view layer] addAnimation:animation forKey:@"PopChildView"];
  
  
}

- (void) playActivityOpenAnimation:(UIView *) sourceView {
  /*
   [UIView beginAnimations:@"PushChildView" context:nil];
   [UIView setAnimationCurve:UIViewAnimationCurveLinear];
   [UIView setAnimationDuration:0.5];
   [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:sourceView cache:NO];
   [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
   [UIView commitAnimations];
   */
  
  CATransition *animation = [CATransition animation];
  //animation.delegate = self;
  animation.duration = 0.5f;
  animation.timingFunction = UIViewAnimationCurveEaseInOut;
  animation.type = kCATransitionPush;
  animation.subtype = kCATransitionFromRight;
  animation.removedOnCompletion = YES;
  [[self.rootViewController.view layer] addAnimation:animation forKey:@"PushChildView"];
  
}

- (void) animationDidStop:(NSString *) animationID
                 finished:(NSNumber *) finished
                  context:(void *) context {
  
  if ([animationID isEqualToString:@"PopChildView"]) {
    do {
      if (nil == self.activeActivity) {
        RNAssert(NO, @"_activeActivity 为 nil");
        break;
      }
      if (self.activeActivity.requestCode == kRequestCode_None) {
        // 用户不是调用 startActivityForResult 启动一个Activity的
        break;
      }
      
      // 完成 startActivityForResult 有关的操作
      id activity = self.activeActivity;
      const int requestCode = self.activeActivity.requestCode;
      self.activeActivity.requestCode = kRequestCode_None;
      const int resultCode = self.resultCode;
      self.resultCode = kActivityResultCode_RESULT_CANCELED;
			
			//
      __strong id resultData = self.resultData;
      self.resultData = nil;
      
      if ([activity respondsToSelector:@selector(onActivityResult:resultCode:data:)]) {
        // 将数据转给目标Activity
        [activity onActivityResult:requestCode resultCode:resultCode data:resultData];
      }
      
      //
      resultData = nil;
      
    } while (NO);
    
  } else if([animationID isEqualToString:@"PushChildView"]) {
    
  }
}

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
  
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
  do {
    if (nil == self.activeActivity) {
      RNAssert(NO, @"_activeActivity 为 nil");
      break;
    }
    if (self.activeActivity.requestCode == kRequestCode_None) {
      // 用户不是调用 startActivityForResult 启动一个Activity的
      break;
      
    }
    
    // 完成 startActivityForResult 有关的操作
    id activity = self.activeActivity;
    const int requestCode = self.activeActivity.requestCode;
    self.activeActivity.requestCode = kRequestCode_None;
    const int resultCode = self.resultCode;
    self.resultCode = kActivityResultCode_RESULT_CANCELED;
    
    //
    __strong id resultData = self.resultData;
    self.resultData = nil;
    
    if ([activity respondsToSelector:@selector(onActivityResult:resultCode:data:)]) {
      // 将数据转给目标Activity
      [activity onActivityResult:requestCode resultCode:resultCode data:resultData];
    }
    
    //
    resultData = nil;
    
  } while (NO);
}
@end
