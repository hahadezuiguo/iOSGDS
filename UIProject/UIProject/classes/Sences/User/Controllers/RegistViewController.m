//
//  RegistViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "RegistViewController.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface RegistViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//用户名
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
//重复密码
@property (weak, nonatomic) IBOutlet UITextField *repasswordTextField;
//邮箱地址
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;
//用户地址
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;

@property (nonatomic,strong) UIImagePickerController *imagePicker; //图片选择器

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationController.navigationBar.translucent = NO;
    self.imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.userPhoto.image = image;
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    //dismiss当前的选择页面
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage {
    NSLog(@"存储图片");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 取消

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 注册

- (IBAction)registAction:(id)sender {
    
    if (_userNameTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"用户名不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (_passwordTextField.text.length == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"密码不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if(![_passwordTextField.text isEqualToString:_repasswordTextField.text ]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"前后密码不一样" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
        
        AVUser *user = [AVUser user];// 新建 AVUser 对象实例
        user.username = self.userNameTextField.text;// 设置用户名
        user.password =  self.passwordTextField.text;// 设置密码
        user.email = self.emailAddressTextField.text; //设置邮箱
        NSData *data = UIImageJPEGRepresentation(self.userPhoto.image, 0.5);
        [user setObject:data forKey:@"userPhoto"];
        [user setObject:@"" forKey:@"gender"];
        [user setObject:@"" forKey:@"birthday"];

//        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // 注册成功
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"立即登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil
                 ];
            } else {
                    // 失败的原因可能有多种，常见的是用户名已经存在。
                    //昵称存在
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"该用户已注册" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                    
                }
        }];
        
    }

    
    
}

#pragma mark - 轻触事件

- (IBAction)tapAction:(id)sender {
    
    //调用系统相机/相册
    //添加alertSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示框" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }];
    
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
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
