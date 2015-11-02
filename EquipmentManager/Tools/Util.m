//
//  Util.m
//  Topka2.0
//
//  Created by wangdongdong on 13-1-23.
//  Copyright (c) 2013年 Topka. All rights reserved.
//

#import "Util.h"
#import <commoncrypto/CommonDigest.h>
#import "zlib.h"
#import "Constants.h"
#import <CommonCrypto/CommonCryptor.h>
#import "EGOCache.h"
#import "SDImageCache.h"

@implementation NSData (CRC32)

/**
 * 计算crc32校验值
 * @参数 无
 * @返回值 crc32校验值
 **/
- (uint32_t)crc32Value
{
    uLong crc = crc32(0L, Z_NULL, 0);
    crc = crc32(crc, [self bytes], [self length]);
    
    return crc;
}

@end

static NSDateFormatter *_DateFormatter = nil;

@interface Util ()

+ (NSString *)md5:(NSString *)str;
+ (NSString *)sha1:(NSString *)str;

@end

@implementation Util

/**
 * 计算混合字符串的长度。汉字为一个单位长度，字母和数字为半个单位长度，不取整。
 * @参数 无
 * @返回值 长度
 **/
+ (float)calculateTextLength:(NSString *)textA
{
    float number = 0.0;
    int index = 0;
    for(; index < textA.length; index++) {
        NSString *character = [textA substringWithRange:NSMakeRange(index, 1)];
        if([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] != 1) {
            number++;
        } else {
            number = number + 0.5;
        }
    }
    
    return number;
}

/**
 * 计算混合字符串的长度。汉字为一个单位长度，字母和数字为半个单位长度，向上取整。
 * @参数 无
 * @返回值 长度
 **/
+ (int)calculateTextNumber:(NSString *)textA
{
    float number = 0.0;
    int index = 0;
    for(; index < textA.length; index++) {
        NSString *character = [textA substringWithRange:NSMakeRange(index, 1)];
        if([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] != 1) {
            number++;
        } else {
            number = number + 0.5;
        }
    }
    
    return ceil(number);
}

/**
 * 截取表情混合字符串为指定的长度并返回。汉字为一个单位长度，字母和数字为半个单位长度。
 * @参数 字符串，截取长度
 * @返回值 截取后的字符串
 **/
+ (NSString *)cutText:(NSString *)textA toLength:(int)length
{
    float number = 0.0;
    int index = 0;
    for(; index < textA.length; index++) {
        NSString *character = [textA substringWithRange:NSMakeRange(index, 1)];
        if([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] != 1) {
            number++;
        } else {
            number = number + 0.5;
        }
        
        if(number > length)
            break;
    }
    
    return [textA substringToIndex:index];
}

/**
 * 缩短昵称以适合导航栏标题
 * @参数 无
 * @返回值 截取后的字符串，含"..."
 **/
+ (NSString *)shortenNicknameForTitle:(NSString *)nickname
{
    if(!nickname) {
        return @"他";
    }
    
    NSString *tail = @"";
    float number = 0.0;
    int index = 0;
    for(; index < nickname.length; index++) {
        NSString *character = [nickname substringWithRange:NSMakeRange(index, 1)];
        if([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] != 1) {
            number++;
        } else {
            number = number + 0.5;
        }
        
        if(number > 7.0) {
            tail = @"...";
            break;
        }
    }
    
    return [NSString stringWithFormat:@"%@%@", [nickname substringToIndex:index], tail];
}

+ (NSString *)doubleFormatAmount:(int)number
{
    //数字加千位分隔符
    NSNumber *aNumber = [NSNumber numberWithFloat:number];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:aNumber];
    //    NSLog(@"formattedNumberString:%@", formattedNumberString);
    
    return formattedNumberString;
}

/**
 * 取得请求内容加密的校验值。
 * @参数 内容字符串
 * @返回值 校验值
 **/
+ (NSString *)getSign:(NSString *)str
{
    NSString *string = [NSString stringWithString:str];
    NSData *data1 = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *ret = [NSString stringWithFormat:@"%@%08x", [Util md5:string], [data1 crc32Value]];
    ret = [NSString stringWithFormat:@"%@%@", ret, ENCRYPT_SALT];
    ret = [Util sha1:ret];
    ret = [NSString stringWithFormat:@"%@%08x", [Util md5:ret], [data1 crc32Value]];
    
    return ret;
}
+ (NSString *) encryptSMSUseDES:(NSString *)plainText
{
    Byte iv[] = {1,2,3,4,5,6,7,8};
    
    NSMutableString *ciphertext = [[NSMutableString alloc] init];
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [ENCRYPT_SMS UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        for (int i=0; i<numBytesEncrypted; i++) {
            if (buffer[i] > 15) {
                [ciphertext appendString:[NSString stringWithFormat:@"%x", buffer[i]&0xff]];
            }else{
                [ciphertext appendString:[NSString stringWithFormat:@"0%x", buffer[i]&0xff]];
            }
        }
    }
    
    return ciphertext;
}
+ (NSString *) encryptUseDES:(NSString *)plainText
{
    Byte iv[] = {1,2,3,4,5,6,7,8};
    
    NSMutableString *ciphertext = [[NSMutableString alloc] init];
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [ENCRYPT_LOGIN UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        for (int i=0; i<numBytesEncrypted; i++) {
            if (buffer[i] > 15) {
                [ciphertext appendString:[NSString stringWithFormat:@"%x", buffer[i]&0xff]];
            }else{
                [ciphertext appendString:[NSString stringWithFormat:@"0%x", buffer[i]&0xff]];
            }
        }
    }

    return ciphertext;
}

/**
 * 计算字符串的md5加密值。
 * @参数 字符串
 * @返回值 md5加密值
 **/
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *hash = [NSMutableString string];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

/**
 * 计算字符串的sha1安全哈希算法值。
 * @参数 字符串
 * @返回值 sha1安全哈希算法值
 **/
+ (NSString *)sha1:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    uint8_t result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, result);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", result[i]];
    
    return output;
}

/**
 * 取得从Unix纪元（格林威治时间1970年1月1日00:00:00）到当前时间的秒数。
 * @参数 无
 * @返回值 秒数
 **/
