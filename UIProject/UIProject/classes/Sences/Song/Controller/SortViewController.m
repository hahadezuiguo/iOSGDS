//
//  SortViewController.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "SortViewController.h"
#import "SortView.h"
//#import "ICSDrawerController.h"
#import "SortViewCell.h"
#import "SortDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "SortModel.h"
#import "Reachability.h"
#import "NetWordRequestManager.h"
@interface SortViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)SortView *sortView;
@property (nonatomic,strong)NSMutableArray *sortModelArr;
@property (nonatomic,strong)Reachability *reachabilityManager;
@property (nonatomic,strong)UIView *noNetView;
@end

@implementation SortViewController

- (void)loadView{
    self.sortView = [[SortView alloc] init];
    self.view = _sortView;
}
- (void)viewWillAppear:(BOOL)animated{
    // 设置UINavigationBar的颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"headView"]]];
    // 改变NavigationBar的title的颜色属性方法
    NSDictionary *texrArrtributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationController.navigationBar setTitleTextAttributes:texrArrtributes];
}
- (void)viewWillDisappear:(BOOL)animated{
    // 设置UINavigationBar的颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    // 改变NavigationBar的title的颜色属性方法
    NSDictionary *texrArrtributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:texrArrtributes];
}
- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor cyanColor];
    self.reachabilityManager = [Reachability reachabilityForInternetConnection];
    // 当网络没连接时不解析数据
    if (self.reachabilityManager.currentReachabilityStatus != NotReachable) {
        [self requestData];
    }else {
        self.noNetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
        self.noNetView.backgroundColor = [UIColor cyanColor];
        [self.view addSubview:self.noNetView];
        NSLog(@"******noNet*******");
        UIImageView *batImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 736)];
        batImageView.image = [UIImage imageNamed:@"batMan.jpg"];
        [self.noNetView addSubview:batImageView];
        UIButton *noNet = [UIButton buttonWithType:UIButtonTypeSystem];
        noNet.frame = CGRectMake(142, 340, 130, 65);
        noNet.titleLabel.font = [UIFont systemFontOfSize:18];
        noNet.backgroundColor = [UIColor clearColor];
        noNet.tintColor = [UIColor blackColor];
        [self.noNetView addSubview:noNet];
        [noNet setTitle:@"请重新加载" forState:UIControlStateNormal];
        [noNet addTarget:self action:@selector(reloadAction:) forControlEvents:UIControlEventTouchUpInside];

    }
        
    //设置代理
    self.sortView.collectionView.delegate = self;
    self.sortView.collectionView.dataSource = self;
    // 注册collectionViewCell
    [self.sortView.collectionView registerClass:[SortViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    // 设置标题
    self.navigationItem.title = @"新视角";
}
#pragma mark -  无网络重新加载
- (void)reloadAction:(UIButton *)button{
    //reachability判断网络状态
    if (self.reachabilityManager.currentReachabilityStatus != NotReachable) {
        [self.noNetView removeFromSuperview];
        NSLog(@"=====%@",_sortModelArr);
        [self requestData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.sortModelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    SortViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    SortModel *model = self.sortModelArr[indexPath.row];
    cell.sortLabel.text = model.name;
    NSString *urlStr = model.bgPicture;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    [cell.bgPictureView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:(SDWebImageRetryFailed)];
    
    
    return cell;
    
}

#pragma mark 跳转方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    SortDetailViewController *sortDVC = [[SortDetailViewController alloc] init];
    // 创建Model类用于传值
    SortModel *model = self.sortModelArr[indexPath.row];
    sortDVC.receiveString = model.name;
    sortDVC.sortmodel = model;
    [self.navigationController pushViewController:sortDVC animated:YES];
    

}

// 数据解析方法
- (void)requestData{

    self.sortModelArr = [NSMutableArray array];
    NSString *urlStr = [NSString stringWithFormat:@"http://baobab.wandoujia.com/api/v1/categories?vc=67&u=fccb123580108076556393d900a3d5bfd2e2fc43&v=1.7.0&f=iphone"];
    [NetWordRequestManager requstType:GET urlString:urlStr prama:nil success:^(id data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
        for (NSDictionary *dict in array) {
            SortModel *model = [[SortModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            //            [model setValue:dict[@"bgPicture"] forKey:@"bgPicture"];
            //            [model setValue:dict[@"name"] forKey:@"name"];
            [self.sortModelArr addObject:model];
            
        }
        //异步添加，不会等待
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.sortView.collectionView reloadData];
        });
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
/*
//    [Tool solveDataWithUrlString:urlStr httpMethod:@"GET" httpBody:nil backDataBlock:^(id data) {
//        //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//        
//        for (NSDictionary *dict in array) {
//            SortModel *model = [[SortModel alloc] init];
//            [model setValuesForKeysWithDictionary:dict];
////            [model setValue:dict[@"bgPicture"] forKey:@"bgPicture"];
////            [model setValue:dict[@"name"] forKey:@"name"];
//            [self.sortModelArr addObject:model];
//
//        }
//          [self.sortView.collectionView reloadData];
//        
//    }];
    
*/
}

@end
