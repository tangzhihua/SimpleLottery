//
//  Intent.m
//  Airizu
//
//  Created by user on 12-9-10.
//
//

#import "Intent.h"
#import "ComponentName.h"
 
#import "NSDictionary+Helper.h"

static const NSString *const TAG = @"<Intent>";

@interface Intent ()

- (id)init;
@end

@implementation Intent

- (id)init {
  if ((self = [super init])) {
		PRPLog(@"init %@ [0x%x]", TAG, [self hash]);
    
    _extras = [[NSMutableDictionary alloc] initWithCapacity:10];
    _component = nil;
    _flags = 0;
    _action = nil;
  }
  
  return self;
}


/**
 * Returns true if an extra value is associated with the given name.
 * @param name the extra's name
 * @return true if the given extra is present.
 */
-(BOOL)hasExtra:(NSString *)name {
  return [_extras containsKey:name];
}


/**
 * Create an empty intent.
 */
+ (id) intent {
  return [[Intent alloc] init];
}

/**
 * Create an intent for a specific component.  All other fields (action, data,
 * type, class) are null, though they can be modified later with explicit
 * calls.  This provides a convenient way to create an intent that is
 * intended to execute a hard-coded class name, rather than relying on the
 * system to find an appropriate class for you; see {@link #setComponent}
 * for more information on the repercussions of this.
 */
+ (id) intentWithSpecificComponentClass:(Class) cls {
  Intent *intent = [[Intent alloc] init];
  intent.component = [ComponentName componentNameWithClass:cls];
  return intent;
}
@end