+ (NSTimeInterval)apitime
{
    return [[NSDate date] timeIntervalSince1970];
}
/**
 * 取得时间。
 type = 0 yyyy-mm-dd hh:mm
 type = 1 yyyy年-mm月-dd日
 **/
+ (NSString *)getTheTimeStampInSeconds{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString* timeString = [NSString stringWithFormat:@"%.0f", a]; //转为字符型
    return timeString;
}
+ (NSString *)stringWithTimeLastactivityInterval:(double)time Type:(int)type
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (type == 0) {
       [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else if (type == 1){
        [formatter setDateFormat:@"yyyy年MM月dd日"];
    }else if (type == 2){
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (type == 3){
         [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];
    
    
    return [formatter stringFromDate:date];
}

/**
 * 取得RANDOM_MIN～RANDOM_MAX之间的随机数。
 * @参数 无
 * @返回值 随机数
 **/
+ (int)rand
{
    srandom(time(NULL));
    
    return ((RANDOM_MIN) + random() % ((RANDOM_MAX + 1) - (RANDOM_MIN)));
}

/**
 * 将要发送的字符串进行URL编码。
 * @参数 内容字符串、编码格式（一般为NSUTF8StringEncoding）
 * @返回值 编码后的字符串
 **/
+ (NSString *)URLEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@";", @"/", @"?", @":", @"@", @"&", @"=", @"+", @"$", @",", @"!", @"'", @"(", @")", @"*", nil];
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B", @"%2F", @"%3F", @"%3A", @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C", @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    int len = [escapeChars count];
    NSMutableString *temp = [[originalString stringByAddingPercentEscapesUsingEncoding:stringEncoding] mutableCopy];

    for(int i = 0; i < len; i++) {
        // 替换所有出现一个在给定范围内与另一给定的字符串的字符串，返回替换的数量
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i] withString:[replaceChars objectAtIndex:i] options:NSLiteralSearch range:NSMakeRange(0, [temp length])];
    }
    NSString *outStr = [NSString stringWithString:temp];
    
    return outStr;
}

/**
 * 判断字符串是否为nil
 * @参数 字符串
 * @返回值 如果为nil、返回一个空字串符, 否则返回原字符串
 */
+ (NSString *)checkEmpty:(NSString *)str
{
    if (nil != str) {
        return str;
    } else {
        return @"";
    }
}

/**
 * 判断字符串是否为nil
 * @参数 params数据字典 key字符串
 * @返回值 value字符串
 */
+ (NSString *)getKey:(NSMutableDictionary *)params forKey:(NSString *)key {
    //通过KEY找到value
    NSString *object = [params objectForKey:key];

    return object;
}

/**
 * 格式化日期字符串
 * @参数 时间戳
 * @返回值 日期字符串
 **/
+ (NSString *)ConfromTimes:(NSString *)createTime
{
//    static NSDateFormatter *dateFormatter = nil;
//    if(nil == dateFormatter) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"HH:mm:ss"];
//    }
//    
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
//    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
//    
//    return confromTimespStr;
    
    NSString* timeStr = nil;
    int hour = 0;
    int minute = 0;
    int second = 0;
    if (createTime.intValue <= 0)
        return @"00:00:00";
    else {
        minute = (int) (createTime.intValue / 60);
        if (minute < 60) {
            second = (int) (createTime.intValue % 60);
            timeStr = [NSString stringWithFormat:@"00:%@:%@",[Util unitFormat:minute],[Util unitFormat:second]];
        } else {
            hour = minute / 60;
            if (hour > 99)
                return @"99:59:59";
            minute = minute % 60;
            second = (int) (createTime.intValue - hour * 3600 - minute * 60);
            timeStr = [NSString stringWithFormat:@"%@:%@:%@",[Util unitFormat:hour],[Util unitFormat:minute],[Util unitFormat:second]];
        }
    }
    return timeStr;
}

/**
 * 格式化日期字符串，以分秒来分隔
 * @参数 时间戳
 * @返回值 日期字符串
 **/
+ (NSString *)ConfromTimes2:(NSString *)createTime
{
    NSString* timeStr = nil;
    int hour = 0;
    int minute = 0;
    int second = 0;
    if (createTime.intValue <= 0)
        return @"00时00分00秒";
    else {
        minute = (int) (createTime.intValue / 60);
        if (minute < 60) {
            second = (int) (createTime.intValue % 60);
            timeStr = [NSString stringWithFormat:@"00时%@分%@秒",[Util unitFormat:minute],[Util unitFormat:second]];
        } else {
            hour = minute / 60;
            if (hour > 99)
                return @"99时59分59秒";
            minute = minute % 60;
            second = (int) (createTime.intValue - hour * 3600 - minute * 60);
            timeStr = [NSString stringWithFormat:@"%@时%@分%@秒",[Util unitFormat:hour],[Util unitFormat:minute],[Util unitFormat:second]];
        }
    }
    return timeStr;
}

+ (NSString *)unitFormat:(int)i
{
    NSString* retStr = nil;
    if (i >= 0 && i < 10){
        retStr = [NSString stringWithFormat:@"0%i",i];
    }else{
        retStr = [NSString stringWithFormat:@"%i",i];
    }
    return retStr;
}

/**
 * 格式化日期字符串
 * @参数 时间戳
 * @返回值 日期字符串
 **/
