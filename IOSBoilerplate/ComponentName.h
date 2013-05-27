//
//  ComponentName.h
//  airizu
//
//  Created by 唐志华 on 13-1-9.
//
//

#import <Foundation/Foundation.h>

// "组件名称" 类 
@interface ComponentName : NSObject {
  
}

@property(nonatomic, readonly, strong) NSString *className;

#pragma mark -
#pragma mark 方便构造
+(id)componentNameWithClass:(Class) cls;
+(id)componentNameWithClassName:(NSString *) className;
@end
