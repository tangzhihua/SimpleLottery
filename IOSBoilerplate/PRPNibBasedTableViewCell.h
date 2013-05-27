/***
 * Excerpted from "iOS Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/cdirec for more book information.
 ***/
#import <UIKit/UIKit.h>


@interface PRPNibBasedTableViewCell : UITableViewCell {}

// 获取 nib 文件中View frame rect, 就是使用nib自定义的控件的原始frame rect
+(CGRect)viewFrameRectFromNib;

+ (UINib *)nib;
+ (NSString *)nibName;

+ (NSString *)cellIdentifier;

// 会先通过 dequeueReusableCellWithIdentifier 获取已存在的 cell, 如果为空, 才会重新创建一个新的 cell
+ (id)cellForTableView:(UITableView *)tableView fromNib:(UINib *)nib;

// 直接创建一个新的 cell, 不会去 dequeueReusableCellWithIdentifier 中复用已有的 cell
+ (id)cellFromNib:(UINib *)nib;
@end