//
//  ViewController.m
//  ETHSDKONly
//
//  Created by 胡志海 on 2020/11/12.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "ViewController.h"
#import "DCEther.h"

#define kYdecimalNum(x) [[[NSDecimalNumber decimalNumberWithString:x] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100000000"]] stringValue]

@interface ViewController ()

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *keyStore;
@property (nonatomic,copy) NSString *mnemonicPhrase;
@property (nonatomic,copy) NSString *privateKey;
@property (nonatomic,copy) NSString *publicKey;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self getBalance];
    
}
- (void)creatWallet{
    [DCEther dc_createWithPwd:@"aa1234" path:@"" block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, NSString *publicKey) {
        
    }];
}
/// 查询余额
- (void)getBalance{
    [DCEther getOnlyBalanceAddress:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
/// 交易
- (void)traning{
    NSString *price = kYdecimalNum(@"0.00001");
       NSArray *array = @[@{@"address":@"a7ed1688bb395bb358eedd2d80078137ca17fdde",@"price":price}];
       [DCEther transArray:array ActionTypeNum:1 poundage:10000 privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" publicKey:@"025ad47e065ca397461ffb5231885a5cbdef6f1b4d3ad9b50413869f9311a75b09" address:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" block:^(BOOL isuc) {
           if (isuc) {
               NSLog(@"交易完成");
           }
       }];
}

@end
