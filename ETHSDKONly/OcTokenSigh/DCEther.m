//
//  DCEther.m
//  dc
//
//  Created by xm6leefun on 2020/9/17.
//  Copyright © 2020 xm6leefun. All rights reserved.
//
#define kgetAcountMsg @"V_2_0_0/Account/getUserAccount"//  获取用户信息api
#define kreceiveActionAPI2 @"V_2_0_0/Action/receiveAction" //  交易api
#define Bip44Path @"m/44’/65535/0’/0/0"

#define kYdecimalNum(x) [[[NSDecimalNumber decimalNumberWithString:x] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100000000"]] stringValue]
#import "DCEther.h"
#import <CoreImage/CoreImage.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import "CommonCrypto/CommonCryptor.h"
#import "OcSecp256k1.h"
#import "NSData+Hashing.h"
#import "OcSecp256k1.h"
#import <NSData+Hashing.h>
#import "NSData+HexString.h"
#import "Zm10J16.h"
#import "OcSecp256k1.h"
#import "NSMutableDictionary+ITWExtend.h"
#import "NSDictionary+ITWExtend.h"
#import "NSDate+add.h"

@implementation DCEther

///  创建
+ (void)dc_createWithPwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey))block{
    if (path.length==0) {
        path = Bip44Path;
    }
    [self hs_createWithPwd:pwd path:path block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey) {
        NSString  *privateKeyStr = [privateKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        ///  转成data
        NSData *data = [self hexStringToData:privateKeyStr];
        NSData *pulData =  [OcSecp256k1 generatePublicKeyWithPrivateKey:data compression:YES];
        NSString *publicKey = [self dataToHexStringWithData:pulData];
        ///公钥转成 地址
        NSData *publicData = [self hexStringToData:publicKey];
        NSData *hash256 = [publicData SHA256Hash];
        NSData *hash160 = [hash256 RIPEMD160Hash];
        NSString *adress = [self dataToHexStringWithData:hash160];
        adress = [NSString stringWithFormat:@"oc%@",adress];
        publicKey = [publicKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey);
    }];
  
}

+ (void)dc_inportMnemonics:(NSString *)mnemonics pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block{
    if (path.length==0) {
        path = Bip44Path;
    }
    [self hs_inportMnemonics:mnemonics pwd:pwd path:path block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        NSString  *privateKeyStr = [privateKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        ///  转成data
        NSData *data = [self hexStringToData:privateKeyStr];
        NSData *pulData =  [OcSecp256k1 generatePublicKeyWithPrivateKey:data compression:YES];
        NSString *publicKey = [self dataToHexStringWithData:pulData];
        ///公钥转成 地址
        NSData *publicData = [self hexStringToData:publicKey];
        NSData *hash256 = [publicData SHA256Hash];
        NSData *hash160 = [hash256 RIPEMD160Hash];
        NSString *adress = [self dataToHexStringWithData:hash160];
        adress = [NSString stringWithFormat:@"oc%@",adress];
        publicKey = [publicKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey,YES,error);
    }];
}

+ (void)dc_importKeyStore:(NSString *)keyStore pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block{
   if (path.length==0) {
       path = Bip44Path;
   }
    [self hs_importKeyStore:keyStore pwd:pwd path:path block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
       NSString  *privateKeyStr = [privateKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        ///  转成data
        NSData *data = [self hexStringToData:privateKeyStr];
        NSData *pulData =  [OcSecp256k1 generatePublicKeyWithPrivateKey:data compression:YES];
        NSString *publicKey = [self dataToHexStringWithData:pulData];
        ///公钥转成 地址
        NSData *publicData = [self hexStringToData:publicKey];
        NSData *hash256 = [publicData SHA256Hash];
        NSData *hash160 = [hash256 RIPEMD160Hash];
        NSString *adress = [self dataToHexStringWithData:hash160];
        adress = [NSString stringWithFormat:@"oc%@",adress];
        publicKey = [publicKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey,YES,error);
    }];
}

