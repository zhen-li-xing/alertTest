//
//  NSString+Extension.m
//  SomeFunction
//
//  Created by 李震 on 16/8/5.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL) isValidateMobile {
    //手机号以13, 15, 17, 18,14开头，八个 \d 数字字符
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate * regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [regextestmobile evaluateWithObject:self];
}

- (BOOL)validatePassWord{
//    NSString * pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,25}";
    NSString * pattern = @"(?![a-zA-z!@#$%^&*]+$)(?![0-9!@#$%^&*]+$)[a-zA-Z0-9!@#$%^&*]{6,25}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateIdentityCard{
    BOOL flag;
    if (self.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:self];
    
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(self.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
}

- (BOOL)validateContainsSpace {
    return [self rangeOfString:@" "].location == NSNotFound;
}

- (NSString *)ageFromBirthday {
    if (self.length != 10 ||
        [self characterAtIndex:4] != '.' ||
        [self characterAtIndex:7] != '.') {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    NSString *selfYear = [self substringToIndex:4];
    NSString *nowYear = [today substringToIndex:4];
    NSInteger age = nowYear.integerValue - selfYear.integerValue;
    
    NSString *selfDate = [self substringFromIndex:5];
    NSString *nowDate = [today substringFromIndex:5];
    if ([nowDate compare:selfDate] < 0) {
        age = age - 1;
    }
    
    if (age < 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%ld", (long)age];
}

- (NSString *)ageFromIDCard {
    NSString *birthday = [self birthdayFromIDCard];
    
    return [birthday ageFromBirthday];
}

- (NSString*)birthdayFromIDCard {
    NSString *result = @"未知";
    if (self.length == 15) {
        NSMutableString *birthString = [[self substringWithRange:NSMakeRange(6, 6)] mutableCopy];
        [birthString insertString:@"19" atIndex:0];
        [birthString insertString:@"." atIndex:4];
        [birthString insertString:@"." atIndex:7];
        result = birthString;
    } else if (self.length == 18) {
        NSMutableString *birthString = [[self substringWithRange:NSMakeRange(6, 8)] mutableCopy];
        [birthString insertString:@"." atIndex:4];
        [birthString insertString:@"." atIndex:7];
        result = birthString;
    }
    
    return result;
}

- (NSString*)sexFromIDCard {
    NSString *sexString = @"";
    
    if (self.length == 15) {
        sexString =  [[self substringWithRange:NSMakeRange(14, 1)] mutableCopy];
    } else if (self.length == 18) {
        sexString = [[self substringWithRange:NSMakeRange(16, 1)] mutableCopy];
    } else {
        return @"";
    }
    
    char c = [sexString UTF8String][0];
    if (c < '0' || c > '9') {
        return @"";
    }
    int x = sexString.intValue;
    if (x < 0 || sexString.length == 0) {
        return @"";
    }
    if (x % 2 == 0) {
        return @"女";
    } else {
        return @"男";
    }
    return sexString;
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (NSString *)stringWithMoneyAmount:(double)amount {
    BOOL minus = amount < 0;
    if (minus) {
        amount = -amount;
    }
    NSMutableString *toString = [NSMutableString string];
    long round = floor(amount);
    int fraction = floor((amount - round + 0.005) * 100.0);
    NSString *fractionString = [NSString stringWithFormat:@".%02d", fraction];
    
    do {
        int thousand = round % 1000;
        if (round < 1000) {
            [toString insertString:[NSString stringWithFormat:@"%d", thousand] atIndex:0];
        } else {
            [toString insertString:[NSString stringWithFormat:@",%03d", thousand] atIndex:0];
        }
        round = round / 1000;
    } while (round);
    [toString appendString:fractionString];
    if (minus) {
        [toString insertString:@"-" atIndex:0];
    }
    return toString;
}

+ (NSString *)stringWithMoneyAmountInChinese:(double)amount {
    if (amount < 10000) {
        return [NSString stringWithFormat:@"%g", amount];
    } else {
        // 在百位四舍五入，比如12356变成124
        amount = round(amount / 100.0);
        amount = amount / 100;
        return [NSString stringWithFormat:@"%g万", amount];
    }
}

+ (NSString *)stringIntervalFrom:(NSDate *)start to:(NSDate *)end {
    NSInteger interval = end.timeIntervalSince1970 - start.timeIntervalSince1970;
    if (interval <= 0) {
        return @"刚刚";
    }
    
    if (interval < 60) {
        return [NSString stringWithFormat:@"%zd 秒前", interval];
    }
    
    interval = interval / 60;
    if (interval < 60) {
        return [NSString stringWithFormat:@"%zd 分钟前", interval];
    }
    
    interval = interval / 60;
    if (interval < 24) {
        return [NSString stringWithFormat:@"%zd 小时前", interval];
    }
    
    interval = interval / 24;
    if (interval < 7) {
        return [NSString stringWithFormat:@"%zd 天前", interval];
    }
    
    if (interval < 30) {
        return [NSString stringWithFormat:@"%zd 周前", interval / 7];
    }
    
    if (interval < 365) {
        return [NSString stringWithFormat:@"%zd 个月前", interval / 30];
    }
    return [NSString stringWithFormat:@"%zd 年前", interval / 365];
}
//邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isEmptyString {
    return self.length == 0 || [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}

- (NSString *)hideInformation {
    static const NSInteger kVisibleLength = 4;
    if (self.length <= kVisibleLength) {
        return self;
    }
    NSInteger length = self.length - kVisibleLength * 2;
    NSMutableString *result = [self mutableCopy];
    for (NSInteger i = 0; i < length; i++) {
        [result replaceCharactersInRange:NSMakeRange(i + kVisibleLength, 1) withString:@"*"];
    }
    return result;
}

- (long long)fileSize
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:self error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            totalSize += [fullSubpath fileSize];
        }
        return totalSize;
    } else { // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:self error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

//汉字的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [[str stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

//获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string{
    if (string.length == 0) {
        return @"#";
    }
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}
//将字符串数组按照元素首字母顺序进行排序分组
+ (NSMutableArray *)dictionaryOrderByCharacterWithOriginalArray:(NSArray *)array{
    if (array.count == 0) {
        return nil;
    }
    for (id obj in array) {
        if (![obj isKindOfClass:[NSString class]]) {
            return nil;
        }
    }
    UILocalizedIndexedCollation * indexedCollation = [UILocalizedIndexedCollation currentCollation];
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:indexedCollation.sectionTitles.count];
    //创建27个分组数组
    for (int i = 0; i < indexedCollation.sectionTitles.count; i++) {
        NSMutableArray *obj = [NSMutableArray array];
        [objects addObject:obj];
    }
    //按字母顺序进行分组
    
    for (int i = 0; i < array.count; i++) {
        NSInteger index = [indexedCollation sectionForObject:array[i] collationStringSelector:@selector(uppercaseString)];
        [[objects objectAtIndex:index] addObject:array[i]];
       
    }
    //去掉空数组
    for (int i = 0; i < objects.count; i++) {
        NSMutableArray *obj = objects[i];
        if (obj.count == 0) {
            [objects removeObject:obj];
        }
    }
    return objects;
    
}
//获取索引字母
+ (NSMutableArray *)getReferenceCharWithArr:(NSMutableArray *)array{
//    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:objects.count];
    NSMutableArray * keys = [NSMutableArray array];
    for (NSMutableArray *obj in array) {
        NSString *str = obj[0];
        NSString *key = [self firstCharacterWithString:str];
        [keys addObject:key];
    }
    NSString * str = [keys lastObject];
    unichar c=[str characterAtIndex:0];
    if ((c<'A'||c>'Z')&&(c<'a'||c>'z')) {
        [keys removeLastObject];
        [keys addObject:@"#"];
    }
    
    return keys;
}

//判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

//判断字符串是否全部为数字
+ (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

//压缩图片到指定文件大小
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length/1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}

+ (NSString*)JSONWithSomeThing:(id)data{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSLog(@"1296035591  = %@",confromTimesp);
    
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    
    return confromTimespStr;
}

+ (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return [NSString stringWithFormat:@"%zd",timeSp];
    
}

+ (NSString *)formatterDateExchange:(NSString *)dateStr
{
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.locale = [NSLocale currentLocale];
    dateFmt.dateFormat = @"yyyy年MM月dd日";
    NSDate *date = [dateFmt dateFromString:dateStr];
    dateFmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    return [dateFmt stringFromDate:date];
}

@end
