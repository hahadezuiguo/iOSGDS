//
//  UserViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "UserViewController.h"
#import "CollectionView.h"
#import "CollectionCell.h"

#import "RegistViewController.h"
#import "LoginViewController.h"

#import "User.h"
#import "UserFileHandle.h"

#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

#import "UserDetailViewController.h"

@interface UserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

///收藏栏
@property (weak, nonatomic) IBOutlet UISegmentedControl *collectionSegment;

///用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;
///用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;


@property (weak, nonatomic) IBOutlet UIView *colView;


@property (nonatomic,strong) CollectionView *rootView;

@property (nonatomic,assign) NSInteger index;
@end

@implementation UserViewController



- (void)viewWillAppear:(BOOL)animated {
    if ([UserFileHandle selectUserInfo].userName.length > 0) {
        //显示用户
        self.userNameLabel.text = [AVUser currentUser].username;
        NSData *data = [[AVUser currentUser] objectForKey:@"userPhoto"];
            self.userPhotoImage.image = [UIImage imageWithData:data];
 

    }
 }


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    self.rootView = [[CollectionView alloc] initWithFrame:self.colView.frame];
    [self.colView addSubview:self.rootView];
//    [self.view addSubview:self.colView];

    
    //注册
    // 第一步 注册cell
    [self.rootView.collection registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.rootView.collection.delegate = self;
    self.rootView.collection.dataSource = self;
    
    NSLog(@"%lf",self.colView.bounds.origin.y);
    [self.collectionSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.index = 4;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(loginOrLogout:)];
    
    [self.collectionSegment setTitle:@"育儿秘籍" forSegmentAtIndex:0];
    [self.collectionSegment setTitle:@"宝贝爱听" forSegmentAtIndex:1];
    [self.collectionSegment setTitle:@"宝贝去哪儿？" forSegmentAtIndex:2];
    
}

//右按钮实现方法

- (void)loginOrLogout:(UIBarButtonItem *)sender {
    
    if ([UserFileHandle selectUserInfo].isLogin == YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1  =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
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
            
            
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    

    
    
}



- (void)segmentAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
         
             self.index = 4;
            break;
        case 1:
   
             self.index = 3;
            break;
        case 2:
    
            self.index = 4;
            break;
        default:
           
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //显示
         self.ViewHeight.constant = (220 + (self.index - 1) / 3 * 170);
    });

   
    
    [self.rootView.collection reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    return self.index;
}


//返回每一个分区里面Item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}



#pragma mark - 点击进入用户信息详情界面

- (IBAction)tapToUserDetailAction:(id)sender {
    
    UserDetailViewController *detailVC = [[UserDetailViewController alloc] init];
//    detailVC.
    [self.navigationController pushViewController:detailVC animated:YES];
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
