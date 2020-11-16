//
//  OcTokenSigh.m
//  CESHIHSEther
//
//  Created by xm6leefun on 2020/7/27.
//  Copyright © 2020 xm6leefun. All rights reserved.
//
// 乘一个亿
#define kYdecimalNum(x) [[[NSDecimalNumber decimalNumberWithString:x] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100000000"]] stringValue]
// 除一个亿
#define kCdecimalNum(x) [[[NSDecimalNumber decimalNumberWithString:x] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.00000001"]]stringValue]
/// 18wei 相乘
#define kYWEIlNum(x) [[[NSDecimalNumber decimalNumberWithString:x] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"1000000000000000000"]] stringValue]
/// 除 18wei
#define kCWEINum(x) [[[NSDecimalNumber decimalNumberWithString:x] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"0.000000000000000001"]]stringValue]

#import "OcTokenSigh.h"
#import "OcSecp256k1.h"
#import <NSData+Hashing.h>
#import "NSData+HexString.h"
#import "Zm10J16.h"
#import "ETHSDKONly-Swift.h"
#import "OcSecp256k1.h"
#import "NSMutableDictionary+ITWExtend.h"
#import "NSDictionary+ITWExtend.h"
#import "NSDate+add.h"
@implementation OcTokenSigh
/// 交易
+ (NSString *)trantingWithActionTypeNum:(int)actionTypeNum poundage:(int)poundage timestamp:(int)timestamp noce:(NSString *)noce otherArray:(NSArray *)otherArray privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey{
    if (otherArray.count==0) {
        return @"sorry nothing";
    }
    NSString *systeVersion = [self getStringHexByDecimal:2];
    NSString *actionType = [self getStringHexByDecimal:actionTypeNum];
    NSString *headStr = [NSString stringWithFormat:@"%@%@",systeVersion,actionType];
    NSString *resultAllString = [NSString stringWithFormat:@"%@",headStr];
    NSInteger inde = otherArray.count;// out的数量
    resultAllString = [resultAllString stringByAppendingString:[self getStringHexByDecimal:inde]];
    for (NSDictionary *dic in otherArray) {
        if (![dic.allKeys containsObject:@"price"]||![dic.allKeys containsObject:@"address"]) {
            return @"price 或者 address 传入key有误";
        }
        NSString *otherPrice = dic[@"price"];
        NSString *otherAD = dic[@"address"];
        NSInteger sunPrice = [NSString stringWithFormat:@"%@",otherPrice].integerValue;
        /// 拼接上金额 十六进制
        resultAllString = [resultAllString stringByAppendingString:[self changeDataTo16BytesWithData:sunPrice]];
        // 锁定的脚本
        NSString *scripString = otherAD;
        //结果序列 拼接上锁定的脚本
        resultAllString = [resultAllString stringByAppendingString:scripString];
    }
    if (actionTypeNum==4) {// 如果类型是4 的话需要时间戳加上区块高度
        resultAllString = [resultAllString stringByAppendingString:[self getLEB128Timerindex:31536000]];
    }else if (actionTypeNum==9){
        resultAllString = [resultAllString stringByAppendingString:[self getLEB128Timerindex:100000]];
    }else{
       resultAllString = [resultAllString stringByAppendingString:@"00"];
    }
    //交易的时间戳
    NSString *timerString = [self getLEB128Timerindex:timestamp];
    resultAllString = [resultAllString stringByAppendingFormat:@"%@",timerString];
    //私钥
    resultAllString = [resultAllString stringByAppendingFormat:@"%@",publicKey];
    //交易的noce
    int noces = noce.intValue;
    //交易的noce
    resultAllString = [resultAllString stringByAppendingFormat:@"%@",[self getLEB128Timerindex:noces]];
    //结果序列 拼接上手续费
    resultAllString = [resultAllString stringByAppendingFormat:@"%@",[self changeDataTo16BytesWithData:poundage]];
    //结果序列  拼接 0100--固定拼接
    resultAllString = [resultAllString stringByAppendingFormat:@"0100"];
    // 序列结果进行转码  action sign
    NSData *hxi256Data = [NSData hexStringToData:resultAllString];
    NSData *haxi256 = [[hxi256Data SHA256Hash] SHA256Hash];
    // 私钥的二进制流
    NSData* privateKeydata = [NSData hexStringToData:privateKey];
    ///  进行二次签名
    NSData *sighData = [OcSecp256k1 serializeSignData:haxi256 withPrivateKey:privateKeydata];
    /// 二次签名转 string
    NSString *sighData246sign = [sighData dataToHexString];
    // 结果序列 拼接 结果序列进行二次签名
    resultAllString = [resultAllString stringByAppendingFormat:@"%@",sighData246sign];
//    NSLog(@"%@",resultAllString);
    return resultAllString;
}

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
+ (NSString *)acountSignWithAmount:(NSString *)amount equityPrice:(NSString *)equityPrice heighStamp:(int)heighStamp superPledge:(NSString *)superPledge inArray:(NSArray *)inArray luckUpArray:(NSArray *)luckUpArray privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address{

    if (inArray.count==0) {
        return @"sorry nothing";
    }
    /// 账户编码规则版本，1个字节
    NSString *resultAllString = [NSString stringWithFormat:@"%@",@"02"];
    ///账户可用金额，16个字节
    NSString *Value = [self changeDataTo16BytesWithData:amount.integerValue];
    resultAllString = [resultAllString stringByAppendingString:Value];
    ///开通权益的金额，22个字节
    NSString *RightValue = [self changeDataTo16BytesWith11Data:equityPrice.integerValue];
    resultAllString = [resultAllString stringByAppendingString:RightValue];
    ///RightTime 权益解锁时间，LEB128算法，不限定字节数
    NSString * RightTime = [self getLEB128Timerindex:heighStamp+15768000];//
    resultAllString = [resultAllString stringByAppendingString:RightTime];
    ///超级节点质押量，32个字节
    NSString *SuperPledge = [self changeDataTo16BytesWithData:superPledge.integerValue];
    resultAllString = [resultAllString stringByAppendingString:SuperPledge];
    // 超级节点质押到期时间，LEB128算法，不限定字节数
    NSString *SuperPledgeTime = [self getLEB128Timerindex:heighStamp+15768000];//
     resultAllString = [resultAllString stringByAppendingString:SuperPledgeTime];
    //质押笔数，用来循环计算有多少笔质押，LEB128算法，不限定字节数
    int PledgeNum = inArray.count;
    resultAllString= [resultAllString stringByAppendingString:[self getLEB128Timerindex:PledgeNum]];
    ///Pledge字段是由多笔质押记录组成，PledgeNum为多少就有多少个Pledge质押记录
    for (TransferVinModel *model in inArray) {
        ////质押金额，32个字节 102
        NSString *price =[self changeDataTo16BytesWithData:model.price.integerValue];
        resultAllString= [resultAllString stringByAppendingString:price];
        ///质押地址，80个字节
        NSString *PledgeAddress = model.address;
        resultAllString = [resultAllString stringByAppendingString:PledgeAddress];
        ///质押解锁时间，LEB128算法，不限定字节数
        NSString *UnLockTime = [self getLEB128Timerindex:heighStamp+15768000];
        resultAllString = [resultAllString stringByAppendingString:UnLockTime];
    }
    
    int luckUpNum = luckUpArray.count;
    resultAllString= [resultAllString stringByAppendingString:[self getLEB128Timerindex:luckUpNum]];
    for (TransferVinModel *model in luckUpArray) {
        NSString *price =[self changeDataTo16BytesWithData:model.price.integerValue];
        resultAllString= [resultAllString stringByAppendingString:price];
        NSString *UnLockTime = [self getLEB128Timerindex:heighStamp+15768000];
        resultAllString = [resultAllString stringByAppendingString:UnLockTime];
    }
        // 录生成这笔记录时的区块高度，LEB128算法，不限定字节数
    NSString *BlockHeight = [self getLEB128Timerindex:heighStamp+15768000];
     resultAllString = [resultAllString stringByAppendingString:BlockHeight];
    ///总发起的交易数，LEB128算法，不限定字节数
    NSString *Noce = [self getLEB128Timerindex:PledgeNum];
    resultAllString = [resultAllString stringByAppendingString:Noce];
    ///：地址，该账户的所有的人，80个字节
    NSString *Address = address;
    resultAllString = [resultAllString stringByAppendingString:Address];
    return resultAllString;
}
/// 反序列化
+ (void)singserializationMessageWithMessage:(NSString *)message successful:(void(^)(NSDictionary *data))successful failure:(void(^)(void))failure{
    if (message.length==0) {
        return;
    }
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSString *version = [message substringToIndex:2];
    [dataDic setObj:version forKey:@"version"];
    NSString *value =  [message substringWithRange:NSMakeRange(2,16)];
    NSString *value10 = [self change16To10:value];
    [dataDic setObj:value10 forKey:@"value"];
    NSString *RightValue =  [message substringWithRange:NSMakeRange(18,11)];
    NSString *RightValue10 = [self change16To10:RightValue];
    [dataDic setObj:RightValue10 forKey:@"rightValue"];
    int indexs = 29;
    /// 截取RightTime
    NSString *RightTimes = @"";
    NSMutableArray *rightTimesarray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
        NSString *leb= [self decodeLEB128Withtimer:RightTime];
        int num = leb.intValue;
        indexs = indexs+2;
        [rightTimesarray addObject:@(num)];
        if (leb.length!=3) {
            NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:rightTimesarray];
            RightTimes = strs;
            break;
        }
    }
    [dataDic setObj:RightTimes forKey:@"rightTimes"];

    NSString *SuperPledge = [message substringWithRange:NSMakeRange(indexs,16)];
    NSString *SuperPledge10 = [self change16To10:SuperPledge];
    [dataDic setObj:SuperPledge10 forKey:@"superPledge"];
    indexs = indexs+16;
    NSString *SuperPledgeTime = @"";
    NSMutableArray *SuperTimesarray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
        NSString *leb= [self decodeLEB128Withtimer:RightTime];
        int num = leb.intValue;
        indexs = indexs+2;
        [SuperTimesarray addObject:@(num)];
        if (leb.length!=3) {
            NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:SuperTimesarray];
            SuperPledgeTime = strs;
            break;
        }
    }
    [dataDic setObj:SuperPledgeTime forKey:@"superPledgeTime"];
    NSString *PledgeNum = @"";
    NSMutableArray *PledgeNumarray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
        NSString *leb= [self decodeLEB128Withtimer:RightTime];
        int num = leb.intValue;
        indexs = indexs+2;
        [PledgeNumarray addObject:@(num)];
        if (leb.length!=3) {
            NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:PledgeNumarray];
            PledgeNum = strs;
            break;
        }
    }
    [dataDic setObj:PledgeNum forKey:@"pledgeNum"];
    int arraycount = PledgeNum.intValue;
    NSMutableArray *contentArray = [NSMutableArray array];
    for (int i = 0; i<arraycount; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *value = [message substringWithRange:NSMakeRange(indexs,16)];
        NSString *value10 = [self change16To10:value];
        indexs = indexs + 16;
        [dic setValue:value10 forKey:@"price"];
        NSString *address = [message substringWithRange:NSMakeRange(indexs,40)];
        indexs = indexs + 40;
        [dic setValue:address forKey:@"address"];
        NSString *UnLockTime = @"";
        NSMutableArray *UnLockTimeArray = [NSMutableArray array];
        for (int i = 0; i<10; i++) {
            NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
            NSString *leb= [self decodeLEB128Withtimer:RightTime];
            int num = leb.intValue;
            indexs = indexs+2;
            [UnLockTimeArray addObject:@(num)];
            if (leb.length!=3) {
                NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:UnLockTimeArray];
                UnLockTime = strs;
                break;
            }
        }
        [dic setValue:UnLockTime forKey:@"unLockTime"];
        [contentArray addObject:dic];
    }
    [dataDic setObj:contentArray forKey:@"pledge"];
    NSString *luckUpNum = @"";
    NSMutableArray *luckUpNumarray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
        NSString *leb= [self decodeLEB128Withtimer:RightTime];
        int num = leb.intValue;
        indexs = indexs+2;
        [luckUpNumarray addObject:@(num)];
        if (leb.length!=3) {
            NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:luckUpNumarray];
            luckUpNum = strs;
            break;
        }
    }
    [dataDic setObj:luckUpNum forKey:@"luckUpNum"];
    int luckUpNumarraycount = luckUpNum.intValue;
    NSMutableArray *luckUpcontentArray = [NSMutableArray array];
    for (int i = 0; i<luckUpNumarraycount; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *value = [message substringWithRange:NSMakeRange(indexs,16)];
        NSString *value10 = [self change16To10:value];
        indexs = indexs + 16;
        [dic setValue:value10 forKey:@"value"];
        NSString *UnLockTime = @"";
        NSMutableArray *UnLockTimeArray = [NSMutableArray array];
        for (int i = 0; i<10; i++) {
            NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
            NSString *leb= [self decodeLEB128Withtimer:RightTime];
            int num = leb.intValue;
            indexs = indexs+2;
            [UnLockTimeArray addObject:@(num)];
            if (leb.length!=3) {
                NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:UnLockTimeArray];
                UnLockTime = strs;
                break;
            }
        }
        [dic setValue:UnLockTime forKey:@"unLockTime"];
        [luckUpcontentArray addObject:dic];
    }
    [dataDic setObj:luckUpcontentArray forKey:@"luckUp"];
    
    NSString *BlockHeight = @"";
    NSMutableArray *BlockHeightArray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
        NSString *leb= [self decodeLEB128Withtimer:RightTime];
        int num = leb.intValue;
        indexs = indexs+2;
        [BlockHeightArray addObject:@(num)];
        if (leb.length!=3) {
            NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:BlockHeightArray];
            BlockHeight = strs;
            break;
        }
    }
    [dataDic setObj:BlockHeight forKey:@"blockHeight"];
    NSString *Noce = @"";
    NSMutableArray *NoceArray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        NSString *RightTime =  [message substringWithRange:NSMakeRange(indexs,2)];
        NSString *leb= [self decodeLEB128Withtimer:RightTime];
        int num = leb.intValue;
        indexs = indexs+2;
        [NoceArray addObject:@(num)];
        if (leb.length!=3) {
            NSString *strs = [[[OcTokenLEB128 alloc] init] decodeLEB128WithVariable:NoceArray];
            Noce = strs;
            break;
        }
    }
    [dataDic setObj:Noce forKey:@"noce"];
    NSString *address =  [message substringWithRange:NSMakeRange(indexs,40)];
    [dataDic setObj:address forKey:@"address"];
    [dataDic setObj:message forKey:@"encode"];
    NSMutableDictionary *recordDic = [NSMutableDictionary dictionary];
    [recordDic setObj:dataDic forKey:@"data"];
    [recordDic setObj:@YES forKey:@"IsSuccess"];
    successful(recordDic);
}

