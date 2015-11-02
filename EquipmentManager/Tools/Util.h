//
//  Util.h
//  Topka2.0
//
//  Created by wangdongdong on 13-1-23.
//  Copyright (c) 2013年 Topka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface NSData (CRC32)

- (uint32_t)crc32Value;

@end

// 实用的工具类
@interface Util : NSObject

+ (float)calculateTextLength:(NSString *)textA;
+ (int)calculateTextNumber:(NSString *)textA;
+ (NSString *)cutText:(NSString *)textA toLength:(int)length;
+ (NSString *)shortenNicknameForTitle:(NSString *)nickname;

+ (NSString *)doubleFormatAmount:(int)number;
+ (NSString *)getSign:(NSString *)str;
+ (NSString *) encryptSMSUseDES:(NSString *)plainText;
+ (NSString *) encryptUseDES:(NSString *)plainText;

+ (NSTimeInterval)apitime;
//从时间戳获得时间
/**
 取得时间。
 type = 0 yyyy-mm-dd hh:mm
 type = 1 yyyy年-mm月-dd日
 **/
+ (NSString *)getTheTimeStampInSeconds;
+ (NSString *)stringWithTimeLastactivityInterval:(double)time Type:(int)type;
+ (int)rand;
+ (NSString *)checkEmpty:(NSString *)str;
+ (NSString *)getKey:(NSMutableDictionary *)params forKey:(NSString *)key;
+ (NSString *)URLEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding;
+ (NSString *)ConfromTimes:(NSString *)createTime;
+ (NSString *)timestamp:(NSString *)createTime;
/**
 * 格式化日期字符串，以分秒来分隔
 * @参数 时间戳
 * @返回值 日期字符串
 **/
+ (NSString *)ConfromTimes2:(NSString *)createTime;

+ (NSString *)addCommaFunc:(NSString*)str;
+ (NSString *)removeCommaFunc:(NSString*)str;

+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validateNick:(NSString *)nick;
+ (BOOL)checkIphone:(NSString *)phoneNo;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;

+ (UIImage *)getImageFromView:(UIView *)view;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)scaleImage:(UIImage *)image scaleFactor:(float)scaleBy;
+(int) getNaviStatusHeight;
+(int) getNaviStatusHeightEx;
+(int) isBigios7;
+(void) setTopInset:(UIScrollView*) scroll topInsent:(float) topinsent;

+(BOOL) checkClassObjectEmpty:(id) data;

+(int) getStatusBarHeight;
+(int) getStatusBarHeightEx;

+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size;
+ (CGSize)sizeOfString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

// 宽度固定
+ (CGSize) sizeOfString:(NSString*)string font:(CGFloat)fontSize maxWidth:(CGFloat)width;
// 高度固定
+ (CGSize) sizeOfString:(NSString*)string font:(CGFloat)fontSize maxHeight:(CGFloat)height;
// pattern:0代表水平固定，1代表高度固定
+ (CGSize) sizeOfString:(UILabel*)label pattern:(int)pattern;

@end

@interface Util (File)

+ (NSString *)DocumentPath;
+ (NSString *)CachePath;
+ (NSString *)UserInfoPath;
+ (NSString *)AnonymousInfoPath;

//存储登录账户
+ (void)WriteNewLoginWithAccount:(NSString *)account;
+ (NSString *)LoginInfoFilePath;
+ (NSString *)readLoginInfo;
//存储快速登录账户
+ (void)WriteNewQuickLoginWithAccount:(NSString *)account;
+ (NSString *)QuickLoginInfoFilePath;
+ (NSString *)readQuickLoginInfo;

//判断是否弹过支付页面的提示窗
+ (void)WritePayThePopupWindowWithFlag;
+ (NSString *)PayThePopupWindowFilePath;

+ (NSString *)OtherPath;

+ (void)DeleteAllFilesAtUserInfoPath;
+ (void)DeleteAllFilesAtOtherPath;
+ (void)DeleteAllCachedFiles;
+ (double)CalculateSizeOfAllCachedFile;
+ (unsigned long long)CalculateSizeOfFolder:(NSString *)folderPath;

+ (NSString *)RecentSearchFilePath;
+ (NSMutableArray *)ReadRecentSearchFromFile;
+ (void)WriteRecentSearchToFile:(NSMutableArray *)array;

+ (NSString *)HotBrandsFilePath;
+ (NSArray *)ReadHotBrandsFromFile;
+ (void)WriteHotBrandsToFile:(NSArray *)array;

