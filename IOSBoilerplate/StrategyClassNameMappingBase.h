//
//  StrategyClassNameMappingBase.h
//  airizu
//
//  Created by 唐志华 on 12-12-17.
//
//

#import <Foundation/Foundation.h>

@interface StrategyClassNameMappingBase : NSObject {
@protected
  NSMutableDictionary *strategyClassesNameMappingList;
}

//@property (nonatomic, readonly) NSMutableDictionary *strategyClassesNameMappingList;

- (NSString *) getTargetClassNameForKey:(id) key;
@end
