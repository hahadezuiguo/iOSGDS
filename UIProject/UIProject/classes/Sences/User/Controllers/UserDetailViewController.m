//
//  UserDetailViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "UserDetailViewController.h"

#import "ImageCell.h"
#import "NormalCell.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

#import "LoginViewController.h"
#import "UserFileHandle.h"
#import "ChangeUserNameController.h"

#define kImageCell @"ImageCell"
#define kNormalCell @"NormalCell"
#import "ConnectMobileViewController.h"
@interface UserDetailViewController ()  <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.imagePicker = [[UIImagePickerController alloc] init];
  
    self.imagePicker.delegate = self;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    NSData *data = [[AVUser currentUser] objectForKey:@"userPhoto"];
    self.userPhoto.image = [UIImage imageWithData:data];
    //注册cell
    [self.infoTableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:kImageCell];
    [self.infoTableView registerNib:[UINib nibWithNibName:@"NormalCell" bundle:nil] forCellReuseIdentifier:kNormalCell];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 实现代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NormalCell *normalCell = [tableView dequeueReusableCellWithIdentifier:kNormalCell forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0:
            normalCell.userName.text = [[AVUser currentUser] objectForKey:@"nikName"];
            break;
        case 1:
            normalCell.normalLabel.text = @"绑定邮箱";
            normalCell.userName.text = [[AVUser currentUser] objectForKey:@"email"];
            break;
        case 2:{
            normalCell.normalLabel.text = @"绑定手机号";
//          normalCell.userName.text = [[AVUser currentUser] objectForKey:@"mobilePhoneNumber"];
            NSString *string = [[AVUser currentUser] objectForKey:@"mobilePhoneNumber"];
            if (string.length == 0) {
                normalCell.userName.text = @"未绑定手机号";
            } else {
                normalCell.userName.text = string;
            }
        }

                  default:
            break;
    }
    return normalCell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 40;
}


- (IBAction)tapAction:(id)sender {
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ChangeUserNameController *changeVC = [[ChangeUserNameController alloc] init];
        changeVC.myBlock = ^ (NSString *str) {
            [[AVUser currentUser] setObject:str forKey:@"nikName"];
            [tableView reloadData];
            
        };
        
        [self.navigationController pushViewController:changeVC animated:YES];
    } else if (indexPath.row == 2) {
        
        ConnectMobileViewController *connectVC = [[ConnectMobileViewController alloc] init];
        
        connectVC.myBlock = ^(NSString *str) {
            [tableView reloadData];
        };
        [self.navigationController pushViewController:connectVC animated:YES];
        
    }
    
    
    
}


- (IBAction)logoutACtion:(id)sender {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    [UserFileHandle selectUserInfo].isLogin = NO;
    [UserFileHandle deleteUserInfo];
    
    
    [AVUser logOut];
    AVUser *currentUser = [AVUser currentUser];
    //如果不调用 登出 方法，当前用户的缓存将永久保存在客户端。
    if (currentUser != nil) {
        // 跳转到首页
    } else {
        //缓存用户对象为空时，可打开用户注册界面…
        [self.navigationController pushViewController:loginVC animated:YES];
    }

}

#pragma mark - 实现imagePicker的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.userPhoto.image = image;
    NSData *data = UIImageJPEGRepresentation(self.userPhoto.image, 0.5);
   
    [[AVUser currentUser] setObject:data forKey:@"userPhoto"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    }
    //dismiss当前的选择页面
    [picker dismissViewControllerAnimated:YES completion:nil];
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
