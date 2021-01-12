//
//  DeserializationViewController.m
//  ETHSDKONly
//
//  Created by xm6leefun on 2020/11/20.
//  Copyright © 2020 ceshi. All rights reserved.
//
#import "DeserializationViewController.h"
#import "OcTokenPDForehead.h"
@interface DeserializationViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation DeserializationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [OcTokenPDForehead oc_getQueryBlockListWithBlock:@"104036" success:^(id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject==nil) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程执行
            self.contentTextView.text = [NSString stringWithFormat:@"区块信息 %@",responseObject];
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