+ (NSString *)decodeLEB128Withtimer:(NSString *)timer{
    //十六进制转换为二进制
    NSString *timer2 = [Zm10J16 getBinaryByHex:timer];
    //二进制转换为十进制
    NSInteger timer10 = [Zm10J16 getDecimalByBinary:timer2];
    return [NSString stringWithFormat:@"%ld",timer10];
}

// LEB128
+ (NSString *)getLEB128Timerindex:(int)index{
    NSArray *array = [[[OcTokenLEB128 alloc] init] LED128WithVariable:index];
    NSString *timerString = @"";
    for (NSString *index in array) {//
        // 转十六进制
        NSString *str =  [Zm10J16 getHexByDecimal:index.integerValue];
        if (str.length%2==0) {}else{
            str = [NSString stringWithFormat:@"0%@",str];
        }
        timerString = [timerString stringByAppendingFormat:@"%@",str];
    }
    return timerString;
}

// 十六进制 转 十进制
+ (NSString *)change16To10:(NSString *)data{
    //十六进制转换为二进制
    NSString *sts = [Zm10J16 getBinaryByHex:data];
    //二进制转换为十进制
    NSInteger strss = [Zm10J16 getDecimalByBinary:sts];
    return [NSString stringWithFormat:@"%ld",strss];
}
// 十进制通过二进制转十六进制 -- 固定位数16
+ (NSString *)changeDataTo16BytesWithData:(NSInteger)data{
    NSString *price = [Zm10J16 getHexByBinary:[Zm10J16 getBinaryByDecimal:data]];
    NSString *strs = @"";
    for (int i = 0; i<16-price.length; i++) {
        strs = [strs stringByAppendingString:@"0"];
    }
    strs = [strs stringByAppendingString:price];
    return strs;
}
// 十进制通过二进制转十六进制 -- 固定位数16
+ (NSString *)changeDataTo16BytesWith11Data:(NSInteger)data{
    NSString *price = [Zm10J16 getHexByBinary:[Zm10J16 getBinaryByDecimal:data]];
    NSString *strs = @"";
    for (int i = 0; i<11-price.length; i++) {
        strs = [strs stringByAppendingString:@"0"];
    }
    strs = [strs stringByAppendingString:price];
    return strs;
}