+(void)dc_importWalletForPrivateKey:(NSString *)privateKey
                                pwd:(NSString *)pwd
                              block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block{
    [self hs_importWalletForPrivateKey:privateKey pwd:pwd block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, BOOL suc, HSWalletError error) {
        NSString  *privateKeyStr = [privateKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        ///  转成data
        NSData *data = [self hexStringToData:privateKeyStr];
        NSData *pulData =  [OcSecp256k1 generatePublicKeyWithPrivateKey:data compression:YES];
        NSString *publicKey = [self dataToHexStringWithData:pulData];
        ///公钥转成 地址
        NSData *publicData = [self hexStringToData:publicKey];
        NSData *hash256 = [publicData SHA256Hash];
        NSData *hash160 = [hash256 RIPEMD160Hash];
        NSString *adress = [self dataToHexStringWithData:hash160];
        adress = [NSString stringWithFormat:@"oc%@",adress];
        publicKey = [publicKey stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey,YES,error);
    }];
}

/*
交易，质押，权益 ,根据 actionTypeNum 判断

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

array 包裹字典 （字典包含price  跟 address）,对方的信息

@[{@"address":@"a7ed1688bb395bb358eedd2d80078137ca17fdde",@"price":@"0.01"}]
 
*/
+ (void)transArray:(NSArray *)array ActionTypeNum:(int)actionTypeNum privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address block:(void(^)(BOOL isuc))block{
    if (privateKey.length==0||publicKey.length==0||address.length==0||array.count==0) {
        block(NO);
        return;
    }
    dispatch_group_t disgroup = dispatch_group_create();
    dispatch_group_enter(disgroup);
    NSString *strUrl = [address stringByReplacingOccurrencesOfString:@"oc"withString:@""];
    NSDictionary *dic = @{@"address":strUrl,@"type":@"2"};
    static NSArray *infoArray;
    /// 请求noce
    [self postWithUrlString:kgetAcountMsg parameters:dic success:^(id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        infoArray = dic[@"record"];
        dispatch_group_leave(disgroup);
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(disgroup);
        block(NO);
    }];
    NSDictionary *dicInfo;
    if (infoArray.count>0) {
        dicInfo = infoArray[0];
    }
   static NSString *poundages = @"0";
    NSString *rightValue = [NSString stringWithFormat:@"%@",dicInfo[@"rightValue"]];
    NSString *qrM = kYdecimalNum(@"5000");
    if (rightValue.integerValue<qrM.integerValue) {
        dispatch_group_enter(disgroup);
        /// 请求手续费
        [self postWithUrlString:@"V_2_0_0/Node/getNodeInfo" parameters:dic success:^(id  _Nullable responseObject) {
            NSDictionary *dic = responseObject[@"record"];
            if ([[dic allKeys] containsObject:@"poundage"]) {
                poundages = dic[@"poundage"];
            }
            dispatch_group_leave(disgroup);
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(disgroup);
            block(NO);
        }];
    }
    ///  进行交易
    dispatch_group_notify(disgroup, dispatch_get_main_queue(), ^{
        int lockTimer = [[NSDate getNowTimeTimestamp] intValue];
        NSDictionary *dicInfo;
        if (infoArray.count>0) {
            dicInfo = infoArray[0];
        }
        NSString *noce = [NSString stringWithFormat:@"%@",dicInfo[@"noce"]];
        int index = noce.intValue+1;
        NSString *message = [OcTokenSigh trantingWithActionTypeNum:actionTypeNum poundage:poundages timestamp:lockTimer noce:[NSString stringWithFormat:@"%d",index] otherArray:array privateKey:privateKey publicKey:publicKey];
        NSDictionary *dic = @{@"action":message};
        if ([message containsString:@"传入key有误"]) {
            block(NO);
            return;
        }
        [self postWithUrlString:kreceiveActionAPI2 parameters:dic success:^(id  _Nullable responseObject) {
            NSDictionary *dics =  responseObject;
            NSString *code = [NSString stringWithFormat:@"%@",dics[@"code"]];
            NSLog(@"%@",responseObject);
            if (code.intValue==200) {
                block(YES);
            }else{
                block(NO);
            }
        } failure:^(NSError * _Nonnull error) {
            block(NO);
        }];
    });
}

