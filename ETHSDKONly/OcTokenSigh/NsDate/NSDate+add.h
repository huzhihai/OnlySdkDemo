//
//  NSDate+add.h
//  ocToken
//
//  Created by xm6leefun on 2020/7/9.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (add)
/// 获取时间
+ (NSString *)getLocalTimer;
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate;
//时间戳变为格式时间
+ (NSString *)getStrToTime:(NSString *)timeStr;
//获取当前时间戳 以秒为单位
+(NSString *)getNowTimeTimestamp;
@end

NS_ASSUME_NONNULL_END