// 十进制通过二进制转十六进制
+ (NSString *)aboutDataTo16Bytes:(NSInteger)data{
    NSString *price = [Zm10J16 getHexByBinary:[Zm10J16 getBinaryByDecimal:data]];
    return price;
}
// 转16进制位数进行处理-保持两位
+ (NSString *)getStringHexByDecimal:(NSInteger)decimal{
    NSString *str =  [Zm10J16 getHexByDecimal:decimal];
    if (str.length%2==0) {
        return str;
    }else{
        return [NSString stringWithFormat:@"0%@",str];
    }
}

/*
 质押
oterarray 需要质押的数组 包裹字典 （字典包含price 跟 address
noce 交易的Noce值,从账户接口获取，获取到的 noce+1 进行入参
poundage 手续费 开通完权益 不需要手续费
privateKey 私钥
publicKey 公钥
 返回序列化 action 
*/
+ (NSString *)pledgeActionNetworkWithoterarray:(NSArray *)oterarray noce:(NSString *)noce poundage:(int)poundage privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey{
    int lockTimer = [[NSDate getNowTimeTimestamp] intValue];
    NSString *sigs = [self trantingWithActionTypeNum:9 poundage:poundage timestamp:lockTimer noce:noce otherArray:oterarray privateKey:privateKey publicKey:publicKey];
    return sigs;
}

/*
 开通权益
 oterarray 需要质押的数组 包裹字典 （字典包含price 跟 address)
 noce 交易的Noce值,从账户接口获取，获取到的 noce+1 进行入参
 privateKey 私钥
 publicKey 公钥
 返回序列化 actio
 */
+ (NSString *)interestsActionnoNetworkWithoterarray:(NSArray *)oterarray noce:(NSString *)noce privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey{
    int lockTimer = [[NSDate getNowTimeTimestamp] intValue];
    NSString *sigs = [self trantingWithActionTypeNum:4 poundage:0 timestamp:lockTimer noce:noce otherArray:oterarray privateKey:privateKey publicKey:publicKey];
    return sigs;
}
@end
