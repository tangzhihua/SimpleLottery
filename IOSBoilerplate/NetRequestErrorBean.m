//
//  RESTError.m
//  iHotelApp
//
//  Created by Mugunth Kumar on 1-Jan-11.
//  Copyright 2010 Steinlogic. All rights reserved.
//

#import "NetRequestErrorBean.h"

static NSDictionary *NetRequestError_errorCodesDictionary = nil;

@implementation NetRequestErrorBean

+ (void) initialize {
	NSString *fileName = [NSString stringWithFormat:@"Errors_%@", [[NSLocale currentLocale] localeIdentifier]];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
	
	if(filePath != nil) {
		NetRequestError_errorCodesDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	} else {
		// fall back to english for unsupported languages
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Errors_en_US" ofType:@"plist"];
		NetRequestError_errorCodesDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	}
}

+ (void) dealloc {
	[super dealloc];
}


-(id) init {
  if ((self = [super init])) {
		
		return self;
	}
  
  return self;
}


//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.message forKey:@"message"];
  [encoder encodeInteger:self.errorCode forKey:@"errorCode"];
}

- (id)initWithCoder:(NSCoder *)decoder {
  if ((self = [super init])) {
    self.message = [decoder decodeObjectForKey:@"message"];
    self.errorCode = [decoder decodeIntegerForKey:@"errorCode"];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {
  NetRequestErrorBean *theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
	
  theCopy.message = [self.message copy];
  theCopy.errorCode = self.errorCode;
	
  return theCopy;
}
#pragma mark -
#pragma mark super class implementations

-(int) code {
	if(self.errorCode == 0) {
    return [super code];
  } else {
    return self.errorCode;
  }
}
- (NSString *) domain {
  // we are assuming that any request within 1000 to 5000 is thrown by our server
	if(self.errorCode >= 1000 && self.errorCode < 5000) {
    return kBusinessErrorDomain;
  } else {
    return kRequestErrorDomain;
  }
}

- (NSString*) description {
  return [NSString stringWithFormat:@"Request failed with error %@[%d]", self.message, self.errorCode];
}

- (NSString*) localizedDescription {
  if([[self domain] isEqualToString:kBusinessErrorDomain]) {
    return [[NetRequestError_errorCodesDictionary objectForKey:[NSString stringWithFormat:@"%d", self.errorCode]] objectForKey:@"Title"];
  } else {
    return [super localizedDescription];
  }
}

- (NSString*) localizedRecoverySuggestion {
  if([[self domain] isEqualToString:kBusinessErrorDomain]) {
    return [[NetRequestError_errorCodesDictionary objectForKey:[NSString stringWithFormat:@"%d", self.errorCode]] objectForKey:@"Suggestion"];
  } else {
    return [super localizedRecoverySuggestion];
  }
}

- (NSString*) localizedOption {
  if([[self domain] isEqualToString:kBusinessErrorDomain]) {
    return [[NetRequestError_errorCodesDictionary objectForKey:[NSString stringWithFormat:@"%d", self.errorCode]] objectForKey:@"Option-1"];
  } else {
    return nil;
  }
}

//===========================================================
// dealloc
//===========================================================
- (void)dealloc {
  _message = nil;
}

@end
