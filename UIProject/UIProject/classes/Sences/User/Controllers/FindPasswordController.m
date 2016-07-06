//
//  FindPasswordController.m
//  UIProject
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "FindPasswordController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface FindPasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


@end

@implementation FindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self.navigationController setNavigationBarHidden:NO animated:YES];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 根据邮箱找回密码

- (IBAction)findPassword:(id)sender {
    
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    [alert addAction:action];
    
    [AVUser requestPasswordResetForEmailInBackground:_emailTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"邮件发送成功，请注意查收" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                [self.navigationController pushViewController:[] animated:<#(BOOL)#>]
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"输入邮箱错误，请输入正确的邮箱" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