+ (NSString *)timestamp:(NSString *)createTime
{
//    NSString *_timestamp;
//
//    static NSDateFormatter *dateFormatter = nil;
//    if(nil == dateFormatter) {
//        dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
//    }
//
//    time_t now;
//    time(&now);
//
//    int distance = (int)difftime(now, [createTime intValue]);
//    if(distance < 0)
//        distance = 0;
//
//    if(distance < 60 * 10) {
////        _timestamp = [NSString stringWithFormat:@"%d%@", 1, @"分钟前"];
//        _timestamp = @"刚刚";
//    } else if(distance < 60 * 60) {
//        distance = distance / 60;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
//    } else if(distance < 60 * 60 * 24) {
//        distance = distance / 60 / 60;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"小时前"];
//    } else if(distance < 60 * 60 * 24 * 7) {
//        distance = distance / 60 / 60 / 24;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"天前"];
//    } else if(distance < 60 * 60 * 24 * 7 * 4) {
//        distance = distance / 60 / 60 / 24 / 7;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"周前"];
//    } else if(distance < 60 * 60 * 24 * 7 * 4 * 12) {
//        distance = distance / 60 / 60 / 24 / 7 / 4;
//        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"月前"];
//    } else {
//        distance = distance / 60 / 60 / 24 / 7 / 4 / 12;
//        _timestamp = [NSString stringWithFormat:@"%@", @"很久以前"];
//
//    }
//    return _timestamp;
    
    NSString *_timestamp;
    
    static int secondsOfDay = 86400;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:[createTime integerValue]];
    NSTimeInterval createTimeInterval = [createDate timeIntervalSince1970];
    NSDateComponents *createComps = [calendar components:unitFlags fromDate:createDate];
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTimeInterval = [nowDate timeIntervalSince1970];
    NSDateComponents *nowComps = [calendar components:unitFlags fromDate:nowDate];
    long zeroToday = (long)(nowTimeInterval - ([nowComps hour] * 60 * 60 + [nowComps minute] * 60 + [nowComps second]));
    long zeroYesterday = zeroToday - secondsOfDay;
//    long zeroBefore = zeroToday - secondsOfDay * 2;
//    long zeroMonthAgo = zeroToday - secondsOfDay * 30;
//    long zeroCreateTime = (long)(createTimeInterval - ([createComps hour] * 60 * 60 + [createComps minute] * 60 + [createComps second]));
    
    if(createTimeInterval >= zeroToday) {
        // 今天
        
        long distance = (long)[nowDate timeIntervalSinceDate:createDate];
        if(distance <= 60 * 10) {
            _timestamp = @"刚刚";
        } else {
            _timestamp = [NSString stringWithFormat:@"%02d:%02d", [createComps hour], [createComps minute]];
        }
    } else if(createTimeInterval >= zeroYesterday) {
        // 昨天

        _timestamp = [NSString stringWithFormat:@"昨天 %02d:%02d", [createComps hour], [createComps minute]];
    }else{
        // 超过一个月
        
        if([createComps year] == [nowComps year]) {
            // 未跨年
            
            _timestamp = [NSString stringWithFormat:@"%02d-%02d %02d:%02d", [createComps month], [createComps day] ,[createComps hour], [createComps minute]];
        } else {
            // 跨年
            
            _timestamp = [NSString stringWithFormat:@"%04d-%02d-%02d", [createComps year], [createComps month], [createComps day]];
        }
    }
    
//    else if(createTimeInterval >= zeroBefore) {
//        // 前天
//        
//        _timestamp = [NSString stringWithFormat:@"前天 %02d:%02d", [createComps hour], [createComps minute]];
//    } else {
//        // 更早
//        
//        if(createTimeInterval >= zeroMonthAgo) {
//            // 一个月内
//            
//            long distance = (zeroToday - zeroCreateTime) / secondsOfDay;
//            _timestamp = [NSString stringWithFormat:@"%ld天前 %02d:%02d", distance, [createComps hour], [createComps minute]];
//        } else {
//            // 超过一个月
//            
//            if([createComps year] == [nowComps year]) {
//                // 未跨年
//                
//                int monthInterval = [nowComps month] - [createComps month];
//                if(monthInterval == 0) monthInterval = 1;
//                _timestamp = [NSString stringWithFormat:@"%d月前", monthInterval];
//            } else {
//                // 跨年
//                
//                _timestamp = [NSString stringWithFormat:@"%04d年%02d月%02d日", [createComps year], [createComps month], [createComps day]];
//            }
//        }
//    }
    
    return _timestamp;
}

/**
 * 将普通字符串格式化为逗号字符串样式
 **/

+ (NSString *)addCommaFunc:(NSString *)str
{
    NSRange ranget = [str rangeOfString:@","];
    if(ranget.location == NSNotFound && ranget.length == 0) {
        
        NSRange ranget = [str rangeOfString:@"."];
        if (ranget.location == NSNotFound && ranget.length == 0) {
            int count = 0;
            long long int a = str.longLongValue;
            while (a != 0){
                count++;
                a /= 10;
            }
            NSMutableString *string = [NSMutableString stringWithString:str];
            NSMutableString *newstring = [NSMutableString string];
            while (count > 3) {
                count -= 3;
                NSRange rang = NSMakeRange(string.length - 3, 3);
                NSString *str = [string substringWithRange:rang];
                [newstring insertString:str atIndex:0];
                [newstring insertString:@"," atIndex:0];
                [string deleteCharactersInRange:rang];
            }
            [newstring insertString:string atIndex:0];
            
            return newstring;
        }else{
            NSArray* arr = [str componentsSeparatedByString:@"."];
            if ([arr count] > 0) {
                NSString* strtemp = [arr objectAtIndex:0];
                int count = 0;
                long long int a = strtemp.longLongValue;
                while (a != 0){
                    count++;
                    a /= 10;
                }
                NSMutableString *string = [NSMutableString stringWithString:strtemp];
                NSMutableString *newstring = [NSMutableString string];
                while (count > 3) {
                    count -= 3;
                    NSRange rang = NSMakeRange(string.length - 3, 3);
                    NSString *str = [string substringWithRange:rang];
                    [newstring insertString:str atIndex:0];
                    [newstring insertString:@"," atIndex:0];
                    [string deleteCharactersInRange:rang];
                }
                [newstring insertString:string atIndex:0];
                [newstring appendFormat:@".00"];
                
                return newstring;
            }else{
                return str;
            }
        }
        
    }else{
        return str;
    }
}

/**
 * 将逗号字符串样式格式化为普通字符串
 **/
