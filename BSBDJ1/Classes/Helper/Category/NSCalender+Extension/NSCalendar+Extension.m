//
//  NSCalendar+Extension.m
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import "NSCalendar+Extension.h"

@implementation NSCalendar (Extension)

+ (instancetype)yy_calender{
    // iOS8
    if ([NSCalendar instancesRespondToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }
}
@end