+ (NSString *)UserInfoFilePath;
+ (NSString *)AnonymousInfoFilePath;
+ (NSString *)TelLogFilePath;
+ (NSString *)MyReportFilePath;

+ (NSString *)CarDiffFilePath;
//+ (NSString *)FindHistoryFilePath;
+ (NSString *)DisscussionFilePath;
+ (NSString *)DisscussionAboutMeFilePath;
+ (NSString *)CashbackRecordFilePath;


+ (void)WriteUserInfoToFile:(UserInfo *)userInfo;
+ (UserInfo *)ReadUserInfoFromFile;
+ (void)WriteAnonymousInfoToFile:(UserInfo *)userInfo;
+ (UserInfo *)ReadAnonymousInfoFromFile;

+ (void)WriteTelLogToFile:(NSMutableArray *)Arr;
+ (NSMutableArray *)ReadTelLogFromFile;

+ (void)WriteMyreportToFile:(NSMutableArray *)Arr;
+ (NSMutableArray *)ReadMyReportFromFile;

+ (void)WriteCarDiffToFile:(NSMutableArray *)Arr;
+ (NSMutableArray *)ReadCarDiffFromFile;

//+ (void)WriteFindHistoryToFile:(NSMutableArray *)Arr;
//+ (NSMutableArray *)ReadFindHistoryFromFile;

+ (void)WriteDisscussionToFile:(NSMutableArray *)Arr;
+ (NSMutableArray *)ReadDisscussionFromFile;

+ (void)WriteDisscussionAboutMeToFile:(NSMutableArray *)Arr;
+ (NSMutableArray *)ReadDisscussionAboutMeFromFile;



+ (void)WriteCashbackRecordToFile:(NSMutableArray *)Arr;
+ (NSMutableArray *)ReadCashbackRecordFromFile;


//车库缓存
+ (NSString*)GarageFilePath;
+ (void)WriteGarageToFile:(NSMutableArray*)Arr;
+ (NSMutableArray*)ReadGarageFromFile;

//车型页 车系id、车型id缓存
+ (NSString*)ModelFilePath;
+ (void)WriteModelToFile:(NSMutableArray*)Arr;
+ (NSMutableArray*)ReadModelFromFile;

+ (NSString*)ModelCityFilePath;
+ (void)WriteModelCityToFile:(NSMutableArray*)Arr;
+ (NSMutableArray*)ReadModelCityFromFile;

//历史
+ (NSString*)SelectHistoryFilePath;
+ (void)WriteSelectHistoryToFile:(NSMutableArray*)Arr;
+ (NSMutableArray*)ReadSelectHistoryFromFile;

// 发起讨论（讨论内容）
+ (NSString *)DiscussionContentFilePath;
+ (void)WriteDiscussionContentToFile:(NSString *)content;
+ (NSString *)ReadDiscussionContentFromFile;

//礼券缓存
+ (NSString*)DisCardFilePath;
+ (void)WriteDisCardToFile:(NSMutableArray*)Arr;
+ (NSMutableArray*)ReadDisCardFromFile;

//买车首页缓存
+ (NSString*)BuyCarFilePath;
+ (void)WriteBuyCarToFile:(NSMutableArray*)Arr;
+ (NSMutableArray*)ReadBuyCarFromFile;

//我发起的讨论
+ (NSString *)MyDiscussionFilePath;
+ (NSMutableArray *)ReadMyDiscussionFromFile;
+ (void)WriteMyDiscussionToFile:(NSMutableArray *)array;


//我参与的讨论
+ (NSString *)MyJoinDiscussionFilePath;
+ (NSMutableArray *)ReadMyJoinDiscussionFromFile;
+ (void)WriteMyJoinDiscussionToFile:(NSMutableArray *)array;


//
//+ (id)ReadCalculatorFromFile;
//+ (void)WriteCalculatorToFile:(id)dic;
//
//+ (id)ReadCarHotFromFile;
//+ (void)WriteCarHotToFile:(id)dic;
//
//+ (NSMutableArray *)ReadBuyCarDateFromFile;
//+ (void)WriteBuyCarDateToFile:(NSMutableArray *)array;

@end

@interface Util (Device)

+ (BOOL)iPhoneNotRetina;
+ (BOOL)iPhone4;
+ (BOOL)iPhone5;
+ (BOOL)iPhone6;
+ (BOOL)iPhone6Plus;

@end