/// 查询only  余额  
+ (void)dc_getOnlyBalanceAddress:(NSString *)address success:(void(^)(id  _Nullable responseObject))successBlock failure:(void(^)(NSError * _Nonnull error))failureBlock{
    NSString *strUrl = [address stringByReplacingOccurrencesOfString:@"oc"withString:@""];
    if (strUrl.length==0) {
        NSError *error;
        failureBlock(error);
        return;
    }
    NSDictionary *dic = @{@"address":strUrl.length==0?@"":strUrl,@"type":@"2"};
    [self postWithUrlString:kgetAcountMsg parameters:dic success:^(id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
///  交易
+ (void)dc_transferArray:(NSArray *)array privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address block:(void(^)(BOOL isuc))block{
    [self transArray:array ActionTypeNum:1 privateKey:privateKey publicKey:publicKey address:address block:^(BOOL isuc) {
        block(isuc);
    }];
}
/// 开通权益
+ (void)dc_interestsActionWithPrice:(NSString *)price privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address block:(void(^)(BOOL isuc))block{
    NSString *strUrl = [address stringByReplacingOccurrencesOfString:@"oc"withString:@""];
    NSArray *array = @[@{@"address":strUrl.length==0?@"":strUrl.length>0?address:@"",@"price":price.length==0?@"0":price}];
    [self transArray:array ActionTypeNum:4 privateKey:privateKey publicKey:publicKey address:address block:^(BOOL isuc) {
        block(isuc);
    }];
}
/// 质押
+ (void)dc_pledgeActionNetworkWithArray:(NSArray *)array privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address block:(void(^)(BOOL isuc))block{
    [self transArray:array ActionTypeNum:9 privateKey:privateKey publicKey:publicKey address:address block:^(BOOL isuc) {
        block(isuc);
    }];
}


///  string转成bytes
+ (NSData *)hexStringToData:(NSString *)hexString
{
    const char *chars = [hexString UTF8String];
    int i = 0;
    int len = (int)hexString.length;
    NSMutableData *data = [NSMutableData dataWithCapacity:len/2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i<len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    
    return data;
}
///  bytes 转成string
+ (NSString *)dataToHexStringWithData:(NSData *)data
{
    NSUInteger len = [data length];
    char *chars = (char *)[data bytes];
    NSMutableString *hexString = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < len; i++) {
        [hexString appendString:[NSString stringWithFormat:@"%0.2hhx", chars[i]]];
    }
    return hexString;
}


//POST请求 使用NSMutableURLRequest可以加入请求头
+ (void)postWithUrlString:(NSString *)url parameters:(id)parameters success:(void(^)(id  _Nullable responseObject))successBlock failure:(void(^)(NSError * _Nonnull error))failureBlock
{
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    NSString *urls =  [NSString stringWithFormat:@"%@%@",providsBaseUrl,url];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urls] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //设置请求类型
    request.HTTPMethod = @"POST";
    
    //将需要的信息放入请求头 随便定义了几个
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Authorization"];//token
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lng"];//坐标 lng
    //    [request setValue:@"xxx" forHTTPHeaderField:@"Gis-Lat"];//坐标 lat
    //         [request setValue:@"xxx" forHTTPHeaderField:@"Version"];//版本
    //    NSLog(@"POST-Header:%@",request.allHTTPHeaderFields);
    
    //把参数放到请求体内
    NSString *postStr = [self dicToString:parameters];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/javascript" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
   
    request.HTTPBody = [postStr dataUsingEncoding:NSUTF8StringEncoding];    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) { //请求失败
            failureBlock(error);
        } else {  //请求成功
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];  //开始请求
    
    
}
+ (NSData *)compactFormatDataForDictionary:(NSDictionary *)dicJson

{
    
    if (![dicJson isKindOfClass:[NSDictionary class]]) {
        
        return nil;
        
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];
    
    if (![jsonData isKindOfClass:[NSData class]]) {
        
        return nil;
        
    }
    
    return jsonData;
    
}
+ (NSString *)dicToString:(NSDictionary *)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}
@end