+ (NSString *)removeCommaFunc:(NSString*)str
{
    NSString* formatStr;
    
    NSRange ranget = [str rangeOfString:@","];
    if(ranget.location == NSNotFound && ranget.length == 0) {
        formatStr = str;
    }else{
        NSMutableString* astr = [[NSMutableString alloc] init];
        NSArray* arr = [str componentsSeparatedByString:@","];
        for (int i = 0; i < [arr count]; i ++) {
            [astr appendString:[arr objectAtIndex:i]];
        }
        formatStr = astr;
    }
    
    return formatStr;
}

/**
 * 验证邮箱是否有效
 * @参数 email：邮箱
 * @返回值 检查结果
 **/
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"^[\\.\\-\\_\\+0-9a-zA-Z]{2,}@([a-zA-Z0-9\\-\\_]+\\.)+[a-zA-Z]{2,}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

/**
 * 验证昵称是否有效
 * @参数 nick：昵称
 * @返回值 检查结果
 **/
+ (BOOL)validateNick:(NSString *)nick
{
    NSString *nickRegex = @"^(([\\x{4e00}-\\x{9fa5}]|[\\x{e7c7}-\\x{e7f3}]|[a-zA-Z0-9_])*)$";
    NSPredicate *nickTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickRegex];
    
    return [nickTest evaluateWithObject:nick];
}

/**
 * 检查输入电话号 13 14 15 18开头
 * @参数 电话号
 * @返回值 检查结果
 **/
+ (BOOL)checkIphone:(NSString *)phoneNo
{
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^1[3458][0-9]{9}$"];
    BOOL matched = [pred evaluateWithObject:phoneNo];
    
    return matched;
}

/**
 * 字符串转换为日期
 * 参数 string：字符串
 * @返回值 日期
 **/
+ (NSDate *)dateFromString:(NSString *)string
{
    if(!_DateFormatter) {
        _DateFormatter = [[NSDateFormatter alloc] init];
        [_DateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSDate *date = [_DateFormatter dateFromString:string];
    return date;
}

/**
 * 日期转换为字符串
 * 参数 date：日期
 * @返回值 字符串
 **/
+ (NSString *)stringFromDate:(NSDate *)date
{
    if(!_DateFormatter) {
        _DateFormatter = [[NSDateFormatter alloc] init];
        [_DateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    NSString *string = [_DateFormatter stringFromDate:date];
    return string;
}

+ (UIImage *)getImageFromView:(UIView *)view
{
    //把 UIView 转换成图片
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, view.layer.contentsScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)scaleImage:(UIImage *)image scaleFactor:(float)scaleBy
{
    CGSize size = CGSizeMake(image.size.width * scaleBy, image.size.height * scaleBy);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformScale(transform, scaleBy, scaleBy);
    CGContextConcatCTM(context, transform);

    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}
+(int) getNaviStatusHeight{
    
    static int iheight = 0;
    
    //一个用于调度一次函数的标识
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        int iversion = [[UIDevice currentDevice].systemVersion integerValue];
        if (iversion >= 7) {
            iheight = NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT;
        }
    });
    
    return iheight;
}
+(int) getNaviStatusHeightEx{
    static int iheight = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iheight = NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT;
    });
    
    return iheight;
}

+(int) isBigios7{
    BOOL isBigios7 = FALSE;
    int iversion = [[UIDevice currentDevice].systemVersion integerValue];
    if (iversion >= 7) {
        isBigios7 = TRUE;
    }
    
    return isBigios7;
}
+(void) setTopInset:(UIScrollView*) scroll topInsent:(float) topinsent
{
    scroll.contentInset = UIEdgeInsetsMake( topinsent, 0, 0, 0 );
    [scroll setScrollIndicatorInsets:UIEdgeInsetsMake( topinsent, 0, 0, 0 )];

}

+(BOOL) checkClassObjectEmpty:(id) data
{
    if ([data isKindOfClass:[NSString class]]) {
        if (![data isEqualToString:@""]) {
            return YES;
        }
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        if ([data count] > 0) {
            return YES;
        }
    } else if ([data isKindOfClass:[NSArray class]]) {
        if ([data count] > 0) {
            return YES;
        }
    }
    
    return NO;
}

+(int) getStatusBarHeight{
    
    static int iheight = STATUSBAR_HEIGHT;
    
    //一个用于调度一次函数的标识
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        int iversion = [[UIDevice currentDevice].systemVersion integerValue];
        if (iversion >= 7) {
            iheight = 0;
        }
    });
    
    return iheight;
}

+(int) getStatusBarHeightEx{
    
    static int iheight = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        int iversion = [[UIDevice currentDevice].systemVersion integerValue];
        if (iversion >= 7) {
            iheight = STATUSBAR_HEIGHT;
        }
    });
    
    return iheight;
}

+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [Util sizeOfString:string
                         font:font
            constrainedToSize:size
                lineBreakMode:NSLineBreakByTruncatingTail];
}

+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize expectedSize = CGSizeZero;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedSize = [string boundingRectWithSize:size
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                            context:nil].size;
    } else {
        expectedSize = [string sizeWithFont:font
                          constrainedToSize:size
                              lineBreakMode:lineBreakMode];
    }
    
    return CGSizeMake(ceil(expectedSize.width), ceil(expectedSize.height));
}

+ (CGSize) sizeOfString:(NSString*)string font:(CGFloat)fontSize maxWidth:(CGFloat)width
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize contentSize = CGSizeMake(width, 999);
    
    return [Util sizeOfString:string font:font constrainedToSize:contentSize lineBreakMode:NSLineBreakByWordWrapping];
}

+ (CGSize) sizeOfString:(NSString*)string font:(CGFloat)fontSize maxHeight:(CGFloat)height
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize contentSize = CGSizeMake(999, height);
    
    return [Util sizeOfString:string font:font constrainedToSize:contentSize lineBreakMode:NSLineBreakByWordWrapping];
}

+ (CGSize) sizeOfString:(UILabel*)label pattern:(int)pattern;
{
    CGSize contentSize;
    if (pattern == 0) {
        contentSize = CGSizeMake(label.frame.size.width, 999);
    }else{
        contentSize = CGSizeMake(999, label.frame.size.height);
    }
    
    return [Util sizeOfString:label.text font:label.font constrainedToSize:contentSize lineBreakMode:label.lineBreakMode];
}

@end

