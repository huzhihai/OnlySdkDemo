//
//  OcSecp256k1.m
//  Sign
//
//  Created by xm6leefun on 2020/8/27.
//  Copyright © 2020 xm6leefun. All rights reserved.
//

#import "OcSecp256k1.h"
#import <secp256k1/secp256k1.h>
#import "NSData+HexString.h"
@implementation OcSecp256k1
+ (NSData *)generatePublicKeyWithPrivateKey:(NSData *)privateKeyData compression:(BOOL)isCompression
{
    secp256k1_context *context = secp256k1_context_create(SECP256K1_CONTEXT_SIGN);
    
    const unsigned char *prvKey = (const unsigned char *)privateKeyData.bytes;
    secp256k1_pubkey pKey;
    
    int result = secp256k1_ec_pubkey_create(context, &pKey, prvKey);
    if (result != 1) {
        return nil;
    }
    
    int size = isCompression ? 33 : 65;
    unsigned char *pubkey = malloc(size);
    
    size_t s = size;
    
    result = secp256k1_ec_pubkey_serialize(context, pubkey, &s, &pKey, isCompression ? SECP256K1_EC_COMPRESSED : SECP256K1_EC_UNCOMPRESSED);
    if (result != 1) {
        return nil;
    }
    
    secp256k1_context_destroy(context);
    
    NSMutableData *data = [NSMutableData dataWithBytes:pubkey length:size];
    free(pubkey);
    return data;
}
+ (NSData *)serializeSignData:(NSData *)msgData withPrivateKey:(NSData *)privateKeyData{
    secp256k1_context *context = secp256k1_context_create(SECP256K1_CONTEXT_SIGN);
        const unsigned char *prvKey = (const unsigned char *)privateKeyData.bytes;
        const unsigned char *msg = (const unsigned char *)msgData.bytes;
        NSUInteger inputLength = 72;
        unsigned char *siga = malloc(inputLength);
        secp256k1_ecdsa_signature sig;
        int result = secp256k1_ecdsa_sign(context, &sig, msg, prvKey, secp256k1_nonce_function_rfc6979, NULL);
        //nullptr
//        result = secp256k1_ecdsa_signature_serialize_compact(context, siga, &sig);
    //    unsigned char der[64];
//        size_t derlen = 200;
        unsigned char vchSig[72];
        size_t derlen = sizeof(vchSig);
        result =  secp256k1_ecdsa_signature_serialize_der(context, siga, &derlen,  &sig);
        if (result != 1) {
            return nil;
        }
        secp256k1_context_destroy(context);
        NSMutableData *data = [NSMutableData dataWithBytes:siga length:derlen];
        free(siga);
        return data;
}
+ (NSData *)compactSignData:(NSData *)msgData withPrivateKey:(NSData *)privateKeyData
{
    secp256k1_context *context = secp256k1_context_create(SECP256K1_CONTEXT_SIGN);
    const unsigned char *prvKey = (const unsigned char *)privateKeyData.bytes;
    const unsigned char *msg = (const unsigned char *)msgData.bytes;
    NSUInteger inputLength = 64;
    unsigned char *siga = malloc(inputLength);
    secp256k1_ecdsa_signature sig;
    int result = secp256k1_ecdsa_sign(context, &sig, msg, prvKey, NULL, NULL);
    //nullptr
    result = secp256k1_ecdsa_signature_serialize_compact(context, siga, &sig);
//    unsigned char der[64];
//    size_t derlen = 200;
//    result =  secp256k1_ecdsa_signature_serialize_der(context, siga, &derlen,  &sig);
    
    if (result != 1) {
        return nil;
    }
    
    secp256k1_context_destroy(context);
   
    NSMutableData *data = [NSMutableData dataWithBytes:siga length:inputLength];
    free(siga);
    return data;
}

+ (NSInteger)verifySignedData:(NSData *)sigData withMessageData:(NSData *)msgData usePublickKey:(NSData *)pubKeyData
{
    secp256k1_context *context = secp256k1_context_create(SECP256K1_CONTEXT_VERIFY | SECP256K1_CONTEXT_SIGN);
    
    const unsigned char *sig = (const unsigned char *)sigData.bytes;
    const unsigned char *msg = (const unsigned char *)msgData.bytes;
    
    const unsigned char *pubKey = (const unsigned char *)pubKeyData.bytes;
    
    secp256k1_pubkey pKey;
    int pubResult = secp256k1_ec_pubkey_parse(context, &pKey, pubKey, pubKeyData.length);
    
    if (pubResult != 1) return -3;
    
    secp256k1_ecdsa_signature sig_ecdsa;
    int sigResult = secp256k1_ecdsa_signature_parse_compact(context, &sig_ecdsa, sig);
//    int sigResult = secp256k1_ecdsa_signature_parse_der(context, &sig_ecdsa, sig, sigData.length);
    if (sigResult != 1) return -4;
    
    int result = secp256k1_ecdsa_verify(context, &sig_ecdsa, msg, &pKey);
    
    secp256k1_context_destroy(context);
    return result;
}
+ (NSInteger)verifyderSignedData:(NSData *)sigData withMessageData:(NSData *)msgData usePublickKey:(NSData *)pubKeyData
{
    secp256k1_context *context = secp256k1_context_create(SECP256K1_CONTEXT_VERIFY | SECP256K1_CONTEXT_SIGN);
    
    const unsigned char *sig = (const unsigned char *)sigData.bytes;
    const unsigned char *msg = (const unsigned char *)msgData.bytes;
    
    const unsigned char *pubKey = (const unsigned char *)pubKeyData.bytes;
    
    secp256k1_pubkey pKey;
    int pubResult = secp256k1_ec_pubkey_parse(context, &pKey, pubKey, pubKeyData.length);
    
    if (pubResult != 1) return -3;
    
    secp256k1_ecdsa_signature sig_ecdsa;
    secp256k1_ecdsa_signature outsig_ecdsa ;
//    int sigResult = secp256k1_ecdsa_signature_parse_compact(context, &sig_ecdsa, sig);
    
    /// 外来签名的验证-  可塑性
    int sigResult = secp256k1_ecdsa_signature_parse_der(context, &sig_ecdsa, sig, sigData.length);
    if (sigResult != 1) return -4;
    
    int outResult = secp256k1_ecdsa_signature_normalize(context, &outsig_ecdsa,&sig_ecdsa);
    int keyresult = secp256k1_ec_seckey_verify(context, sig);
    
    int result = secp256k1_ecdsa_verify(context, &outsig_ecdsa, msg, &pKey);
    
    if (result==1) {
        return result;
    }
    if (outResult==1&&keyresult==1) {
        result=1;
    }
    secp256k1_context_destroy(context);
    return result;
}
@end
