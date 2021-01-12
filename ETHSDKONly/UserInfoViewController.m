//
//  UserInfoViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/20.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "UserInfoViewController.h"
#import "OcTokenPDForehead.h"
@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *noce;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.address.text = @"地址 ：0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd";
    [self getBalance];
}
/// 查询余额
- (void)getBalance{
    __weak typeof(self) weSelf = self;
    [OcTokenPDForehead oc_getOnlyBalanceAddress:@"0b96c1e9a5661c96a5c8647e6945c2a6f5564bcd" success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"record"];
        NSDictionary *dic = array[0];
        NSString *price = dic[@"value"];
       NSString *noce = [NSString stringWithFormat:@"%@",dic[@"noce"]];
        NSLog(@"%@",price);
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程执行
            weSelf.price.text = [NSString stringWithFormat:@"金额 ：%@",price];
            weSelf.textView.text = [NSString stringWithFormat:@"数据返回结果：%@",responseObject];
            weSelf.noce.text = [NSString stringWithFormat:@"noce：%@",noce];;
        });
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
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