@implementation Util (File)

/**
 * 文档路径
 **/
+ (NSString *)DocumentPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return documentPath;
}

/**
 * 缓存路径
 **/
+ (NSString *)CachePath
{
    NSString *cachePath = [[Util DocumentPath] stringByAppendingPathComponent:@"Cache"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    return cachePath;
}

/**
 * 用户信息路径
 **/
+ (NSString *)UserInfoPath
{
    NSString *userInfoPath = [[Util CachePath] stringByAppendingPathComponent:@"UserInfo"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:userInfoPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:userInfoPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    return userInfoPath;
}

/**
 * 匿名信息路径
 **/
+ (NSString *)AnonymousInfoPath
{
    NSString *anonymousInfoPath = [[Util CachePath] stringByAppendingPathComponent:@"AnonymousInfo"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:anonymousInfoPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:anonymousInfoPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    return anonymousInfoPath;
}

/**
 * 其它路径
 **/
+ (NSString *)OtherPath
{
    NSString *otherPath = [[Util CachePath] stringByAppendingPathComponent:@"Other"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:otherPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:otherPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    
    return otherPath;
}

/**
 * 删除用户信息路径下的所有文件，“退出登录”时使用
 **/
+ (void)DeleteAllFilesAtUserInfoPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *userInfoPath = [Util UserInfoPath];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:userInfoPath error:nil];
    NSEnumerator *objectEnumerator = [contents objectEnumerator];
    NSString *fileName = nil;
    while((fileName = [objectEnumerator nextObject])) {
        [fileManager removeItemAtPath:[userInfoPath stringByAppendingPathComponent:fileName] error:nil];
    }
}

/**
 * 删除其它路径下的所有文件
 **/
+ (void)DeleteAllFilesAtOtherPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *otherfilePath = [Util OtherPath];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:otherfilePath error:nil];
    NSEnumerator *objectEnumerator = [contents objectEnumerator];
    NSString *fileName = nil;
    while((fileName = [objectEnumerator nextObject])) {
        [fileManager removeItemAtPath:[otherfilePath stringByAppendingPathComponent:fileName] error:nil];
    }
}

/**
 * 删除所有的缓存文件，“清除缓存”时使用
 **/
+ (void)DeleteAllCachedFiles
{
    [Util DeleteAllFilesAtOtherPath];
    [[EGOCache globalCache] clearCache];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

/**
 * 计算所有缓存文件大小
 **/
+ (double)CalculateSizeOfAllCachedFile
{
    NSString *otherPath = [Util OtherPath];
    double otherSize = [Util CalculateSizeOfFolder:otherPath] / 1024.0 / 1024.0;
    
    NSString *egoCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
	egoCachePath = [[egoCachePath stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"EGOCache"];
    double egoCacheSize = [Util CalculateSizeOfFolder:egoCachePath] / 1024.0 / 1024.0;
    
    NSString *sdWebCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
	sdWebCachePath = [sdWebCachePath stringByAppendingPathComponent:@"ImageCache"];
    double sdWebCacheSize = [Util CalculateSizeOfFolder:sdWebCachePath] / 1024.0 / 1024.0;
    
    return (otherSize + egoCacheSize + sdWebCacheSize);
}

/**
 * 计算指定路径下的文件夹大小
 **/
+ (unsigned long long)CalculateSizeOfFolder:(NSString *)folderPath
{
    unsigned long long folderSize = 0;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager subpathsAtPath:folderPath];
    NSEnumerator *enumerator = [contents objectEnumerator];
    NSString *filePath = nil;
    while(filePath = [enumerator nextObject]) {
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:filePath] error:nil];
        folderSize += [[attributes objectForKey:NSFileSize] unsignedLongLongValue];
    }
    
    return folderSize;
}

/**
 * 最近搜索路径
 **/
+ (NSString *)RecentSearchFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"recent_search"];
}

/**
 * 从文件中读取最近搜索信息
 **/
+ (NSMutableArray *)ReadRecentSearchFromFile
{
    NSString *filePath = [Util RecentSearchFilePath];

    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }

    return nil;
}

/**
 * 将最近搜索信息写入文件中
 **/
+ (void)WriteRecentSearchToFile:(NSMutableArray *)array
{
    if(array) {
        NSString *filePath = [Util RecentSearchFilePath];
        [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    }
}

/**
 * 热门品牌路径
 **/
+ (NSString *)HotBrandsFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"hot_brands"];
}

/**
 * 从文件中读取热门品牌信息
 **/
