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
#import "SongModel.h"
#import "UIImageView+WebCache.h"

#import "DetailViewController.h"
@interface UserViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

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

@property (weak, nonatomic) IBOutlet UIView *hidenView;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) UIScrollView *replaceScrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (nonatomic,assign) BOOL hiden;

//建立大数组
@property (nonatomic,strong) NSMutableArray *allSongArray;

@end

@implementation UserViewController



- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
#pragma mark - navigation的颜色
    // 设置UINavigationBar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self loadData];
    if ([UserFileHandle selectUserInfo].userName.length > 0) {
        //显示用户
        self.userNameLabel.text = [AVUser currentUser].username;
        NSData *data = [[AVUser currentUser] objectForKey:@"userPhoto"];
            self.userPhotoImage.image = [UIImage imageWithData:data];
 
        
    }
 }


- (void)viewDidLoad {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    self.replaceScrollView = self.scrollView;
    self.hiden = NO;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    self.rootView = [[CollectionView alloc] initWithFrame:self.colView.frame];
    [self.colView addSubview:self.rootView];
//    [self.view addSubview:self.colView];
//    self.title = @"";
    self.scrollView.delegate = self;
    
    //注册
    // 第一步 注册cell
    [self.rootView.collection registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.rootView.collection.delegate = self;
    self.rootView.collection.dataSource = self;
    
    NSLog(@"%lf",self.colView.bounds.origin.y);
    [self.collectionSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.index = self.allSongArray.count;
    
   self.ViewHeight.constant = (250 + (self.index - 1) / 3 * 170);


    

    
    [self.collectionSegment setTitle:@"育儿秘籍" forSegmentAtIndex:0];
    [self.collectionSegment setTitle:@"宝贝爱听" forSegmentAtIndex:1];
    [self.collectionSegment setTitle:@"宝贝去哪儿？" forSegmentAtIndex:2];
    
}

- (void)loadData {
    
    
    
    AVUser *currentUser = [AVUser currentUser];
    //    NSLog(@"***%@",currentUser.username);
    
    if ([currentUser.username isEqualToString:@""]) {
        NSLog(@"用户未登录");
    }
    else {
        // 查询当前用户的所有收藏
        AVQuery *query = [AVQuery queryWithClassName:@"Collection"];
        [query whereKey:@"userName" equalTo:currentUser.username];
//        [query whereKey:@"category" equalTo:@"创意"];
        //currentUser.username
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                self.allSongArray = [NSMutableArray array];
                for (AVObject *oneObject in objects) {
                    
                    SongModel *model = [[SongModel alloc] init];
                    model.userName = [oneObject objectForKey:@"userName"];
                    model.title = [oneObject objectForKey:@"title"];
//                    NSLog(@"*****%@",model.title);
                    model.imageUrl = [oneObject objectForKey:@"imageUrl"];
                    model.playUrl = [oneObject objectForKey:@"playUrl"];
//                    NSLog(@"______%@",model.playUrl);
                    model.category = [oneObject objectForKey:@"category"];
                    model.time = [oneObject objectForKey:@"time"];
                    model.myDescription = [oneObject objectForKey:@"myDescription"];
                    model.objectId = [oneObject objectForKey:@"objectId"];
                    NSLog(@"<%@>",model.objectId);
                    [self.allSongArray addObject:model];
                }
                
                [self.rootView.collection reloadData];
                
            }
            else{
                
                NSLog(@"error = %@",error);
            }
        }];
    }
    
    
}



- (void)segmentAction:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;

    switch (index) {
        case 0:
         
              self.index = self.allSongArray.count;
            break;
        case 1:
   
              self.index = self.allSongArray.count;
            break;
        case 2:
    
             self.index = self.allSongArray.count;
            break;
        default:
           
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        //显示
       self.ViewHeight.constant = (190 + (self.index - 1) / 3 * 170);
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
   
    return self.allSongArray.count;
}


//返回每一个分区里面Item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    SongModel *model = self.allSongArray[indexPath.row];
    cell.CollectionTitle.text = model.title;

    [cell.collectionImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    // 创建Model类实现跳转
    SongModel *model = self.allSongArray[indexPath.row];
    detailVC.passPlayUrl = model.playUrl;
    detailVC.passTitle = model.title;
    detailVC.passDescription = model.myDescription;
    detailVC.passImageUrl = model.imageUrl;
    detailVC.passCategory = model.category;
//    SortDetailModel *model = self.allSongArray[indexPath.row];
//        detailVC.passImageUrl = model.coverForDetail;
//        detailVC.passTitle = model.title;
//        detailVC.passDescription = model.videoInformation;
//        detailVC.passPlayUrl = model.playUrl;
//        detailVC.passCategory = model.category;
//        detailVC.passTime = self.timeStr;
    
//    detailVC.myBlock = ^ {
//        [self loadData];
//    };
    [self.navigationController pushViewController:detailVC animated:YES];

}


#pragma mark - 点击进入用户信息详情界面

- (IBAction)tapToUserDetailAction:(id)sender {
    
   
    
    if ([UserFileHandle selectUserInfo].isLogin == YES) {
        
                    //如果不调用 登出 方法，当前用户的缓存将永久保存在客户端。
                                           // 跳转到首页
                        UserDetailViewController *detailVC = [[UserDetailViewController alloc] init];
                        //    detailVC.
        
                        [self.navigationController pushViewController:detailVC animated:YES];
                        
                    } else {
                        //缓存用户对象为空时，可打开用户注册界面…
         
                        LoginViewController *loginVC = [[LoginViewController alloc] init];
                        [self.navigationController pushViewController:loginVC animated:YES];
                    }
        }


#pragma mark - 实现scrollView的代理


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

        if (_scrollView.contentOffset.y > 50) {

            [self.navigationController setNavigationBarHidden:YES animated:YES];
            self.hidenView.hidden = YES;
            _hiden = YES;

            [self hideTabBar];
            self.backgroundView.frame = CGRectMake(0,20, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
            _scrollView.frame = CGRectMake(0, 20, self.scrollView.frame.size.width, self.scrollView.frame.size.height );
            self.scrollView.contentOffset = CGPointMake(0, 0);

            } else
                if (_scrollView.contentOffset.y < 50) {
                    self.hidenView.hidden = NO;
                    self.hiden = YES;
                    [self.navigationController setNavigationBarHidden:NO animated:YES];
                    [self showTabBar];
                    self.backgroundView.frame = CGRectMake(0, 200, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height );
                                self.ViewHeight.constant = self.ViewHeight.constant ;

        
                }


   }

#pragma mark - 隐藏显示tabbar


- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
}


- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
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
