//
//  OcTokenSigh.h
//  CESHIHSEther
//
//  Created by xm6leefun on 2020/7/27.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransferVinModel.h"

@interface OcTokenSigh : NSObject

/*
 转账
 privateKey 私钥
 publicKey  公钥
 
 actionTypeNum
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
 
 poundage 手续费
 普通用户转账需要手续费即可发起交易，高级账号需要质押5000可以免手续费转账
 
 timestamp  当前时间戳
 heighStamp  高度
 otherArray 包裹字典 （字典包含price 跟 address）,对方的信息
 price 每个地址的金额 address 对方的地址
 otherAddress 对方的地址
 allPrice 交易的金额
 noce 交易的Noce值,从账户接口获取，获取到的 noce+1 进行入参
*/
+ (NSString *)trantingWithActionTypeNum:(int)actionTypeNum poundage:(int)poundage timestamp:(int)timestamp noce:(NSString *)noce otherArray:(NSArray *)otherArray privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey;


/*
  质押
 oterarray 需要质押的数组 包裹字典 （字典包含price 跟 address
 noce 交易的Noce值,从账户接口获取，获取到的 noce+1 进行入参
 poundage 手续费 开通完权益 不需要手续费
 privateKey 私钥
 publicKey 公钥
 返回序列化 action
 */
+ (NSString *)pledgeActionNetworkWithoterarray:(NSArray *)oterarray noce:(NSString *)noce poundage:(int)poundage privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey;

/*

 账户 进行序列化
 amount  总金额
 equityPrice 可用余额
 actionTypeNum = 1  交易类型
 poundage = 0 手续费
 timestamp 时间戳
 heighStamp 接口获取的区块高度
 inArray  < TransferVinModel >  主要price 质押金额， address 质押地址，unlocktimer 质押时间
 superPledge 超级节点质押量
 privateKey   publicKey  address 自己的公私钥地址
*/
+ (NSString *)acountSignWithAmount:(NSString *)amount equityPrice:(NSString *)equityPrice heighStamp:(int)heighStamp superPledge:(NSString *)superPledge inArray:(NSArray *)inArray luckUpArray:(NSArray *)luckUpArray privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address;
/*
 
 账户反序列化
 message 序列化message
 */
+ (void)singserializationMessageWithMessage:(NSString *)message successful:(void(^)(NSDictionary *data))successful failure:(void(^)(void))failure;

/*
 开通权益
 oterarray 需要质押的数组 包裹字典 （字典包含price 跟 address)
 noce 交易的Noce值,从账户接口获取，获取到的 noce+1 进行入参
 privateKey 私钥
 publicKey 公钥
 返回序列化 actio
 */
+ (NSString *)interestsActionnoNetworkWithoterarray:(NSArray *)oterarray noce:(NSString *)noce privateKey:(NSString *)privateKey publicKey:(NSString *)publicKe;
@end

