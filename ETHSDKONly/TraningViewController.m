//
//  TraningViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/19.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "TraningViewController.h"
#import "DCEther.h"
@interface TraningViewController ()
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *noceTF;
@property (weak, nonatomic) IBOutlet UITextField *priKeyTF;

@property (nonatomic, copy) NSString *pundege;
@property (weak, nonatomic) IBOutlet UIButton *tranBtn;
@property (weak, nonatomic) IBOutlet UITextView *resutlTexView;
@property (weak, nonatomic) IBOutlet UILabel *poundageLab;

@end

@implementation TraningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pundege = @"0.001";
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@ only",self.pundege];
    self.priKeyTF.text = @"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02";
}
- (IBAction)poundgeaAction:(UISlider *)sender {
    float value = sender.value;
    self.pundege = [NSString stringWithFormat:@"%f only",value];
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@",self.pundege];
}

- (IBAction)tradeBtnAction:(UIButton *)sender {
    NSString *price = self.priceTF.text;
    NSArray *array = @[@{@"address":self.addressTF.text,@"price":price}];
    [DCEther dc_transferArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" noce:self.noceTF.text.intValue poundage:self.pundege block:^(BOOL isuc,id  _Nullable responseObject) {
        if (isuc) {
            NSLog(@"交易完成////普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账");
        }
    }];
}



@end
