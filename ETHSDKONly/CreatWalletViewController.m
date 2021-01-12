//
//  CreatWalletViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/19.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "CreatWalletViewController.h"
#import "OCEther.h"
@interface CreatWalletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation CreatWalletViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)creatWalletAction:(id)sender {
    [OCEther oc_createWithPwd:self.pwdTF.text path:self.pathLabel.text block:^(NSString *address, NSString *keyStore, NSString *mnemonicPhrase, NSString *privateKey, NSString *publicKey) {
           NSLog(@"钱包地址：%@，keyStore：%@,助记词:%@,私钥：%@,公钥:%@ /n 普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账",address,keyStore,mnemonicPhrase,privateKey,publicKey);
       }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
