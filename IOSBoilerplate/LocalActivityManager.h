//
//  CoordinatingController.h
//  TouchPainter
//
//  Created by Carlo Chung on 10/18/10.
//  Copyright 2010 Carlo Chung. All rights reserved.
//

#import <Foundation/Foundation.h>

// startActivityForResult 方法中 requestCode 的默认值
#define kRequestCode_None (-1)

@interface LocalActivityManager : NSObject {
  
}

/*
 这是整个App的根视图(root view), 一切后来者都在这个视图之上, 这个视图就是一个裸 UIViewController 对象
 */
@property (nonatomic, readonly, strong) Activity *rootViewController;

+ (LocalActivityManager *) sharedInstance;

- (void) finishActivity:(Activity *) sourceActivity
             resultCode:(int) resultCode
             resultData:(Intent *) resultData;

- (void) startActivityForResult:(Intent *) intent
                    requestCode:(int) requestCode;

// 创建一个新的Activity, 并且插入到targetActivity之上, 并且移除targetActivity之上原来所有的Activity
-(void)startActivityByIntent:(Intent *)intent andMoveToTheAboveTargetActivityClass:(Class)targetActivityClass;
@end