+ (NSArray *)ReadHotBrandsFromFile
{
    NSString *filePath = [Util HotBrandsFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    return nil;
}

/**
 * 将热门品牌信息写入文件中
 **/
+ (void)WriteHotBrandsToFile:(NSArray *)array
{
    if(array) {
        NSString *filePath = [Util HotBrandsFilePath];
        [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    }
}

/**
 * 用户信息文件路径
 * @参数 无
 * @返回值 用户信息文件路径
 **/
+ (NSString *)UserInfoFilePath
{
    return [[Util UserInfoPath] stringByAppendingPathComponent:@"user_info"];
}

/**
 * 匿名信息文件路径
 * @参数 无
 * @返回值 匿名信息文件路径
 **/
+ (NSString *)AnonymousInfoFilePath
{
    return [[Util AnonymousInfoPath] stringByAppendingPathComponent:@"anonymous_info"];
}
/**
 
 * 快速登录过的最新账号文件路径
 
 * @参数 无
 
 * @返回值 之前快速登录过的最新账号信息文件路径
 
 **/

+ (NSString *)QuickLoginInfoFilePath
{
    return [[Util AnonymousInfoPath] stringByAppendingPathComponent:@"quicklogin_info"];
}
//存储快速登录账户
+ (void)WriteNewQuickLoginWithAccount:(NSString *)account;{
    if (account) {
        [NSKeyedArchiver archiveRootObject:account toFile:[Util QuickLoginInfoFilePath]];
        }
}

+ (NSString *)readQuickLoginInfo{
    return (NSString *)[NSKeyedUnarchiver unarchiveObjectWithFile:[Util QuickLoginInfoFilePath]];
}
/**
 * 账号登录过的最新账号文件路径
 * @参数 无
 * @返回值 之前账号登录过的最新账号信息文件路径
 **/

+ (NSString *)LoginInfoFilePath{
    return [[Util AnonymousInfoPath] stringByAppendingPathComponent:@"login_info"];
}
//存储登录账户

+ (void)WriteNewLoginWithAccount:(NSString *)account;{
    if (account) {
        [NSKeyedArchiver archiveRootObject:account toFile:[Util LoginInfoFilePath]];
    }
}
+ (NSString *)readLoginInfo{
    return (NSString *)[NSKeyedUnarchiver unarchiveObjectWithFile:[Util LoginInfoFilePath]];
}



/**
 * 显示支付页面弹框文件路径
 * @参数 无
 * @返回值 是否会显示支付页面弹框信息文件路径
 **/
+ (NSString *)PayThePopupWindowFilePath
{
    return [[Util AnonymousInfoPath] stringByAppendingPathComponent:@"paypopWindow_info"];
}
//判断是否弹过支付页面的提示窗
+ (void)WritePayThePopupWindowWithFlag;{
    
    [NSKeyedArchiver archiveRootObject:@"YES" toFile:[Util PayThePopupWindowFilePath]];
    
}
/**
 * 通话记录文件路径
 * @参数 无
 * @返回值 通话记录文件路径
 **/
+ (NSString *)TelLogFilePath
{
    return [[Util UserInfoPath] stringByAppendingPathComponent:@"telog_info"];
}

/**
 * 举报文件路径
 * @参数 无
 * @返回值 举报文件路径
 **/
+ (NSString *)MyReportFilePath
{
    return [[Util UserInfoPath] stringByAppendingPathComponent:@"myreport_info"];
}

/**
 * 车型对比文件路径
 * @参数 无
 * @返回值 车型对比文件路径
 **/
+ (NSString *)CarDiffFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"cardiff_info"];
}

///**
// * 查询历史文件路径
// * @参数 无
// * @返回值 查询历史文件路径
// **/
//+ (NSString *)FindHistoryFilePath
//{
//    return [[Util OtherPath] stringByAppendingPathComponent:@"findhistory_info"];
//}

/**
 * 讨论列表文件路径
 * @参数 无
 * @返回值 讨论列表文件路径
 **/
+ (NSString *)DisscussionFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"discussion_info"];
}

/**
 * 讨论列表文件路径（与我相关）
 * @参数 无
 * @返回值 讨论列表文件路径（与我相关）
 **/
+ (NSString *)DisscussionAboutMeFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"discussionaboutme_info"];
}
/**
 * 返现记录路径（我的页面/购车金/返现记录）
 * @参数 无
 * @返回值 返现记录路径（我的页面/购车金/返现记录）
 **/
+ (NSString *)CashbackRecordFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"cashbackRecord_info"];
}

/**
 * 将用户信息写入文件中
 * @参数 用户信息对象
 * @返回值 无
 **/
+ (void)WriteUserInfoToFile:(UserInfo *)userInfo;
{
    if(userInfo) {
        NSString *filePath = [Util UserInfoFilePath];
        [NSKeyedArchiver archiveRootObject:userInfo toFile:filePath];
    }
}

/**
 * 从文件中读取用户信息
 * @参数 无
 * @返回值 用户信息对象
 **/
