//
//  NSString+Extension.h
//  SomeFunction
//
//  Created by 李震 on 16/8/5.
//  Copyright © 2016年 lizhen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Extension)

//手机验证
- (BOOL)isValidateMobile;

//密码验证（必须包含数字和字母 6 -- 25位）
- (BOOL)validatePassWord;

//身份证验证
- (BOOL)validateIdentityCard;

//判断字段是否包含空格
- (BOOL)validateContainsSpace;

//根据生日返回年龄
- (NSString *)ageFromBirthday;

//根据身份证返回岁数
- (NSString *)ageFromIDCard;

//根据身份证返回生日
- (NSString *)birthdayFromIDCard;

//根据身份证返回性别
- (NSString *)sexFromIDCard;

//正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  将数字转换成英文计数的方式
 */
+ (NSString *)stringWithMoneyAmount:(double)amount;

/**
 *  将数字转换成xx万
 */
+ (NSString *)stringWithMoneyAmountInChinese:(double)amount;

+ (NSString *)stringIntervalFrom:(NSDate *)start to:(NSDate *)end;

//邮箱
+ (BOOL)validateEmail:(NSString *)email;

- (BOOL)isEmptyString;

// 隐藏信息
- (NSString *)hideInformation;

//判断文件大小
- (long long)fileSize;

//汉字的拼音
- (NSString *)pinyin;

//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string;
//将字符串数组按照元素首字母顺序进行排序分组
+ (NSMutableArray *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array;
//获取索引字母
+ (NSMutableArray *)getReferenceCharWithArr:(NSMutableArray *)array;

//判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string;

//判断字符串是否全部为数字
+ (BOOL)isAllNum:(NSString *)string;

//压缩图片到指定文件大小
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

/** 将数据转换为json格式 */
+ (NSString*)JSONWithSomeThing:(id)data;

/** 时间戳转换为时间 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
/** 时间戳转生日 */
+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
/** 将某个时间转换成时间戳 */
+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
/** 将yyyy年MM月dd日转 yyyy-MM-dd hh:mm:ss*/
+ (NSString *)formatterDateExchange:(NSString *)dateStr;
@end
