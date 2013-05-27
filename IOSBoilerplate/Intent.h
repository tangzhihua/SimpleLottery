//
//  Intent.h
//  Airizu
//
//  Created by user on 12-9-10.
//
//

#import <Foundation/Foundation.h>

/**
 * If set, the new activity is not kept in the history stack.  As soon as
 * the user navigates away from it, the activity is finished.  This may also
 * be set with the {@link android.R.styleable#AndroidManifestActivity_noHistory
 * noHistory} attribute.
 */
#define FLAG_ACTIVITY_NO_HISTORY (0x40000000)

/**
 * If set, the activity will not be launched if it is already running
 * at the top of the history stack.
 */
// 如果要启动的Activity已经在栈顶, 就不会被启动.
#define FLAG_ACTIVITY_SINGLE_TOP (0x20000000)
/**
 * If set, this activity will become the start of a new task on this
 * history stack.  A task (from the activity that started it to the
 * next task activity) defines an atomic group of activities that the
 * user can move to.  Tasks can be moved to the foreground and background;
 * all of the activities inside of a particular task always remain in
 * the same order.  See
 * <a href="{@docRoot}guide/topics/fundamentals.html#acttask">Application Fundamentals:
 * Activities and Tasks</a> for more details on tasks.
 *
 * <p>This flag is generally used by activities that want
 * to present a "launcher" style behavior: they give the user a list of
 * separate things that can be done, which otherwise run completely
 * independently of the activity launching them.
 *
 * <p>When using this flag, if a task is already running for the activity
 * you are now starting, then a new activity will not be started; instead,
 * the current task will simply be brought to the front of the screen with
 * the state it was last in.  See {@link #FLAG_ACTIVITY_MULTIPLE_TASK} for a flag
 * to disable this behavior.
 *
 * <p>This flag can not be used when the caller is requesting a result from
 * the activity being launched.
 */
#define FLAG_ACTIVITY_NEW_TASK (0x10000000)
/**
 * <strong>Do not use this flag unless you are implementing your own
 * top-level application launcher.</strong>  Used in conjunction with
 * {@link #FLAG_ACTIVITY_NEW_TASK} to disable the
 * behavior of bringing an existing task to the foreground.  When set,
 * a new task is <em>always</em> started to host the Activity for the
 * Intent, regardless of whether there is already an existing task running
 * the same thing.
 *
 * <p><strong>Because the default system does not include graphical task management,
 * you should not use this flag unless you provide some way for a user to
 * return back to the tasks you have launched.</strong>
 *
 * <p>This flag is ignored if
 * {@link #FLAG_ACTIVITY_NEW_TASK} is not set.
 *
 * <p>See <a href="{@docRoot}guide/topics/fundamentals.html#acttask">Application Fundamentals:
 * Activities and Tasks</a> for more details on tasks.
 */
#define FLAG_ACTIVITY_MULTIPLE_TASK (0x08000000)
/**
 * If set, and the activity being launched is already running in the
 * current task, then instead of launching a new instance of that activity,
 * all of the other activities on top of it will be closed and this Intent
 * will be delivered to the (now on top) old activity as a new Intent.
 *
 * <p>For example, consider a task consisting of the activities: A, B, C, D.
 * If D calls startActivity() with an Intent that resolves to the component
 * of activity B, then C and D will be finished and B receive the given
 * Intent, resulting in the stack now being: A, B.
 *
 * <p>The currently running instance of activity B in the above example will
 * either receive the new intent you are starting here in its
 * onNewIntent() method, or be itself finished and restarted with the
 * new intent.  If it has declared its launch mode to be "multiple" (the
 * default) and you have not set {@link #FLAG_ACTIVITY_SINGLE_TOP} in
 * the same intent, then it will be finished and re-created; for all other
 * launch modes or if {@link #FLAG_ACTIVITY_SINGLE_TOP} is set then this
 * Intent will be delivered to the current instance's onNewIntent().
 *
 * <p>This launch mode can also be used to good effect in conjunction with
 * {@link #FLAG_ACTIVITY_NEW_TASK}: if used to start the root activity
 * of a task, it will bring any currently running instance of that task
 * to the foreground, and then clear it to its root state.  This is
 * especially useful, for example, when launching an activity from the
 * notification manager.
 *
 * <p>See <a href="{@docRoot}guide/topics/fundamentals.html#acttask">Application Fundamentals:
 * Activities and Tasks</a> for more details on tasks.
 */
#define FLAG_ACTIVITY_CLEAR_TOP (0x04000000)

/**
 * If set in an Intent passed to {@link Context#startActivity Context.startActivity()},
 * this flag will cause the launched activity to be brought to the front of its
 * task's history stack if it is already running.
 *
 * <p>For example, consider a task consisting of four activities: A, B, C, D.
 * If D calls startActivity() with an Intent that resolves to the component
 * of activity B, then B will be brought to the front of the history stack,
 * with this resulting order:  A, C, D, B.
 *
 * This flag will be ignored if {@link #FLAG_ACTIVITY_CLEAR_TOP} is also
 * specified.
 */
// 如果目标Activity在task中已存在，则将其提取到栈顶，否则就启动目标Activity
#define FLAG_ACTIVITY_REORDER_TO_FRONT (0x00020000)


@class ComponentName;
@interface Intent : NSObject {
  
}

@property (nonatomic, readonly, strong) NSMutableDictionary *extras;
@property (nonatomic, strong) ComponentName *component;
@property (nonatomic) NSInteger flags;
@property (nonatomic, copy) NSString *action;

/**
 * Returns true if an extra value is associated with the given name.
 * @param name the extra's name
 * @return true if the given extra is present.
 */
-(BOOL)hasExtra:(NSString *)name;


/**
 * Create an empty intent.
 */
+ (id) intent;

/**
 * Create an intent for a specific component.  All other fields (action, data,
 * type, class) are null, though they can be modified later with explicit
 * calls.  This provides a convenient way to create an intent that is
 * intended to execute a hard-coded class name, rather than relying on the
 * system to find an appropriate class for you; see {@link #setComponent}
 * for more information on the repercussions of this.
 */
+ (id) intentWithSpecificComponentClass:(Class) cls;
@end
