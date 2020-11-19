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
