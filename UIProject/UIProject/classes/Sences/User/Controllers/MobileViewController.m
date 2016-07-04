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
@interface MobileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *telephoneTextfield;

@property (weak, nonatomic) IBOutlet UITextField *messageTextfield;


@end
#define NUMBERS @"0123456789"

@implementation MobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    // Do any additional setup after loading the view from its nib.
   
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
//
//
//+ (BOOL)valiMobile:(NSString *)mobile{
//    if (mobile.length < 11)
//    {
//        return NO;
//    }else{
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//        
//        if (isMatch1 || isMatch2 || isMatch3) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }
//    return nil;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
