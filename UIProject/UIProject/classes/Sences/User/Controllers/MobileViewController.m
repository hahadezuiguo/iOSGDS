//
//  MobileViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "MobileViewController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

#import "UserViewController.h"

#import "UserFileHandle.h"
@interface MobileViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *telephoneTextfield;

@property (weak, nonatomic) IBOutlet UITextField *messageTextfield;


@end
#define NUMBERS @"0123456789"

@implementation MobileViewController

- (void)viewWillAppear:(BOOL)animated {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view from its nib.
    self.telephoneTextfield.delegate = self;
    self.messageTextfield.delegate = self;
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    //    回收键盘,取消第一响应者
    [self.telephoneTextfield resignFirstResponder];
    [self.messageTextfield resignFirstResponder];
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.telephoneTextfield resignFirstResponder];
    [self.messageTextfield resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 发送验证消息
- (IBAction)sendMessageAction:(id)sender {
    
    if (self.telephoneTextfield.text.length == 11 && [self validateNumber:_telephoneTextfield.text]) {
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"信息发送成功" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [AVOSCloud requestSmsCodeWithPhoneNumber:_telephoneTextfield.text callback:^(BOOL succeeded, NSError *error) {
                NSLog(@"error = %@",error);
            }];
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"请输入正确的手机号码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [AVOSCloud requestSmsCodeWithPhoneNumber:_telephoneTextfield.text callback:^(BOOL succeeded, NSError *error) {
                NSLog(@"error = %@",error);
            }];
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    
}

#pragma mark - 验证消息后登录
- (IBAction)loginActtion:(id)sender {
    
    [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:_telephoneTextfield.text smsCode:_messageTextfield.text  block:^(AVUser *user, NSError *error) {
        // 如果 error 为空就可以表示登录成功了，并且 user 是一个全新的用户
        if (error == nil) {
            User *newUser = [User new];
            newUser.userName = _telephoneTextfield.text;
            newUser.password = @"";
            newUser.isLogin = YES;
            [UserFileHandle saveUserInfo:newUser];

            [user setObject:@"123456" forKey:@"password"]   ;
            UserViewController *userVC = [[UserViewController alloc] init];
            [self.navigationController pushViewController:userVC animated:YES];
        }
    }];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    return [self validateNumber:string];
//}
//
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


- (IBAction)bakcAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
