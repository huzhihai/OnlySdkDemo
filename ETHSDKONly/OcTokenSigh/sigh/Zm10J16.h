//
//  Zm10J16.h
//  CESHIHSEther
//
//  Created by xm6leefun on 2020/7/22.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Zm10J16 : NSObject
/**
 十进制转换为二进制
  
 @param decimal 十进制数
 @return 二进制数
 */
+ (NSString *)getBinaryByDecimal:(NSInteger)decimal;
/**
 十进制转换十六进制
  
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal;
/**
 二进制转换成十六进制
   
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)getHexByBinary:(NSString *)binary;
/**
 二进制转换为十进制
  
 @param binary 二进制数
 @return 十进制数
 */
+ (NSInteger)getDecimalByBinary:(NSString *)binary;
/**
 十六进制转换为二进制
   
 @param hex 十六进制数
 @return 二进制数
 */
+ (NSString *)getBinaryByHex:(NSString *)hex;
/**
 十六进制字符串转化为data
 
 @param str 十六进制字符串
 @return data
 */
+ (NSData *)convertHexStrToData:(NSString *)str;
/**
data转化为十六进制字符串

@return data
*/
+ (NSString *)convertDataToHexStr:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
