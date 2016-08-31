//
//  NSDate+Extension.h
//  BSBDJ1
//
//  Created by Yesi on 16/8/24.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDateItem : NSObject

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;

@end

@interface NSDate (Extension)


-(YYDateItem *)yy_timeIntervalSinceDate:(NSDate *)anotherDate;

-(BOOL)yy_isToday;

-(BOOL)yy_isYesterday;

-(BOOL)yy_isTomorrow;

-(BOOL)yy_isThisYear;

@end
