//
//  ViewController.m
//  ETHSDKONly
//
//  Created by 胡志海 on 2020/11/12.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "ViewController.h"
#import "DCEther.h"
#import "TraningViewController.h"
#import "PledgeViewController.h"
#import "CreatWalletViewController.h"
#import "ImportMnemonicViewController.h"
#import "ImportKeystoreViewController.h"
#import "ImportPrivateKeyViewController.h"
#define Bip44Path @"m/44’/65535/0’/0/0"
@interface ViewController ()

@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *keyStore;
@property (nonatomic,copy) NSString *mnemonicPhrase;
@property (nonatomic,copy) NSString *privateKey;
@property (nonatomic,copy) NSString *publicKey;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

///  交易
- (IBAction)transferAction:(UIButton *)sender {
//    [self traning];
    TraningViewController *vc = [TraningViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}
/// 开通权益
- (IBAction)inteAction:(UIButton *)sender {
    [self interests];
}
/// 质押
- (IBAction)pledgeAction:(id)sender {
//    [self pledge];
    PledgeViewController *vc = [PledgeViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}
// 查询
- (IBAction)balanceAction:(id)sender {
    [self getBalance];
}
//创建钱包
- (IBAction)creatWalletAction:(id)sender {
//    [self creatWallet];
    CreatWalletViewController *vc = [CreatWalletViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)importWalletAction:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"导入钱包" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *mnemonicAction = [UIAlertAction actionWithTitle:@"助记词导入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ImportMnemonicViewController *vc = [ImportMnemonicViewController new];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *keystoreAction = [UIAlertAction actionWithTitle:@"keystore导入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ImportKeystoreViewController *vc = [ImportKeystoreViewController new];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *privateKeyAction = [UIAlertAction actionWithTitle:@"私钥导入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ImportPrivateKeyViewController *vc = [ImportPrivateKeyViewController new];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *canceAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:mnemonicAction];
    [alertVC addAction:keystoreAction];
    [alertVC addAction:privateKeyAction];
    [alertVC addAction:canceAction];
    [self presentViewController:alertVC animated:YES completion:^{}];
}

// 创建钱包
- (void)creatWallet{
    [DCEther dc_createWithPwd:@"aa1234" path:Bip44Path block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, NSString *publicKey) {
        NSLog(@"钱包地址：%@，keyStore：%@,助记词:%@,私钥：%@,公钥:%@ /n 普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账",address,keyStore,mnemonicPhrase,privateKey,publicKey);
    }];
}
/// 查询余额
- (void)getBalance{
    __weak typeof(self) weSelf = self;
   
    [DCEther dc_getOnlyBalanceAddress:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"record"];
        NSDictionary *dic = array[0];
        NSString *price = dic[@"value"];
        NSLog(@"%@",price);
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程执行
             weSelf.priceLab.text = [NSString stringWithFormat:@"%@",price];
        });
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
            NSLog(@"交易完成////普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账");
        }
    }];
}
/// 开通权益
- (void)interests{
    [DCEther dc_interestsActionWithPrice:@"5000" privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" publicKey:@"025ad47e065ca397461ffb5231885a5cbdef6f1b4d3ad9b50413869f9311a75b09" address:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" block:^(BOOL isuc) {
        if (isuc) {
            NSLog(@"开通权益完成////普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账");
        }
    }];
}
///  质押
- (void)pledge{
    NSString *price =@"1";
    NSArray *array = @[@{@"address":@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd",@"price":price}];
    [DCEther dc_pledgeActionNetworkWithArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" publicKey:@"025ad47e065ca397461ffb5231885a5cbdef6f1b4d3ad9b50413869f9311a75b09" address:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" block:^(BOOL isuc) {
        if (isuc) {
            NSLog(@"质押完成////普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账");
        }
    }];
}
@end
