//
//  DCEther.h
//  dc
//
//  Created by xm6leefun on 2020/9/17.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

/*
 
1 在需要使用的地方 引入 #import "DCEther.h"
2 build setting > vaild architectures 去掉对 armv7的支持
  Only包含了swift 需要配置  xxxx-Bridging-Header，改完引入项目需要替换 ETHSDKONly-Swift 换成 xxxx-swift
 3 需要引入加密规则
    pod 'CB_RIPEMD', '~> 0.9.0'
    pod 'LEB128', '~> 2.0.0'
 4 建议cocopods 引入
 5  providsBaseUrl  only的节点，可以替换自己所需要的节点
 6.使用Only 直接用dc 为开头的方法
  */

#import <Foundation/Foundation.h>
#import "HSEther.h"


@interface OCEther : HSEther

/**
 创建钱包
 only
 path 默认可以不写
 @param pwd 密码
 @param block 创建成功回调
 */
+ (void)oc_createWithPwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey))block;

/**
助记词导入
 only
 path 默认可以不写
@param mnemonics 助记词 12个英文单词 空格分割
@param pwd 密码
@param block 导入回调
*/
+ (void)oc_inportMnemonics:(NSString *)mnemonics pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block;

/**
 KeyStore 导入
 only
 path 默认可以不写
 @param keyStore keyStore文本，类似json
 @param pwd 密码
 @param block 导入回调
 */
+ (void)oc_importKeyStore:(NSString *)keyStore pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block;
/**
私钥导入
 only
@param privateKey 私钥
@param pwd 密码
@param block 导入回调
*/
+ (void)oc_importWalletForPrivateKey:(NSString *)privateKey pwd:(NSString *)pwd block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block;

@end


