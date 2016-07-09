//
//  LoginViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "LoginViewController.h"

#import "RegistViewController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

#import "FindPasswordController.h"

#import "UserFileHandle.h"

#import "MobileViewController.h"

#import "UserViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
//用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    self.passwordField.secureTextEntry = YES;
    self.passwordField.delegate = self;
    self.userNameField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
//    回收键盘,取消第一响应者
    [self.userNameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.passwordField resignFirstResponder];
    [self.userNameField resignFirstResponder];
}


#pragma mark - 登录


                                        - (IBAction)loginAction:(id)sender {
    
    
    [AVUser logInWithUsernameInBackground:_userNameField.text password:_passwordField.text block:^(AVUser *user, NSError *error) {
        
        
        if ([_userNameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""]) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"登录失败" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            
            
            alert.message = @"用户名或密码不能为空";
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        else if (user != nil) {

                User *newUser = [User new];
                newUser.userName = _userNameField.text;
                newUser.password = _passwordField.text;
                newUser.isLogin = YES;
                [UserFileHandle saveUserInfo:newUser];

                [self.navigationController popToRootViewControllerAnimated:YES];

            
            
        } else {
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"登录失败" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            
            
            alert.message = @"该用户尚未注册或密码错误";
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }];

    
       
    
}

#pragma mark - 注册

- (IBAction)registAction:(id)sender {
    
    RegistViewController *registVC = [[RegistViewController alloc] init];
    
    registVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    [self presentViewController:registVC animated:YES completion:nil];

    
}

#pragma mark - 忘记密码选项

- (IBAction)forgetPasswordAction:(id)sender {
    
    FindPasswordController *findVC = [[FindPasswordController alloc] init];
    [self.navigationController pushViewController:findVC animated:YES];

    
}
#pragma mark - 取消
- (IBAction)cancelAction:(id)sender {
    UserViewController *userVC = [[UserViewController alloc] init];
    [self.navigationController pushViewController:userVC animated:YES];
//s     [self.navigationController popToRootViewControllerAnimated:YES];
//    [self presentViewController:userVC animated:YES completion:nil];
}



- (IBAction)loginWithTelephone:(id)sender {
    MobileViewController *mobileVC = [[MobileViewController alloc] init];
    mobileVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.navigationController pushViewController:mobileVC animated:YES];
    
}



- (IBAction)hidenPassword:(id)sender {
    if (self.passwordField.secureTextEntry == NO) {
         self.passwordField.secureTextEntry = YES;
    } else {
        self.passwordField.secureTextEntry = NO;
    }
   
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
