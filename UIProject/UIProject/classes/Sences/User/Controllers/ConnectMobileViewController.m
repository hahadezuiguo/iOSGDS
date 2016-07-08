//
//  ConnectMobileViewController.m
//  UIProject
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ConnectMobileViewController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface ConnectMobileViewController ()
//手机号码
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
//验证码输入
@property (weak, nonatomic) IBOutlet UITextField *checkingTextfield;

@end

@implementation ConnectMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 获取验证码
- (IBAction)checkAction:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    if (self.mobileTextfield.text.length == 11 && [self validateNumber:self.mobileTextfield.text]) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"消息发送成功" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[AVUser currentUser] setObject:self.mobileTextfield.text forKey:@"mobilePhoneNumber"];
            [AVUser requestMobilePhoneVerify:self.mobileTextfield.text withBlock:^(BOOL succeeded, NSError *error) {
                if(succeeded){
                    //发送成功
//                    alert.message  = @"发送成功";
                    [AVUser requestLoginSmsCode:self.mobileTextfield.text withBlock:^(BOOL succeeded, NSError *error) {
                        
                    }];
                } else {
                    NSLog(@"error = %@", error);
                }
            }];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"请输入正确的手机号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
}

#pragma mark - 验证并绑定
- (IBAction)connectAction:(id)sender {
    
    [AVUser verifyMobilePhone:self.checkingTextfield.text withBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            //验证成功
             self.myBlock(self.mobileTextfield.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置只能输入数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
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
