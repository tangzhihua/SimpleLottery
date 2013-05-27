//
//  NSDate+convenience.m
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "NSDate+Convenience.h"

@implementation NSDate (Convenience)

-(NSDateComponents *)dateComponents {
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSDateComponents *components =
  [calendarForGregorian components:kCFCalendarUnitEra | kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay |
   kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond | kCFCalendarUnitWeek |
   kCFCalendarUnitWeekday | kCFCalendarUnitWeekdayOrdinal | kCFCalendarUnitQuarter | kCFCalendarUnitWeekOfMonth |
   kCFCalendarUnitWeekOfYear | kCFCalendarUnitYearForWeekOfYear fromDate:self];
  
  return components;
}

-(NSUInteger)firstWeekDayInMonth {
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  [calendarForGregorian setFirstWeekday:1]; // Sunday is first day
  //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
  
  //Set date to first of month
  NSDateComponents *components = [calendarForGregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self];
  [components setDay:1];
  NSDate *newDate = [calendarForGregorian dateFromComponents:components];
  
  NSUInteger firstWeekDayInMonth = [calendarForGregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
  
  return firstWeekDayInMonth;
}

-(NSDate *)offsetMonth:(NSInteger)numMonths {
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  [calendarForGregorian setFirstWeekday:1]; // Sunday is first day
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setMonth:numMonths];
  //[offsetComponents setHour:1];
  //[offsetComponents setMinute:30];
  NSDate *targetMonth = [calendarForGregorian dateByAddingComponents:offsetComponents toDate:self options:0];
	
  return targetMonth;
}

-(NSDate *)offsetDay:(NSInteger)numDays {
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  [calendarForGregorian setFirstWeekday:1]; // Sunday is first day
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  [offsetComponents setDay:numDays];
  //[offsetComponents setHour:1];
  //[offsetComponents setMinute:30];
  
  NSDate *targetDay = [calendarForGregorian dateByAddingComponents:offsetComponents toDate:self options:0];
	
  return targetDay;
}

-(NSDate *)offsetHour:(NSInteger)numHours {
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  [calendarForGregorian setFirstWeekday:1]; // Sunday is first day
  
  NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
  //[offsetComponents setMonth:numMonths];
  [offsetComponents setHour:numHours];
  //[offsetComponents setMinute:30];
  NSDate *targetHour = [calendarForGregorian dateByAddingComponents:offsetComponents toDate:self options:0];
  
  return targetHour;
}

-(NSUInteger)numberOfDaysInMonth {
  NSCalendar *currentCalendar = [NSCalendar currentCalendar];
  NSRange rangeForCurrentMonth = [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
  NSUInteger numberOfDaysInMonth = rangeForCurrentMonth.length;
  return numberOfDaysInMonth;
}

+(NSDate *)dateStartOfDay:(NSDate *)date {
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
  NSDateComponents *components =
  [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                         NSDayCalendarUnit) fromDate: date];
  NSDate *day = [gregorian dateFromComponents:components];
  
  return day;
}

+(NSDate *)dateStartOfWeek {
  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  [gregorian setFirstWeekday:1]; // Sunday is first day
  
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
  
  NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
  [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday]) + 7 ) % 7)];
  NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
  
  NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                      fromDate: beginningOfWeek];
  
  //gestript
  beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
  
  return beginningOfWeek;
}

+(NSDate *)dateEndOfWeek {
  NSCalendar *gregorian =[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  
  NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
  
  NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
  [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday]) + 7 ) % 7))+6];
  NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
  
  NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                      fromDate: endOfWeek];
  
  //gestript
  endOfWeek = [gregorian dateFromComponents: componentsStripped];
  
  return endOfWeek;
}

// 从目标 MonthDate 中获取 日期索引 对应的 NSDate
+(NSDate *)dayDateFromMonthDate:(NSDate *)monthDate dayIndex:(NSInteger)dayIndex {
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendarForGregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit) fromDate:monthDate];
	[components setDay:dayIndex];
	NSDate *dayDate = [calendarForGregorian dateFromComponents:components];
	
	return dayDate;
}

+(NSString *)weekdayChinaName:(NSInteger)weekday {
  if (weekday < 1 || weekday > 7) {
    // 入参错误
    return nil;
  }
  
  NSArray *weekChinaNameArray = [NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
  return [weekChinaNameArray objectAtIndex:weekday - 1];
}

-(NSString *)stringWithDateFormat:(NSString *)dateFormat {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:dateFormat];
  NSString *stringValue = [dateFormatter stringFromDate:self];
	
  return stringValue;
}

+(NSDate *)todayDate {
  
  NSCalendar *calendarForGregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSDateComponents *components =
  [calendarForGregorian components:kCFCalendarUnitEra | kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay |
   kCFCalendarUnitHour | kCFCalendarUnitMinute | kCFCalendarUnitSecond | kCFCalendarUnitWeek |
   kCFCalendarUnitWeekday | kCFCalendarUnitWeekdayOrdinal | kCFCalendarUnitQuarter | kCFCalendarUnitWeekOfMonth |
   kCFCalendarUnitWeekOfYear | kCFCalendarUnitYearForWeekOfYear fromDate:[NSDate date]];
  NSDate *todayDate = [calendarForGregorian dateFromComponents:components];
  
  return todayDate;
}

-(BOOL)isEqualToDate:(NSDate *)otherDate withDateFormat:(NSString *)dateFormat {
  NSString *nowDateStringWithFormat = [self stringWithDateFormat:dateFormat];
  NSString *otherDateStringWithFormat = [otherDate stringWithDateFormat:dateFormat];
  return [nowDateStringWithFormat isEqualToString:otherDateStringWithFormat];
}

+(NSDate *)stringToDate:(NSString *)string {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSDate *date = [dateFormatter dateFromString:string];
  
  return date;
}

-(NSInteger)daysWithinEraFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
  NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
  NSUInteger unitFlags = NSDayCalendarUnit;
  NSDateComponents *components = [gregorianCalendar components:unitFlags
                                                      fromDate:startDate
                                                        toDate:endDate
                                                       options:0];
  NSInteger days = [components day];
  return days;
}
@end
