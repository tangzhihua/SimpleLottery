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

@interface LocalActivityManagerSingleton ()

//
@property(nonatomic, retain) NSMutableArray *activityStack;

/*
 这是当前处于屏幕顶层显示的视图控制器
 */
@property (nonatomic, assign) Activity *activeActivity;

//
@property (nonatomic, assign) int resultCode;
@property (nonatomic, retain) Intent *resultData;

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
    
    //
    _activityStack = [[NSMutableArray alloc] initWithCapacity:50];
    
    
    // 这是整个App的根视图(root view), 一切后来者都在这个视图之上, 这个视图就是一个裸 UIViewController 对象
    _rootViewController = [[Activity alloc] init];
    [_activityStack addObject:_rootViewController];
    
    // App
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
    
    if (nil == _activeActivity) {
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
    _activeActivity.requestCode = requestCode;
    
    // Already have information about the new activity id?
    // 如果目标Activity类型的的Class 未在Activity堆栈中存在, 就直接添加之
    BOOL adding = ![self isContainsTargetActivity:targetActivityClass];
    if (!adding) {
      
      ///
      if (intent.flags == FLAG_ACTIVITY_SINGLE_TOP) {
        if ([_activeActivity class] != targetActivityClass) {
          adding = YES;
        }
      }
      ///
      else if (intent.flags == FLAG_ACTIVITY_CLEAR_TOP) {
        
        //
        [self popAllActivitiesAboveTargetActivity:targetActivityClass];
        
        // 一定要后播放 窗口切换动画
        [self playActivityCloseAnimation:_activeActivity.view];
        
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
      [self playActivityOpenAnimation:_activeActivity.view];
      
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
    
    if (sourceActivity != _activeActivity) {
      RNAssert(NO, @"如果想要关闭当前Activity后, 启动一个新的Activity, 必须先调用 finish方法, 然后在调用 startActivity 方法");
      break;
    }
    self.resultCode = resultCode;
    self.resultData = resultData;
    
    // 先将当前窗口弹栈
    [self popActivity];
    
    // 播放窗体切换动画
    [self playActivityCloseAnimation:_activeActivity.view];
  } while (NO);
}

- (void) playActivityCloseAnimation:(UIView *) sourceView {
  
  
  [UIView beginAnimations:@"PopChildView" context:nil];
  [UIView setAnimationCurve:UIViewAnimationCurveLinear];
  [UIView setAnimationDuration:0.5];
  [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:sourceView cache:YES];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
  [UIView commitAnimations];
  
  
  /*
   CATransition *animation = [CATransition animation];
   animation.delegate = self;
   animation.duration = 4.7f;
   animation.timingFunction = UIViewAnimationCurveEaseInOut;
   animation.type = @"rippleEffect";
   animation.subtype = kCATransitionFromLeft;
   [[self.rootViewController.view layer] addAnimation:animation forKey:@"animation"];
   */
  
}

- (void) playActivityOpenAnimation:(UIView *) sourceView {
  
  [UIView beginAnimations:@"PushChildView" context:nil];
  [UIView setAnimationCurve:UIViewAnimationCurveLinear];
  [UIView setAnimationDuration:0.5];
  [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:sourceView cache:YES];
  [UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
  [UIView commitAnimations];
  
  /*
   CATransition *animation = [CATransition animation];
   animation.delegate = self;
   animation.duration = 0.7f;
   animation.timingFunction = UIViewAnimationCurveEaseInOut;
   animation.type = @"rippleEffect";
   animation.subtype = kCATransitionFromLeft;
   [[self.rootViewController.view layer] addAnimation:animation forKey:@"animation"];
   */
}

- (void) animationDidStop:(NSString *) animationID
                 finished:(NSNumber *) finished
                  context:(void *) context {
  
  if ([animationID isEqualToString:@"PopChildView"]) {
    do {
      if (nil == _activeActivity) {
        RNAssert(NO, @"_activeActivity 为 nil");
        break;
      }
      if (_activeActivity.requestCode == kRequestCode_None) {
        // 用户不是调用 startActivityForResult 启动一个Activity的
        break;
      }
      
      // 完成 startActivityForResult 有关的操作
      id activity = _activeActivity;
      const int requestCode = _activeActivity.requestCode;
      _activeActivity.requestCode = kRequestCode_None;
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

// 将 Activity堆栈最顶层的那个 Activity 弹栈
- (void) popActivity {
  
  do {
    if (nil == _activeActivity || nil == _activeActivity.view) {
      RNAssert(NO, @"curView or curViewController is null!");
      break;
    }
    
    // 上一个 View
    UIView *prevView = _activeActivity.view.superview;
    // 上一个 Controller
    Activity *prevActivity = (Activity *)_activeActivity.parentViewController;
    if (nil == prevView || nil == prevActivity) {
      RNAssert(NO, @"prevView or prevViewController is null!");
      break;
    }
    
    // Activity 生命周期
    [_activeActivity onPause];
    
    // 将当前最顶层的Activity 弹栈
    [_activeActivity.view removeFromSuperview];
    //
    [_activityStack removeObject:_activeActivity];
    //
    _activeActivity = prevActivity;
    
    // Activity 生命周期
    [_activeActivity onResume];
    
  } while (NO);
  
}

- (void) popAllActivitiesAboveTargetActivity:(Class) targetActivityClass {
  if (![self isContainsTargetActivity:targetActivityClass]) {
    // 目标 Activity 不在当前Activity堆栈中.
    return;
  }
  
  Activity *currentlyActivity = _activeActivity;
  while (currentlyActivity != nil && _rootViewController != currentlyActivity) {
    if ([currentlyActivity class] == targetActivityClass) {
      // 已经将目标Activity弹到 Activity堆栈的最顶端
      break;
    }
    
    //
    [self popActivity];
    //
    currentlyActivity = _activeActivity;
  }
}

// 将一个 Activity对象 压栈
- (void) pushActivity:(Activity *) newActivity {
  
  // 将新创建的 activity 对象压栈保存
  [_activityStack addObject:newActivity];
  
  /***********************************************************/
  // Activity 生命周期
  [_activeActivity onPause];
  
  // 将新 Activity 压栈
  [_activeActivity addChildViewController:newActivity];
  UIView *activeActivityView = _activeActivity.view;
  UIView *newActivityView = newActivity.view;
  [activeActivityView addSubview:newActivityView];
  // 更换当前处于激活状态的Activity
  _activeActivity = newActivity;
  
  // Activity 生命周期
  [_activeActivity onResume];
}

- (BOOL) isContainsTargetActivity:(Class) targetActivityClass {
  
  BOOL result = NO;
  Activity *currentlyActivity = _activeActivity;
  while (currentlyActivity != nil && _rootViewController != currentlyActivity) {
    if ([currentlyActivity class] == targetActivityClass) {
      result = YES;
      break;
    }
    
    currentlyActivity = (Activity *)[currentlyActivity parentViewController];
  }
  
  return result;
}

// 创建一个新的Activity, 并且插入到targetActivity之上, 并且移除targetActivity之上原来所有的Activity
-(void)startActivityByIntent:(Intent *)intent andMoveToTheAboveTargetActivityClass:(Class)targetActivityClass {
  
  do {
    if (nil == targetActivityClass) {
      RNAssert(NO, @"activeActivity is null!");
      break;
    }
    if (nil == _activeActivity) {
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
    [self popAllActivitiesAboveTargetActivity:targetActivityClass];
    
    Activity *newActivity = [Activity activityFromSubclass:newActivityClass intent:intent];
    if ([newActivity isKindOfClass:[Activity class]]) {
      [self pushActivity:newActivity];
    }
    // 一定要后播放 窗口切换动画
    [self playActivityCloseAnimation:_activeActivity.view];
  } while (NO);
}
@end
