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
#import "User.h"


@interface LoginViewController ()
//用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
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
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"登录成功" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                User *newUser = [User new];
                newUser.userName = _userNameField.text;
                newUser.password = _passwordField.text;
                newUser.isLogin = YES;
                [UserFileHandle saveUserInfo:newUser];
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:action];
            
            
            alert.message = @"登陆成功";
            [self presentViewController:alert animated:YES completion:nil];
            
            
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
