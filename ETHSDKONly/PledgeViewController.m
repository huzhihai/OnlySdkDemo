//
//  PledgeViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/19.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "PledgeViewController.h"
#import "DCEther.h"
@interface PledgeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *poundageLab;
@property (nonatomic, copy) NSString *pundege;
@end

@implementation PledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pundege = @"0.001";
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@ only",self.pundege];
}
- (IBAction)poundageAction:(UISlider *)sender {
    float value = sender.value;
    self.pundege = [NSString stringWithFormat:@"%f only",value];
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@",self.pundege];
}
- (IBAction)pledgeBtnAction:(UIButton *)sender {
    
    NSString *price = self.priceTF.text;
    NSArray *array = @[@{@"address":self.addressTF.text,@"price":price}];
    
    [DCEther dc_pledgeActionNetworkWithArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" noce:0 poundage:@"" block:^(BOOL isuc,id  _Nullable responseObject) {
        if (isuc) {
            NSLog(@"质押完成////普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账");
        }
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
