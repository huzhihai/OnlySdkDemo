//
//  TraningViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/19.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "TraningViewController.h"
#import "OcTokenPDForehead.h"
@interface TraningViewController ()
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *noceTF;
@property (weak, nonatomic) IBOutlet UITextField *priKeyTF;

@property (nonatomic, copy) NSString *pundege;
@property (weak, nonatomic) IBOutlet UIButton *tranBtn;
@property (weak, nonatomic) IBOutlet UILabel *poundageLab;
@property (weak, nonatomic) IBOutlet UITextView *conteTextView;

@end

@implementation TraningViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pundege = @"0.001";
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@ only",self.pundege];
//    self.priKeyTF.text = @"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02";
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
            self.noceTF.text = noce;
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (IBAction)poundgeaAction:(UISlider *)sender {
    float value = sender.value;
    self.pundege = [NSString stringWithFormat:@"%.9f",value];
    self.poundageLab.text = [NSString stringWithFormat:@"手续费：%@ only" ,self.pundege];
}

- (IBAction)tradeBtnAction:(UIButton *)sender {
    NSString *price = self.priceTF.text;
    NSArray *array = @[@{@"address":self.addressTF.text,@"price":price}];
    //f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc03
//f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc02
    [OcTokenPDForehead oc_transferArray:array privateKey:@"f759e9ba4112b0609b14e2e9d164b585084ea9e9c051b6782d416009b269cc03" noce:self.noceTF.text.intValue poundage:self.pundege block:^(BOOL isuc,id  _Nullable responseObject,id _Nullable sigh,id _Nullable payNum) {
        if (isuc) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程执行
                self.conteTextView.text = [NSString stringWithFormat:@"sigh:\n %@ \n 交易数量(亿为单位)：\n %@ \n 返回成功数据: \n %@",sigh,payNum,responseObject];
            });
            
            NSLog(@"交易完成////普通用户转账需要手续费即可发起交易，高级账号需要开通权益5000可以免手续费转账");
        }
    }];
}



@end
