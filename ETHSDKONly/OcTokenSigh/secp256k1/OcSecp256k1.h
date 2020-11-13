//
//  OcSecp256k1.h
//  Sign
//
//  Created by xm6leefun on 2020/8/27.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OcSecp256k1 : NSObject
/**
 根据公钥生成私钥

 @param privateKeyData 私钥 NSdata类型（二进制数据类型）
 @param isCompression 是否压缩 description
 @return return value 由私钥生成的公钥
 */
+ (NSData *)generatePublicKeyWithPrivateKey:(NSData *)privateKeyData compression:(BOOL)isCompression;

/**
 根据私钥生成数据的签名数据
 签名的方式 secp256k1_ecdsa_signature_serialize_compact
 @param msgData msgData 生成的数据
 @param privateKeyData 私钥 NSdata类型（二进制数据类型）
 @return return value 签名数据
 */
+ (NSData *)compactSignData:(NSData *)msgData withPrivateKey:(NSData *)privateKeyData;
/*
 根据私钥生成数据的签名数据
  签名的方式  secp256k1_ecdsa_signature_serialize_der
 @param msgData msgData 生成的数据
 @param privateKeyData 私钥 NSdata类型（二进制数据类型）
 @return return value 签名数据
 */
+ (NSData *)serializeSignData:(NSData *)msgData withPrivateKey:(NSData *)privateKeyData;
/**
 用公钥验证签名

 @param sigData 签名的数据
 @param msgData 原数据
 @param pubKeyData 公钥
 @return 1 OK；0 不正确；-3 公钥读取失败；-4 签名读取失败
 */
+ (NSInteger)verifySignedData:(NSData *)sigData withMessageData:(NSData *)msgData usePublickKey:(NSData *)pubKeyData;
/**
用公钥验证签名
 der 方式
@param sigData 签名的数据
@param msgData 原数据
@param pubKeyData 公钥
@return 1 OK；0 不正确；-3 公钥读取失败；-4 签名读取失败
*/
+ (NSInteger)verifyderSignedData:(NSData *)sigData withMessageData:(NSData *)msgData usePublickKey:(NSData *)pubKeyData;
@end


