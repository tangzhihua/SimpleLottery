//
//  IntentFilter.h
//  airizu
//
//  Created by 唐志华 on 13-1-24.
//
//

#import <Foundation/Foundation.h>

@interface IntentFilter : NSObject {
  
}
@property (nonatomic, readonly, strong) NSMutableArray *actions;

+(id)intentFilter;
@end
