//
//  ViewController.m
//  ETHSDKONly
//
//  Created by 胡志海 on 2020/11/12.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "ViewController.h"
#import "DCEther.h"

#define Bip44Path @"m/44’/65535/0’/0/0"
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
    
    [self traning];
    
}
- (void)creatWallet{
    [DCEther dc_createWithPwd:@"aa1234" path:Bip44Path block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, NSString *publicKey) {
        
    }];
}
/// 查询余额
- (void)getBalance{
    [DCEther dc_getOnlyBalanceAddress:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
/// 交易
- (void)traning{
    NSString *price =@"0.00001";
    NSArray *array = @[@{@"address":@"a7ed1688bb395bb358eedd2d80078137ca17fdde",@"price":price}];
    [DCEther dc_transferArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" publicKey:@"025ad47e065ca397461ffb5231885a5cbdef6f1b4d3ad9b50413869f9311a75b09" address:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" block:^(BOOL isuc) {
        if (isuc) {
            NSLog(@"交易完成");
        }
    }];
}
/// 开通权益
- (void)interests{
    [DCEther dc_interestsActionWithPrice:@"5000" privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" publicKey:@"025ad47e065ca397461ffb5231885a5cbdef6f1b4d3ad9b50413869f9311a75b09" address:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" block:^(BOOL isuc) {
        if (isuc) {
            NSLog(@"开通权益完成");
        }
    }];
}
///  质押
- (void)pledge{
    NSString *price =@"1";
    NSArray *array = @[@{@"address":@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd",@"price":price}];
    [DCEther dc_pledgeActionNetworkWithArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" publicKey:@"025ad47e065ca397461ffb5231885a5cbdef6f1b4d3ad9b50413869f9311a75b09" address:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" block:^(BOOL isuc) {
        if (isuc) {
            NSLog(@"质押完成");
        }
    }];
}
@end
