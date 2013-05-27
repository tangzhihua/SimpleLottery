//
//  GlobalDataCache.m
//  gameqa
//
//  Created by user on 12-9-13.
//
//

#import "GlobalDataCacheForMemorySingleton.h"
#import "Util.h"
#import "LocalCacheDataPathConstant.h"

@implementation GlobalDataCacheForMemorySingleton

static GlobalDataCacheForMemorySingleton *singletonInstance = nil;

- (void) initialize {
  
}

#pragma mark -
#pragma mark 单例方法群

+ (GlobalDataCacheForMemorySingleton *) sharedInstance {
	@synchronized(self) {
		if (singletonInstance == nil) {
			singletonInstance = [[super allocWithZone:NULL] init];
			
			// initialize the first view controller
			// and keep it with the singleton
			[singletonInstance initialize];
		}
		
		return singletonInstance;
	}
}

/*
 + (id) allocWithZone:(NSZone *)zone {
 return [[self sharedInstance] retain];
 }
 
 - (id) copyWithZone:(NSZone*)zone {
 return self;
 }
 
 - (id) retain {
 return self;
 }
 
 - (NSUInteger) retainCount {
 return NSUIntegerMax;
 }
 
 - (oneway void) release {
 // do nothing
 }
 
 - (id) autorelease {
 return self;
 }
 */

#pragma mark -
#pragma mark
-(NSUInteger)localCacheSize{
  
  NSUInteger size = 0;
  NSArray *directories = [LocalCacheDataPathConstant directoriesCanBeClearByTheUser];
  for(NSString *directory in directories) {
    size += [Util folderSizeAtPath3:directory];
  }
  
  return size;
  
}
@end
