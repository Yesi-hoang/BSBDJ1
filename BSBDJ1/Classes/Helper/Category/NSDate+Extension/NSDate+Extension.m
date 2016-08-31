//
//  NSDate+Extension.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "NSDate+Extension.h"
#import "NSCalendar+Extension.h"
@implementation YYDateItem
- (NSString *)description{
    return [NSString stringWithFormat:@"%zdday %zdhour %zdminute %zdsecond", self.day, self.hour, self.minute, self.second];
}
@end

@implementation NSDate (Extension)

-(YYDateItem *)yy_timeIntervalSinceDate:(NSDate *)anotherDate{
    YYDateItem *item = [[YYDateItem alloc] init];
    NSTimeInterval interval = [self timeIntervalSinceDate:anotherDate];

    // 相差多少天
    int intInterval = (int)interval;
    int secondPerDay = 3600 * 24;
    item.day = intInterval / secondPerDay;
    
    int secondPerHour = 3600;
    item.hour = (intInterval % secondPerDay) / secondPerHour;
    int secondPerMin = 60;
    item.minute = ((intInterval % secondPerDay) % secondPerHour) / secondPerMin;

    item.second =((intInterval % secondPerDay) % secondPerHour) % secondPerMin;
    
    return item;
}

-(BOOL)yy_isToday{
   
    NSCalendar *calendar = [NSCalendar yy_calender];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear |NSCalendarUnitMonth;
    NSDateComponents *curComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
//    return selfComponents.year == curComponents.year && selfComponents.month == curComponents.month &&
//    selfComponents.day == curComponents.day;
    return [curComponents isEqual:selfComponents];
}

-(BOOL)yy_isYesterday{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    NSString *selfDateStr = [formatter stringFromDate:self];
    
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *selfDate = [formatter dateFromString:selfDateStr];
    
    NSCalendar *calendar = [NSCalendar yy_calender];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear |NSCalendarUnitMonth;
    NSDateComponents *intervalComponents = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return intervalComponents.year == 0 && intervalComponents.month == 0 &&intervalComponents.day == 1;
}

-(BOOL)yy_isTomorrow{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    NSString *selfDateStr = [formatter stringFromDate:self];
    
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *selfDate = [formatter dateFromString:selfDateStr];
    
    NSCalendar *calendar = [NSCalendar yy_calender];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear |NSCalendarUnitMonth;
    NSDateComponents *intervalComponents = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return intervalComponents.year == 0 && intervalComponents.month == 0 &&intervalComponents.day == -1;
}

-(BOOL)yy_isThisYear{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    NSString *selfDateStr = [formatter stringFromDate:self];
    
//    NSDate *nowDate = [formatter dateFromString:nowDateStr];
//    NSDate *selfDate = [formatter dateFromString:selfDateStr];
//    
//    NSCalendar *calendar = [NSCalendar yy_calender];
//    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitYear |NSCalendarUnitMonth;
//    NSDateComponents *intervalComponents = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
//    return intervalComponents.year == 0 ;
    
    return [selfDateStr isEqualToString:nowDateStr];
    
//    NSCalendar *calendar = [NSCalendar xmg_calendar];
//    
//    NSInteger selfYear = [calendar components:NSCalendarUnitYear fromDate:self].year;
//    NSInteger nowYear = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]].year;
//    
//    return selfYear == nowYear;
}
@end
