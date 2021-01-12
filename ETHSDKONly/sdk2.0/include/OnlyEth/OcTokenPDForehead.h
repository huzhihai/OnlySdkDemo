//
//  OcTokenPDForehead.h
//  ocToken
//
//  Created by xm6leefun on 2020/8/28.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OcTokenPDForehead : NSObject
/*
  获取txid
   对(16进制msg+sign)  进行两次HASH得到16进制=txid
 */
+ (NSString *_Nonnull)oc_creatTxidWithprivateKey:(NSString *_Nonnull)privateKey message:(NSString *_Nonnull)message;
/*
 对消息进行加签
 *message 消息
 *privateKey 私钥
 */
+ (NSString *_Nullable)oc_messageSighWithMessage:(NSString *_Nonnull)message privateKey:(NSString *_Nullable)privateKey;
/*
 验证签名
 *message 消息
 *sigh 签名
 *publicKey 公钥
 */
+ (NSInteger)oc_verifySigneWithSight:(NSString *_Nonnull)sigh message:(NSString *_Nonnull)message publicKey:(NSString *_Nonnull)publicKey;
/*
  邀请码-加签
  message 邀请码
  privateKey 私钥
 */
+ (NSString *_Nonnull)oc_creatSighWithMessage:(NSString *_Nonnull)message privateKey:(NSString *_Nonnull)privateKey;
/*
 交易
 privateKey 钱包的私钥

 array 包裹字典 （字典包含price  跟 address）,对方的信息
 @[{@"address":@"a7ed1688bb395bb358eedd2d80078137ca17fdde",@"price":@"0.01"}]
 
 poundage 手续费 未开通5000权益，最低不少10000 亿为单位
 普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账
 
  noce 可以接口请求，根据目前所交易的数量自增1:
  例如: 交易了10笔 则noce为10，下次交易需要增加1 为 noce=11 传入进行交易
 */
+ (void)oc_transferArray:(NSArray *_Nonnull)array privateKey:(NSString *_Nonnull)privateKey noce:(int)noce poundage:(NSString *_Nonnull)poundage block:(void(^_Nonnull)(BOOL isuc,id  _Nullable responseObject,id _Nullable sigh,id _Nullable payNum))block;
/*
 查询接口
 address  钱包的地址
 */
+ (void)oc_getOnlyBalanceAddress:(NSString *_Nonnull)address success:(void(^_Nonnull)(id  _Nullable responseObject))successBlock failure:(void(^_Nonnull)(NSError * _Nonnull error))failureBlock;
/*
 开通权益
 price 开通权益的金额
 address 钱包的地址
 
 poundage 手续费 未开通5000权益，最低不少10000 亿为单位
 普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账
 
  noce 可以接口请求，根据目前所交易的数量自增1:
  例如: 交易了10笔 则noce为10，下次交易需要增加1 为 noce=11 传入进行交易
 */
+ (void)oc_interestsActionWithPrice:(NSString *_Nonnull)price privateKey:(NSString *_Nonnull)privateKey noce:(int)noce poundage:(NSString *_Nonnull)poundage block:(void(^_Nonnull)(BOOL isuc,id  _Nullable responseObject,id _Nullable sigh,id _Nullable payNum))block;
/*
 质押
 
 array  包裹字典 （字典包含price  跟 address）
 @[{@"address":@"a7ed1688bb395bb358eedd2d80078137ca17fdde",@"price":@"0.01"}]
  privateKey 钱包的私钥

 poundage 手续费 未开通5000权益，最低不少10000 亿为单位
 普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账
 
  noce 可以接口请求，根据目前所交易的数量自增1:
    例如: 交易了10笔 则noce为10，下次交易需要增加1 为 noce=11 传入进行交易
 */
+ (void)oc_pledgeActionNetworkWithArray:(NSArray *_Nonnull)array privateKey:(NSString *_Nonnull)privateKey noce:(int)noce poundage:(NSString *_Nonnull)poundage block:(void(^_Nonnull)(BOOL isuc,id  _Nullable responseObject,id _Nullable sigh,id _Nullable payNum))block;
/*
 查询手续费
 */
+ (void)oc_getPoundageDataSuccess:(void(^_Nonnull)(id  _Nullable responseObject))successBlock failure:(void(^_Nonnull)(NSError * _Nonnull error))failureBlock;
/*
 获取区块数据
 */
+ (void)oc_getQueryBlockListWithBlock:(NSString *_Nonnull)bolock success:(void(^_Nonnull)(id  _Nullable responseObject))successBlock failure:(void(^_Nonnull)(NSError * _Nonnull error))failureBlock;
/*
 交易反序列化
 */
+ (void)oc_deserializationTrandActionWithMessage:(NSString *_Nonnull)message successful:(void(^_Nonnull)(NSDictionary *_Nonnull data))successful failure:(void(^_Nonnull)(void))failure;


@end

