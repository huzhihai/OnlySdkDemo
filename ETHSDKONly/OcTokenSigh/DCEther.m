//
//  DCEther.m
//  dc
//
//  Created by xm6leefun on 2020/9/17.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import "DCEther.h"
//#import <ethers/ethers.h>
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
//#import "YYKit.h"
#import "DCAcountMsgInfoModel.h"
@implementation DCEther

///  创建
+ (void)dc_createWithPwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey))block{
    
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
        //        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey);
        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey,YES,error);
    }];
}

+ (void)dc_importKeyStore:(NSString *)keyStore pwd:(NSString *)pwd path:(NSString *)path block:(void(^)(NSString *address,NSString *keyStore,NSString *mnemonicPhrase,NSString *privateKey,NSString *publicKey,BOOL suc,HSWalletError error))block{
   
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
        //        block(adress,keyStore,mnemonicPhrase,privateKeyStr,publicKey);
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
+ (void)getOnlyBalanceAddress:(NSString *)address success:(void(^)(id  _Nullable responseObject))successBlock failure:(void(^)(NSError * _Nonnull error))failureBlock{
    NSString *strUrl = [address stringByReplacingOccurrencesOfString:@"oc"withString:@""];
        NSDictionary *dic = @{@"address":strUrl,@"type":@"2"};
     [self postWithUrlString:kgetAcountMsg parameters:dic success:^(id  _Nullable responseObject) {
         successBlock(responseObject);
     } failure:^(NSError * _Nonnull error) {
         failureBlock(error);
     }];
}
+ (void)transArray:(NSArray *)array ActionTypeNum:(int)actionTypeNum poundage:(int)poundage privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey address:(NSString *)address block:(void(^)(BOOL isuc))block{
    
    dispatch_group_t disgroup = dispatch_group_create();
    dispatch_group_enter(disgroup);
    NSString *strUrl = [address stringByReplacingOccurrencesOfString:@"oc"withString:@""];
       NSDictionary *dic = @{@"address":strUrl,@"type":@"2"};
   static NSArray *infoArray;
    [self postWithUrlString:kgetAcountMsg parameters:dic success:^(id  _Nullable responseObject) {
        NSDictionary *dic = responseObject;
        infoArray = dic[@"record"];
        dispatch_group_leave(disgroup);
    } failure:^(NSError * _Nonnull error) {
        dispatch_group_leave(disgroup);
        block(NO);
    }];
    
    dispatch_group_notify(disgroup, dispatch_get_main_queue(), ^{
        int lockTimer = [[NSDate getNowTimeTimestamp] intValue];
        NSDictionary *dicInfo;
        if (infoArray.count>0) {
            dicInfo = infoArray[0];
        }
        NSString *noce = [NSString stringWithFormat:@"%@",dicInfo[@"noce"]];
        int index = noce.intValue+1;
        NSString *message = [OcTokenSigh moretrantingVersion2WithActionTypeNum:actionTypeNum poundage:poundage timestamp:lockTimer noce:[NSString stringWithFormat:@"%d",index] otherArray:array privateKey:privateKey publicKey:publicKey];
        NSDictionary *dic = @{@"action":message};
        if ([message containsString:@"传入key有误"]) {
            return;
        }
        [self postWithUrlString:kreceiveActionAPI2 parameters:dic success:^(id  _Nullable responseObject) {
            NSDictionary *dics =  responseObject;
            NSString *code = [NSString stringWithFormat:@"%@",dics[@"code"]];
            if (code.intValue==200) {
                block(YES);
            }else{
                block(NO);
            }
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
            block(NO);
        }];
    });
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
//GET请求
+ (void)getWithUrlString:(NSString *)url parameters:(id)parameters success:(void(^)(id  _Nullable responseObject))successBlock failure:(void(^)(NSError * _Nonnull error))failureBlock
{
    NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:url];
    if ([parameters allKeys]) {
        [mutableUrl appendString:@"?"];
        for (id key in parameters) {
            NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
        }
    }
    NSString *urlEnCode = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEnCode]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            failureBlock(error);
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            successBlock(dic);
        }
    }];
    [dataTask resume];
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
