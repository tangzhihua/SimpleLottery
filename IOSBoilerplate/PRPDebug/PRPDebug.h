/***
 * Excerpted from "iOS Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/cdirec for more book information.
***/
//
//  PRPDebug.h
//
//  Created by Matt Drance on 8/28/09.
//  Copyright 2009 Bookhouse. All rights reserved.
//

#ifdef PRPDEBUG
#define PRPLog(format...) PRPDebug(__FILE__, __LINE__, format)
#else
#define PRPLog(format...)
#endif

#import <Foundation/Foundation.h>

NSString *descriptionForDebug(id object);
void PRPDebug(const char *fileName, int lineNumber, NSString *format, ...);