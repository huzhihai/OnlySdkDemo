//
//  ImportPrivateKeyViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/19.
//  Copyright © 2020 ceshi. All rights reserved.
//

#import "ImportPrivateKeyViewController.h"
#import "DCEther.h"
@interface ImportPrivateKeyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *privateKeyTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation ImportPrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)importAction:(id)sender {
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