+ (UserInfo *)ReadUserInfoFromFile
{
    NSString *filePath = [Util UserInfoFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    return nil;
}

/**
 * 将匿名信息写入文件中
 * @参数 匿名信息对象
 * @返回值 无
 **/
+ (void)WriteAnonymousInfoToFile:(UserInfo *)userInfo
{
    if(userInfo) {
        NSString *filePath = [Util AnonymousInfoFilePath];
        [NSKeyedArchiver archiveRootObject:userInfo toFile:filePath];
    }
}

/**
 * 从文件中读取匿名信息
 * @参数 无
 * @返回值 匿名信息对象
 **/
+ (UserInfo *)ReadAnonymousInfoFromFile
{
    NSString *filePath = [Util AnonymousInfoFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return (UserInfo *)[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    return nil;
}

/**
 * 将通话记录写入文件中
 * @参数 通话记录数组对象
 * @返回值 无
 **/
+ (void)WriteTelLogToFile:(NSMutableArray *)Arr
{
    if(Arr) {
        NSString *filePath = [Util TelLogFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

/**
 * 从文件中读取通话记录信息
 * @参数 无
 * @返回值 通话记录数组
 **/
+ (NSMutableArray *)ReadTelLogFromFile
{
    NSString *filePath = [Util TelLogFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

/**
 * 将举报信息写入文件中
 * @参数 对象
 * @返回值 无
 **/
+ (void)WriteMyreportToFile:(NSMutableArray *)Arr
{
    if(Arr) {
        NSString *filePath = [Util MyReportFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}


/**文件中读取举报信息
 * @参数 无
 * @返回值 数组
 **/
+ (NSMutableArray *)ReadMyReportFromFile
{
    NSString *filePath = [Util MyReportFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

/**
 * 将车型对比信息写入文件中
 * @参数 对象
 * @返回值 无
 **/
+ (void)WriteCarDiffToFile:(NSMutableArray *)Arr
{
    if(Arr) {
        NSString *filePath = [Util CarDiffFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}


/**
 * 从文件中读取车型对比信息
 * @参数 无
 * @返回值 数组
 **/
+ (NSMutableArray *)ReadCarDiffFromFile
{
    NSString *filePath = [Util CarDiffFilePath];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }

    return nil;
}

///**
// * 将查询历史信息写入文件中
// * @参数 对象
// * @返回值 无
// **/
//+ (void)WriteFindHistoryToFile:(NSMutableArray *)Arr
//{
//    if(Arr) {
//        NSString *filePath = [Util FindHistoryFilePath];
//        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
//    }
//}


///**
// * 从文件中读取查询历史信息
// * @参数 无
// * @返回值 数组
// **/
//+ (NSMutableArray *)ReadFindHistoryFromFile
//{
//    NSString *filePath = [Util FindHistoryFilePath];
//
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
//    }
//
//    return nil;
//}


/**
 * 将讨论信息写入文件中
 * @参数 对象
 * @返回值 无
 **/
+ (void)WriteDisscussionToFile:(NSMutableArray *)Arr
{
    if(Arr) {
        NSString *filePath = [Util DisscussionFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}


/**
 * 从文件中读取讨论信息
 * @参数 无
 * @返回值 数组
 **/
+ (NSMutableArray *)ReadDisscussionFromFile
{
    NSString *filePath = [Util DisscussionFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

/**
 * 将讨论信息（与我相关）写入文件中
 * @参数 对象
 * @返回值 无
 **/
+ (void)WriteDisscussionAboutMeToFile:(NSMutableArray *)Arr
{
    if(Arr) {
        NSString *filePath = [Util DisscussionAboutMeFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}


/**
 * 从文件中读取讨论信息（与我相关）
 * @参数 无
 * @返回值 数组
 **/
+ (NSMutableArray *)ReadDisscussionAboutMeFromFile
{
    NSString *filePath = [Util DisscussionAboutMeFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}


/**
 * 返现记录路径（我的页面/购车金/返现记录）写入文件
 * @参数 无
 * @返回值 返现记录路径（我的页面/购车金/返现记录）写入文件
 **/
+ (void)WriteCashbackRecordToFile:(NSMutableArray *)Arr
{
    if(Arr) {
        NSString *filePath = [Util CashbackRecordFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}


/**
 * 返现记录路径（我的页面/购车金/返现记录）写入文件
 * @参数 无
 * @返回值 返现记录路径（我的页面/购车金/返现记录）写入文件
 **/
+ (NSMutableArray *)ReadCashbackRecordFromFile
{
    NSString *filePath = [Util CashbackRecordFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

//车库缓存
+ (NSString*)GarageFilePath
{
    return [[Util UserInfoPath] stringByAppendingPathComponent:@"garage_info"];
}

+ (void)WriteGarageToFile:(NSMutableArray*)Arr
{
    if(Arr) {
        NSString *filePath = [Util GarageFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

+ (NSMutableArray*)ReadGarageFromFile
{
    NSString *filePath = [Util GarageFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

//车型页 车系id、车型id缓存
+ (NSString*)ModelFilePath
{
    return [[Util UserInfoPath] stringByAppendingPathComponent:@"model_info"];
}

+ (void)WriteModelToFile:(NSMutableArray*)Arr
{
    if(Arr) {
        NSString *filePath = [Util ModelFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

+ (NSMutableArray*)ReadModelFromFile
{
    NSString *filePath = [Util ModelFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

+ (NSString*)ModelCityFilePath
{
    return [[Util UserInfoPath] stringByAppendingPathComponent:@"modelcity_info"];
}

+ (void)WriteModelCityToFile:(NSMutableArray*)Arr
{
    if(Arr) {
        NSString *filePath = [Util ModelCityFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

+ (NSMutableArray*)ReadModelCityFromFile
{
    NSString *filePath = [Util ModelCityFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

//历史
+ (NSString*)SelectHistoryFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"selecthistory_info"];
}

+ (void)WriteSelectHistoryToFile:(NSMutableArray*)Arr
{
    if(Arr) {
        NSString *filePath = [Util SelectHistoryFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

+ (NSMutableArray*)ReadSelectHistoryFromFile
{
    NSString *filePath = [Util SelectHistoryFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

+ (NSString *)DiscussionContentFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"discussion_content"];
}

+ (void)WriteDiscussionContentToFile:(NSString *)content
{
    if(content) {
        NSString *filePath = [Util DiscussionContentFilePath];
        [NSKeyedArchiver archiveRootObject:content toFile:filePath];
    }
}

+ (NSString *)ReadDiscussionContentFromFile
{
    NSString *filePath = [Util DiscussionContentFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    return nil;
}

//礼券缓存
+ (NSString*)DisCardFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"discard_info"];
}

+ (void)WriteDisCardToFile:(NSMutableArray*)Arr
{
    if(Arr) {
        NSString *filePath = [Util DisCardFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

+ (NSMutableArray*)ReadDisCardFromFile
{
    NSString *filePath = [Util DisCardFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

//买车首页缓存
+ (NSString*)BuyCarFilePath
{
    return [[Util AnonymousInfoPath] stringByAppendingPathComponent:@"newbuycar_info"];
}

+ (void)WriteBuyCarToFile:(NSMutableArray*)Arr
{
    if(Arr) {
        NSString *filePath = [Util BuyCarFilePath];
        [NSKeyedArchiver archiveRootObject:Arr toFile:filePath];
    }
}

+ (NSMutableArray*)ReadBuyCarFromFile
{
    NSString *filePath = [Util BuyCarFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
    }
    
    return nil;
}

/**
 * 我的讨论路径
 **/
+ (NSString *)MyDiscussionFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"my_discussion"];
}

/**
 * 读取我的讨论
 **/
+ (NSArray *)ReadMyDiscussionFromFile
{
    NSString *filePath = [Util MyDiscussionFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    return nil;
}

/**
 * 写入我的讨论
 **/
+ (void)WriteMyDiscussionToFile:(NSArray *)array
{
    if(array) {
        NSString *filePath = [Util MyDiscussionFilePath];
        [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    }
}


/**
 * 我参与的讨论路径
 **/
+ (NSString *)MyJoinDiscussionFilePath
{
    return [[Util OtherPath] stringByAppendingPathComponent:@"my_Join_discussion"];
}

/**
 * 读取我参与的讨论
 **/
+ (NSArray *)ReadMyJoinDiscussionFromFile
{
    NSString *filePath = [Util MyJoinDiscussionFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    return nil;
}

/**
 * 写入我参与的讨论
 **/
+ (void)WriteMyJoinDiscussionToFile:(NSArray *)array
{
    if(array) {
        NSString *filePath = [Util MyJoinDiscussionFilePath];
        [NSKeyedArchiver archiveRootObject:array toFile:filePath];
    }
}

///**
// * 利率信息文件路径
// * @参数 无
// * @返回值 利率信息文件路径
// **/
//+ (NSString *)CalculatorFilePath
//{
//    return [[Util OtherPath] stringByAppendingPathComponent:@"Calculator_info"];
//}
//
///**
// * 将利率信息写入文件中
// * @参数 利率对象
// * @返回值 无
// **/
//+ (void)WriteCalculatorToFile:(id)dic
//{
//    if(dic) {
//        NSString *calculatorFilePath = [Util CalculatorFilePath];
//        [NSKeyedArchiver archiveRootObject:dic toFile:calculatorFilePath];
//    }
//}
//
///**
// * 从文件中读取利率信息
// * @参数 无
// * @返回值 数组
// **/
//+ (id)ReadCalculatorFromFile
//{
//    NSString *filePath = [Util CalculatorFilePath];
//
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        return [NSKeyedUnarchiver unarchiveObjectWithFile: filePath];
//    }
//
//    return nil;
//}
//
///**
// * 热门品牌信息文件路径
// * @参数 无
// * @返回值 热门品牌信息文件路径
// **/
//+ (NSString *)CarHotFilePath
//{
//    return [[Util OtherPath] stringByAppendingPathComponent:@"CarHot"];
//}
//
///**
// * 将热门品牌信息写入文件中
// * @参数 热门品牌对象
// * @返回值 无
// **/
//+ (void)WriteCarHotToFile:(id)dic
//{
//    if(dic) {
//        NSString *carHotFilePath = [Util CarHotFilePath];
//
//        NSDate* savedate = [NSDate date];
//        NSDictionary* adic = [NSDictionary dictionaryWithObjectsAndKeys:dic,@"hotKey",savedate,@"timeKey", nil];
//
//        [adic writeToFile:carHotFilePath atomically:YES];
//    }
//}
//
///**
// * 从文件中读取热门品牌信息
// * @参数 无
// * @返回值 数组
// **/
//+ (id)ReadCarHotFromFile
//{
//    NSString *filePath = [Util CarHotFilePath];
//
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSDictionary* adic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//        NSMutableArray* arrTemp = [adic objectForKey:@"hotKey"];
//        NSDate* saveDate = [adic objectForKey:@"timeKey"];
//
//        NSDate* currentdate = [NSDate date];
//
//        NSTimeInterval atime = [currentdate timeIntervalSinceDate:saveDate];
//        if (atime > 60*60*24) {
//            return nil;
//        }
//
//        return arrTemp;
//    }
//
//    return nil;
//}
//
///**
// * 买车日期文件路径
// * @参数 无
// * @返回值 买车日期文件路径
// **/
//+ (NSString *)BuyCarDateFilePath
//{
//    return [[Util OtherPath] stringByAppendingPathComponent:@"buycardate_info"];
//}
//
///**
// * 从文件中读取买车日期
// * @参数 无
// * @返回值 数组
// **/
//+ (NSMutableArray *)ReadBuyCarDateFromFile
//{
//    NSString *filePath = [Util BuyCarDateFilePath];
//
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSMutableArray* array = [NSMutableArray arrayWithContentsOfFile:filePath];
//        return array;
//    }
//
//    return nil;
//}
//
///**
// * 将买车日期写入文件中
// * @参数 title数组对象
// * @返回值 无
// **/
//+ (void)WriteBuyCarDateToFile:(NSMutableArray *)array
//{
//    if(array ) {
//        NSString *buycarFilePath = [Util BuyCarDateFilePath];
//        [array writeToFile:buycarFilePath atomically:YES];
//    }
//}


//
///**
// * 从文件中读取找车信息从
// * @参数 车系id
// * @返回值 数组
// **/
//+ (NSMutableArray *)ReadFindCarFromFile:(NSString*)apid
//{
//    NSString *filePath = [Util FindCarFilePath];
//    filePath = [filePath stringByAppendingString:apid];
//    
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        NSDictionary* adic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//        NSMutableArray* arrTemp = [adic objectForKey:@"contentKey"];
//        NSDate* saveDate = [adic objectForKey:@"timeKey"];
//        
//        NSDate* currentdate = [NSDate date];
//        
//        NSTimeInterval atime = [currentdate timeIntervalSinceDate:saveDate];
//        if (atime > 60*60*24) {
//            return nil;
//        }
//        return arrTemp;
//    }
//    
//    return nil;
//}
//
///**
// * 将找车信息写入文件中
// * @参数 title数组对象，内容数组，车系id
// * @返回值 无
// **/
//+ (void)WriteFindCarToFile:(NSMutableArray *)atitle arr:(NSMutableArray*)acon pid:(NSString*)apid
//{
//    if(atitle && acon) {
//        NSString *findcarFilePath = [Util FindCarFilePath];
//        findcarFilePath = [findcarFilePath stringByAppendingString:apid];
//        
//        NSMutableArray* arrTemp = [NSMutableArray arrayWithObjects:atitle,acon, nil];
//        
//        NSDate* savedate = [NSDate date];
//        NSDictionary* adic = [NSDictionary dictionaryWithObjectsAndKeys:arrTemp,@"contentKey",savedate,@"timeKey", nil];
//        [adic writeToFile:findcarFilePath atomically:YES];
//    }
//}
//


@end

@implementation Util (Device)

+ (BOOL)iPhoneNotRetina
{
    return CGSizeEqualToSize(CGSizeMake(320.0, 480.0), [[UIScreen mainScreen] currentMode].size);
}

+ (BOOL)iPhone4
{
    return CGSizeEqualToSize(CGSizeMake(640.0, 960.0), [[UIScreen mainScreen] currentMode].size);
}

+ (BOOL)iPhone5
{
    return CGSizeEqualToSize(CGSizeMake(640.0, 1136.0), [[UIScreen mainScreen] currentMode].size);
}

+ (BOOL)iPhone6
{
    return CGSizeEqualToSize(CGSizeMake(750.0, 1334.0), [[UIScreen mainScreen] currentMode].size);
}

+ (BOOL)iPhone6Plus
{
    return CGSizeEqualToSize(CGSizeMake(1242.0, 2208.0), [[UIScreen mainScreen] currentMode].size);
}

@end