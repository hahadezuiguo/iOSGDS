//
//  SecretViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "SecretViewController.h"
#import "SDCycleScrollView.h"
#import "RootView.h"
#import <AFNetworking.h>
#import "URL.h"
#import "ListModel.h"
#import "CollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "HeadCollectionReusableView.h"
#import "HealthModel.h"
#import "CookModel.h"
#import "ClassViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kSpace 8

@interface SecretViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) RootView *rootView;
// 声明可变数组存放解析出的育儿课堂数据
@property (nonatomic, strong) NSMutableArray *allDataArray;
// 声明可变数组存放解析出的健康护理数据
@property (nonatomic, strong) NSMutableArray *allHealthData;
//声明可变数组存放解析出的营养饮食数据
@property (nonatomic, strong) NSMutableArray *allCookData;

@property (nonatomic, strong) UIScrollView *mainScroll;

@end

@implementation SecretViewController
//懒加载
-(NSMutableArray *)allDataArray {
    
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
//懒加载
- (NSMutableArray *)allHealthData{
    if (!_allHealthData) {
        _allHealthData = [NSMutableArray array];
    }
    return _allHealthData;
}
//懒加载
- (NSMutableArray *)allCookData{
    if (!_allCookData) {
        _allCookData = [NSMutableArray array];
    }
    return _allCookData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.mainScroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.mainScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 50);
    [self.view addSubview:self.mainScroll];
    [self initcycle];
    
    self.rootView = [[RootView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*0.3, [UIScreen mainScreen].bounds.size.width, 290)];
    [self.mainScroll addSubview:self.rootView];
    

    self.navigationController.navigationBar.translucent = NO;
    self.rootView.collectionView.delegate = self;
    self.rootView.collectionView.dataSource = self;
    //注册cell
    [self.rootView.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册collectionView的头视图
    [self.rootView.collectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView"];
    
    //育儿课堂网络请求
    [self netClassRequest];
    //健康护理网络请求
    [self netHealthRequest];
    //营养饮食网络请求
    [self netCookRequest];
    
    
    // 集成刷新控件
    //[self setupRefresh];
       
}
////下拉刷新
//- (void)setupRefresh{
//    
//    UIRefreshControl *downControl = [[UIRefreshControl alloc] init];
//    [downControl addTarget:self action:@selector(downChange:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:downControl];
//    [downControl beginRefreshing];
//    [self downChange:downControl];
//}
////下拉刷新触发的方法
//- (void)downChange:(UIRefreshControl *)control{
//    
//    [self netClassRequest];
//    [control endRefreshing];
//    
//}

//
- (void)initCook{
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.rootView.frame), [UIScreen mainScreen].bounds.size.width - 16, 2)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.mainScroll addSubview:lineLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLabel.frame) + 2, 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"营养饮食";
    [self.mainScroll addSubview:titleLabel];
    
    //"更多"按钮
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    moreButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, CGRectGetMinY(titleLabel.frame), 60, 30);
    [self.mainScroll addSubview:moreButton];
    
    UIScrollView *cookScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(moreButton.frame) + 4, [UIScreen mainScreen].bounds.size.width, 200)];
    cookScroll.contentSize = CGSizeMake(kWidth * 3, 200);
    
    
    for (int i = 0; i < self.allCookData.count; i++) {
        CookModel *model = self.allCookData[i];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * (kSpace + (kWidth * 3 - 20 - kSpace * (self.allCookData.count - 1)) / self.allCookData.count), 0, (kWidth * 3 - 20 - kSpace * (self.allCookData.count - 1)) / self.allCookData.count, (kWidth * 3 - 20 - kSpace * (self.allCookData.count - 1)) / self.allCookData.count)];
        imageV.layer.cornerRadius = 20;
        imageV.layer.masksToBounds = YES;
        imageV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imageurl]]];
        [cookScroll addSubview:imageV];
        
    }

   [self.mainScroll addSubview:cookScroll];
    
}

//轮播图
- (void)initcycle{
    
    UIScrollView *headScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*0.3)];
    headScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 5, 0);
    
    [self.mainScroll addSubview:headScroll];

    NSArray *imageNames = @[@"head1.jpg",
                            @"head2.jpg",
                            @"head3.jpg",
                            @"head4.jpg",
                            @"head5.jpg"
                            ];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:headScroll.frame shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [headScroll addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
   
}

//网络请求育儿课堂
- (void)netClassRequest{
    
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:SECRET_LIST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [responseObject[@"list"] firstObject][@"list"];
        if (array.count > 0) {
            
            for (int i = 0; i < 3; i++) {
                NSDictionary *dict = array[i];
                ListModel *model = [ListModel new];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allDataArray addObject:model];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.rootView.collectionView reloadData];
            });
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据请求失败");
    }];
 
}
//健康护理网络请求
- (void)netHealthRequest{
    
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:HEALTH_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (int i = 0; i < 3; i++) {
                HealthModel *model = [[HealthModel alloc] init];
                NSDictionary *dict = array[i];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allHealthData addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.rootView.collectionView reloadData];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"健康护理数据请求失败");
    }];

    
}

//营养饮食网络请求
- (void)netCookRequest{
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:COOK_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dict in array) {
                CookModel *model = [[CookModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allCookData addObject:model];
            }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf initCook];
        });
        }
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"营养饮食请求失败");
    }];
    
}
//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 2;
}
//每个分区的
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.allDataArray.count;
            break;
        case 1:
            return self.allHealthData.count;
            break;
            
        default:
            return 1;
            break;
    }
    
    return 1;
    
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:{
            ListModel *model = self.allDataArray[indexPath.row];
            cell.listTitle.text = model.title;
            
            [cell.listImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
            break;}
        case 1:{
            HealthModel *model = self.allHealthData[indexPath.row];
            cell.listTitle.text = model.title;
            [cell.listImage sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
            
            break;}
            
        default:
            break;
    }
    return cell;
 
}
////头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                
                HeadCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
                
                header.titlesLabel.text = @"育儿课堂";
                [header.moreButton setTitle:@"更多" forState:UIControlStateNormal];
                [header.moreButton addTarget:self action:@selector(classMore) forControlEvents:UIControlEventTouchUpInside];
                return header;
            }
        }
        case 1:{
        
            if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
                
                HeadCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
                
                header.titlesLabel.text = @"健康护理";
                [header.moreButton setTitle:@"更多" forState:UIControlStateNormal];
                return header;
                
            }

      
            }
            default:
            return nil;
            break;
    }
    return nil;
}

//育儿课堂：“更多”按钮的点击事件
- (void)classMore{
    __weak typeof(self)weakSelf = self;
    ClassViewController *classVC = [[ClassViewController alloc] init];
    
    [UIView animateWithDuration:0.8f animations:^{
        //weakSelf.view.frame = CGRectMake(-500, 100, 0, 0);
        weakSelf.view.center = CGPointMake(-500, 0);
    } completion:^(BOOL finished) {
        [self.navigationController pushViewController:classVC animated:NO];
    }];
    
    
    
    
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
