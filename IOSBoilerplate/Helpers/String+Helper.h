//
//  StringHelper.h
//  IOSBoilerplate
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import <Foundation/Foundation.h>

@interface NSString (Helper)

// 截取子字符串, 范围从 a~b
- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b;

// 查找目标索引 starts 之后的 第一个子字符串 索引
- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts;

// 清除 "空格"
- (NSString*)trim;

// 检测当前字符串是否以 入参字符串s 开头
- (BOOL)startsWith:(NSString*)s;

// 检测当前字符串是否包含 入参字符串 aString
- (BOOL)containsString:(NSString*)aString;

- (NSString*)urlEncode;

- (NSString*)sha1;

@end

