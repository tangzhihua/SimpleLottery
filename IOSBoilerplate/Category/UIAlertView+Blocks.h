//
//  UIAlertView+Blocks.h
//  UIKitCategoryAdditions
//

#import <Foundation/Foundation.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();


// 20130625 : 这个类别其实实现的有问题, 因为DismissBlock和CancelBlock块不会跟每个UIAlertView准确对应
// 如果外面连续两次调用 showAlertViewWithTitle 那么只是最后的 DismissBlock和CancelBlock块 有效.
// 也就是说这个类别方法只适用于同一时间只显示一个UIAlertView的情况下, 才有有意义, 如果第一个UIAlertView弹出后,
// 用户还未做出选择, 此时第二个弹出框也弹出了, 那么DismissBlock和CancelBlock块 就只是第二个UIAlertView的块了


// 这里只是为了演示 过程式编程 和 函数式编程
// 函数式编程中, 代码读起来更像人类语言.
@interface UIAlertView (Blocks) <UIAlertViewDelegate>

+ (UIAlertView *) showAlertViewWithTitle:(NSString *) title
                                 message:(NSString *) message
                       cancelButtonTitle:(NSString *) cancelButtonTitle
                       otherButtonTitles:(NSArray *) otherButtons
                               onDismiss:(DismissBlock) dismissed
                                onCancel:(CancelBlock) cancelled;

@end
