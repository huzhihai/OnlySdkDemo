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
#define providsBaseUrl @"http://101.200.145.35:9082/"// Only节点
#import <Foundation/Foundation.h>
#import "HSEther.h"
#import "ETHSDKONly-Swift.h"
#import "OcTokenSigh.h"
@interface DCEther : HSEther

/**
 创建钱包
 only
 @param pwd 密码
 @param block 创建成功回调
 */
+ (void)dc_createWithPwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey))block;
/**
助记词导入
 only
@param mnemonics 助记词 12个英文单词 空格分割
@param pwd 密码
@param block 导入回调
*/
+ (void)dc_inportMnemonics:(NSString *)mnemonics pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block;

/**
 KeyStore 导入
 only
 @param keyStore keyStore文本，类似json
 @param pwd 密码
 @param block 导入回调
 */
+ (void)dc_importKeyStore:(NSString *)keyStore pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block;
/**
私钥导入
 only
@param privateKey 私钥
@param pwd 密码
@param block 导入回调
*/
+ (void)dc_importWalletForPrivateKey:(NSString *)privateKey pwd:(NSString *)pwd block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block;
/*
 交易
 
 所有有关金额亿为单位  (重点重点重点!!!!)
 
 privateKey 钱包的私钥
 publicKey  钱包的公钥
 addrss     钱包的地址
 actionTypeNum
 {
 1：普通转账
 2：已经废弃不用，之前为投票质押
 3：暂未开放，超级节点质押
 4：开通权益
 5：投票者激励
 6：9个备选节点激励
 7：21个工作节点激励
 8：极客社群激励
 9：质押挖矿
 10：21+9+N节点激励
 11：节点工作手续费
 12：手续费销毁
 }
 
 poundage 手续费:普通用户转账需要手续费即可发起交易，高级账号需要质押5000可以免手续费转账
 
 array 包裹字典 （字典包含price:需要乘一个亿 跟 address）,对方的信息
 
 @[{@"address":@"a7ed1688bb395bb358eedd2d80078137ca17fdde",@"price":@"100000000"}]
 */

+ (void)transArray:(NSArray *)array ActionTypeNum:(int)actionTypeNum poundage:(int)poundage privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address block:(void(^)(BOOL isuc))block;
/*
 查询接口
 address  钱包的地址
 */
+ (void)getOnlyBalanceAddress:(NSString *)address success:(void(^_Nonnull)(id  _Nullable responseObject))successBlock failure:(void(^_Nonnull)(NSError * _Nonnull error))failureBlock;

@end


