//
//  NSDate+add.m
//  ocToken
//
//  Created by xm6leefun on 2020/7/9.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import "NSDate+add.h"

@implementation NSDate (add)
//本地日期格式:2013-08-03 12:53:51
//可自行指定输入输出格式
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}
/// 获取时间
+ (NSString *)getLocalTimer {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}
//时间戳变为格式时间
+ (NSString *)getStrToTime:(NSString *)timeStr{
long long time=[timeStr longLongValue];
//    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
//    long long time=[timeStr longLongValue] / 1000;

NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];

NSDateFormatter *formatter = [[NSDateFormatter alloc]init];

[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

NSString*timeString=[formatter stringFromDate:date];

return timeString;

}
//获取当前时间戳 以秒为单位
+(NSString *)getNowTimeTimestamp{

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}
@end
