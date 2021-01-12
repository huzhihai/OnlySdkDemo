//
//  PledgeViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/19.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "PledgeViewController.h"
#import "OcTokenPDForehead.h"
@interface PledgeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UILabel *poundageLab;
@property (nonatomic, copy) NSString *pundege;
@property (weak, nonatomic) IBOutlet UITextField *noce;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


@end

@implementation PledgeViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil]; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pundege = @"0.001";
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@ only",self.pundege];
    
    [OcTokenPDForehead oc_getOnlyBalanceAddress:@"a7ed1688bb395bb358eedd2d80078137ca17fdde" success:^(id  _Nullable responseObject) {
           NSArray *infoArray;
           NSDictionary *dic = responseObject;
           infoArray = dic[@"record"];
           NSDictionary *dicInfo;
           if (infoArray.count>0) {
               dicInfo = infoArray[0];
           }
        /*
        noce 可以接口请求，根据目前所交易的数量自增1:
         例如: 交易了10笔 则noce为10，下次交易需要增加1 为 noce=11 传入进行交易
         如果 提交的 noce 超过自增的noce  就会被挂起。不会被提交上联，如果自增的noce 在2分钟内，能够连串 起来则可以被提交上联
         noce 连串的例子
         当前的noce为12   如果输入的是14 进行提交，这个时候则会被挂起
         当在2两分钟内，再次提交了一笔 noce==13 ,则 noce 13 跟 14 这两笔交易则会被提交上链。
         如果在2分钟内都没有进行连串起来，则被遗弃
         
         */
          NSString *noce = [NSString stringWithFormat:@"%@",dicInfo[@"noce"]];
           int index = noce.intValue+1;
           noce = [NSString stringWithFormat:@"%d",index];
           dispatch_async(dispatch_get_main_queue(), ^{
               //主线程执行
               self.noce.text = noce;
           });
       } failure:^(NSError * _Nonnull error) {
           
       }];
    
}
- (IBAction)poundageAction:(UISlider *)sender {
    float value = sender.value;
    self.pundege = [NSString stringWithFormat:@"%.9f",value];
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@ only" ,self.pundege];
}
- (IBAction)pledgeBtnAction:(UIButton *)sender {
    
    NSString *price = self.priceTF.text;
    NSArray *array = @[@{@"address":self.addressTF.text,@"price":price}];
    
    [OcTokenPDForehead oc_pledgeActionNetworkWithArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02" noce:self.noce.text.intValue poundage:self.pundege block:^(BOOL isuc,id  _Nullable responseObject,id _Nullable sigh,id _Nullable payNum) {
        if (isuc) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程执行
                self.contentTextView.text = [NSString stringWithFormat:@"sigh:\n %@ \n 交易数量(亿为单位)：\n %@ \n 返回成功数据: \n %@",sigh,payNum,responseObject];
            });
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
