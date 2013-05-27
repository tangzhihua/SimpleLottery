//
//  NSDate+Convenience.h
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

-(NSDateComponents *)dateComponents;

// 左右平移 -1(上一个) 1(下一个)
-(NSDate *)offsetMonth:(NSInteger)numMonths;
-(NSDate *)offsetDay:(NSInteger)numDays;
-(NSDate *)offsetHour:(NSInteger)numHours;

// 
-(NSUInteger)numberOfDaysInMonth;
-(NSUInteger)firstWeekDayInMonth;

+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;

// 从目标 MonthDate 中获取 日期索引 对应的 NSDate
+(NSDate *)dayDateFromMonthDate:(NSDate *)monthDate dayIndex:(NSInteger)dayIndex;

+(NSString *)weekdayChinaName:(NSInteger)weekday;

-(NSString *)stringWithDateFormat:(NSString *)dateFormat;

+(NSDate *)todayDate;

-(BOOL)isEqualToDate:(NSDate *)otherDate withDateFormat:(NSString *)dateFormat;

+(NSDate *)stringToDate:(NSString *)string;

-(NSInteger)daysWithinEraFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;

 
@end
