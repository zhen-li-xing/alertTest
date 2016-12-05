//
//  NSDate+Extension.h
//  SomeFunction
//
//  Created by 李震 on 16/8/2.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  日期描述
 */
@interface NSDate (Extension)

/**
 *  刚刚;
 *  ?分钟前;
 *  ?小时前;
 *  昨天 HH:mm;
 *  MM-dd HH:mm
 * yyyy-MM-dd HH:mm
 */
- (NSString *)ff_dateDescription;

/**
 *  HH:mm
 *  昨天 HH:mm;
 *  MM-dd HH:mm
 * yyyy-MM-dd HH:mm
 */
- (NSString *)ff_dateDescription2;


/**
 *  是否为今天
 *
 *  @return YES & NO
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 *
 *  @return YES & NO
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 *
 *  @return YES & NO
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 *
 *  @return NSDate
 */
- (NSDate *)dateWithYMD;

/**
 *  返回与当前时间的差距
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *)deltaWithNow;

/**
 *  比较from和self的时间
 *
 *  @param from NSDate
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;


@end
