
#import <UIKit/UIKit.h>
 
#import "cocos2d.h"
@interface IOSBoilerplateAppDelegate : Activity <UIApplicationDelegate> {
 
}
 
// window 必须是strong
@property (nonatomic, strong) IBOutlet UIWindow *window;

//@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

+ (IOSBoilerplateAppDelegate*) sharedAppDelegate;

- (BOOL)openURL:(NSURL*)url;

@end
