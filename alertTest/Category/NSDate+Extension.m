//
//  NSDate+Extension.m
//  SomeFunction
//
//  Created by 李震 on 16/8/2.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSString *)ff_dateDescription{
    
    //获取当前日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    //判断是否是今天
    if ([calendar isDateInToday:self]) {
        NSInteger interval = (NSInteger)[self timeIntervalSinceNow];
        
        if (interval < 60) {
            return @"刚刚";
        }
        
        interval /= 60;
        if (interval < 60) {
            return [NSString stringWithFormat:@"%ld分钟前",(long)interval];
        }
        return [NSString stringWithFormat:@"%ld小时前",interval / 60];
        
    }
    //昨天
    NSMutableString *formatString = [NSMutableString stringWithString:@" HH:mm"];
    if ([calendar isDateInYesterday:self]) {
        [formatString insertString:@"昨天" atIndex:0];
    } else {
        [formatString insertString:@"MM-dd" atIndex:0];
        
        //是否当年
        NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:0];
        
        if (components.year != 0) {
            [formatString insertString:@"yyyy-" atIndex:0];
        }
    }
    //转换格式字符串
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    fmt.dateFormat = formatString;
    
    return [fmt stringFromDate:self];
    
    
}

- (NSString *)ff_dateDescription2{
    //获取当前日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //转换格式字符串
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    NSMutableString * formatString = [NSMutableString stringWithString:@"HH:mm"];
    //判断是否是今天
    if ([calendar isDateInToday:self]) {
        fmt.dateFormat = formatString;
        return [fmt stringFromDate:self];
    }
    
    //获取距离当前多少时间
    NSInteger interval = (NSInteger)[self timeIntervalSinceNow];
    interval = interval / 60 /60 / 24;
    
    //昨天
    if ([calendar isDateInYesterday:self]) {
        [formatString insertString:@"昨天" atIndex:0];
    }else if (interval < 7){
        NSArray * weekdayArr = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
        [fmt setShortWeekdaySymbols:weekdayArr];
    
        [formatString insertString:@"eee" atIndex:0];
    }else{
        [formatString insertString:@"MM-dd" atIndex:0];
        [formatString insertString:@"yyyy-" atIndex:0];
    }
    fmt.dateFormat = formatString;
    return [fmt stringFromDate:self];
}

- (NSDate * )dateWithYMD{
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString * selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

- (BOOL)isToday{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    //获得当前时间的年月日
    NSDateComponents * nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //获取self的年月日
    NSDateComponents * selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

- (BOOL)isYesterday{
    NSDate * nowDate = [[NSDate date] dateWithYMD];
    
    NSDate * selfDate = [self dateWithYMD];
    
    //获得nowDate 和selfDate的差距
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (BOOL)isThisYear{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    //获取当前时间的年月日
    NSDateComponents * nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //获取self的年月日
    NSDateComponents * selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
    
}

- (NSDateComponents * )deltaWithNow{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSDateComponents *)deltaFrom:(NSDate *)from{
    //日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitSecond | NSCalendarUnitMinute;
    return [calendar components:unit fromDate:from toDate:self options:0];
}




















@end
