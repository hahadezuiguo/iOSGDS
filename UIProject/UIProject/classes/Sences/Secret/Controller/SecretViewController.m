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
#import "DB_URL.h"
#import "ListModel.h"
#import "CollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "HeadCollectionReusableView.h"
#import "HealthModel.h"
#import "CookModel.h"
#import "ClassViewController.h"
#import <MBProgressHUD.h>
#import "HealthViewController.h"
#import "ClassDetailViewController.h"
#import "HealthDetailViewController.h"
#import "CookDetailViewController.h"
#import <MBProgressHUD.h>
#import "ShareBabyViewController.h"
#import "SheetView.h"
#import "SheetModel.h"
#import "AdviceController.h"


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kSpace 8
#define kItemSize ([UIScreen mainScreen].bounds.size.width - 40.1) / 3

@interface SecretViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate,SheetViewDelegate>

@property (nonatomic, strong) RootView *rootView;
// 声明可变数组存放解析出的育儿课堂数据
@property (nonatomic, strong) NSMutableArray *allDataArray;
// 声明可变数组存放解析出的健康护理数据
@property (nonatomic, strong) NSMutableArray *allHealthData;
//声明可变数组存放解析出的营养饮食数据
@property (nonatomic, strong) NSMutableArray *allCookData;

@property (nonatomic, strong) UIScrollView *mainScroll;

@property (nonatomic, strong) UIScrollView *cookScroll;
//sheetArray
@property (nonatomic, strong) NSArray *sheetArray;


@end

@implementation SecretViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
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
//懒加载
- (NSArray *)sheetArray{
    if (_sheetArray == nil) {
        _sheetArray = [NSArray array];
    }
    return _sheetArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePicture)];
    
    self.mainScroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.mainScroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 620);
    self.mainScroll.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self.view addSubview:self.mainScroll];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self initcycle];
    
    self.rootView = [[RootView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width*0.3, [UIScreen mainScreen].bounds.size.width, kItemSize * 2 + 100)];
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
    
    //sheetarray
    [self initSheet];
    
        
}

- (void)initSheet{
    
    SheetModel *model1 = [[SheetModel alloc] init];
    model1.title = @"美图欣赏";
    model1.myImage = [UIImage imageNamed:@"sheet1.jpg"];
    
    SheetModel *model2 = [[SheetModel alloc] init];
    model2.title = @"宝宝健身";
    model2.myImage = [UIImage imageNamed:@"sheet2.jpg"];
    
    SheetModel *model3 = [[SheetModel alloc] init];
    model3.title = @"宝宝爱喝粥";
    model3.myImage = [UIImage imageNamed:@"sheet3.jpg"];
    
    SheetModel *model4 = [[SheetModel alloc] init];
    model4.title = @"建议箱";
    model4.myImage = [UIImage imageNamed:@"sheet4.jpeg"];
    
    self.sheetArray = @[model1, model2, model3, model4];
    
}

//晒baby
- (void)sharePicture{
  
    SheetView *sheetView = [[SheetView alloc] initWithInforArray:self.sheetArray];
    sheetView.delegate = self;
    [sheetView showInView:nil];
    
}
//sheetView的代理方法
- (void)selectedRow:(NSInteger)index{
    self.tabBarController.tabBar.hidden = YES;
    switch (index) {
        case 0:{
            ShareBabyViewController *shareVC = [[ShareBabyViewController alloc] init];
            [self.navigationController pushViewController:shareVC animated:YES];
            break;}
        case 1:{
            ShareBabyViewController *shareVC = [[ShareBabyViewController alloc] init];
            [self.navigationController pushViewController:shareVC animated:YES];
            break;}
        case 2:{
//            MeunViewController *shareVC = [[MeunViewController alloc] init];
//            [self.navigationController pushViewController:shareVC animated:YES];
          break;}
        case 3:{
            AdviceController *adviceVC = [[AdviceController alloc] init];
            [self.navigationController pushViewController:adviceVC animated:YES];
            break;}
            
        default:
            break;
    }
    
}


//
- (void)initCook{
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(self.rootView.frame), [UIScreen mainScreen].bounds.size.width - 16, 2)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.mainScroll addSubview:lineLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLabel.frame) + 2, 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"营养饮食";
    [self.mainScroll addSubview:titleLabel];
    
    
    self.cookScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 4, [UIScreen mainScreen].bounds.size.width, 200)];
    self.cookScroll.contentSize = CGSizeMake(kWidth * 3, 200);
    self.cookScroll.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    for (int i = 0; i < self.allCookData.count; i++) {
       CookModel *model = self.allCookData[i];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tapGesture.delegate = self;
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * (kSpace + (kWidth * 3 - 20 - kSpace * (self.allCookData.count - 1)) / self.allCookData.count), 0, (kWidth * 3 - 20 - kSpace * (self.allCookData.count - 1)) / self.allCookData.count, (kWidth * 3 - 20 - kSpace * (self.allCookData.count - 1)) / self.allCookData.count)];
        imageV.tag = i;
        imageV.layer.cornerRadius = 20;
        imageV.layer.masksToBounds = YES;
        [imageV sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"placeHold"]];

           imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:tapGesture];
        [self.cookScroll addSubview:imageV];
        
    }

   [self.mainScroll addSubview:self.cookScroll];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    CookDetailViewController *cookVC = [[CookDetailViewController alloc] init];
    NSInteger index = tap.view.tag;
 
        CookModel *model = self.allCookData[index];
        cookVC.model = model;
        [self.navigationController pushViewController:cookVC animated:YES];
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
    //1.创建url
    NSURL *url = [NSURL URLWithString:HEALTH_URL];
    //2.创建请求
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    //2.5核心设置body
    NSString *bodyString = HEALTH_URL_BODY;
    NSData *postData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [mutableRequest setHTTPMethod:@"POST"];
    [mutableRequest setHTTPBody:postData];
    //3.创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    //4.创建task对象
    NSURLSessionDataTask *task = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //5.解析
        if (error == nil) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (int i = 0; i < 3; i++) {
                NSDictionary *dict = array[i];
                HealthModel *model = [HealthModel new];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allHealthData addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.rootView.collectionView reloadData];
            });
            
        }
    }];
    //6.启动任务
    [task resume];

}

//营养饮食网络请求
- (void)netCookRequest{
    
    NSArray *array = @[@{@"title" : @"母乳", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index2_1.html", @"imageurl" : @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1467882901&di=ea5e83790fdf3904e1c67317bdbfe92b&src=http://www.ys137.com/uploads/allimg/151106/3132-151106123938.jpg"},
                       @{@"title" : @"奶粉", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index2_2.html", @"imageurl" : @"http://images.9518.com/pimg/1361280217195.jpg"},
                       @{@"title" : @"母乳加奶粉", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index2_3.html", @"imageurl" : @"http://www.thmz.com/liv_loadfile/folder811/folder818/folder826/fold6/1263787404_03267300.jpg"},
                       @{@"title" : @"辅食", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index2_4.html", @"imageurl" : @"http://www.shaowu.gov.cn/swbbs/data/attachment/forum/201212/03/112056b8yy8sodbb6s16ss.jpg"},
                       @{@"title" : @"转奶", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index2_5.html", @"imageurl" : @"http://e.hiphotos.baidu.com/exp/w=500/sign=d9127c7b45166d223877159476220945/3b87e950352ac65c9cd19dc3fdf2b21192138aae.jpg"},
                       @{@"title" : @"断奶", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index2_6.html", @"imageurl" : @"http://c.hiphotos.baidu.com/exp/w=480/sign=63d0eb2fb63533faf5b6922698d3fdca/1ad5ad6eddc451dafbc36ecab1fd5266d01632dd.jpg"},
                       @{@"title" : @"营养基础", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index9_1.html", @"imageurl" : @"http://www.ishowx.com/uploads/allimg/150112/38-150112153602.jpg"},
                       @{@"title" : @"饮食结构", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index9_2.html", @"imageurl" : @"http://www.ys137.com/uploads/allimg/140513/3094-140513094Q6105.jpg"},
                       @{@"title" : @"断奶营养", @"weburl" : @"http://www.e-learningclass.com/appdata/ChildrensHospital/web/index9_3.html", @"imageurl" : @"http://img3.imgtn.bdimg.com/it/u=1709001126,2693481655&fm=21&gp=0.jpg"}
                                 ];
    
              for (NSDictionary *dict in array) {
                CookModel *model = [[CookModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.allCookData addObject:model];
            }
    
                [self initCook];
            
    
    
   
    
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
            
        case 1:
            return self.allHealthData.count;
            
        default:
            return 1;
    }
    
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    switch (indexPath.section) {
        case 0:{
            ListModel *model = self.allDataArray[indexPath.row];
            cell.listTitle.text = model.title;
            
            [cell.listImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
            
            return cell;
            break;}
        case 1:{
            HealthModel *model = self.allHealthData[indexPath.row];
            cell.listTitle.text = model.title;
            [cell.listImage sd_setImageWithURL:[NSURL URLWithString:model.images[0]] placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
           
            return cell;
            break;}
            
        default:
            break;
    }
    return cell;
 
}
////头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeadCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headView" forIndexPath:indexPath];
        header.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    switch (indexPath.section) {
        case 0:{
            
                header.titlesLabel.text = @"育儿课堂";
                [header.moreButton setTitle:@"更多" forState:UIControlStateNormal];
            [header.moreButton setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            [header.moreButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [header.moreButton removeTarget:self action:@selector(classMore) forControlEvents:UIControlEventTouchUpInside];
                 [header.moreButton addTarget:self action:@selector(classMore) forControlEvents:UIControlEventTouchUpInside];
            
            
           
                break;
            
        }
        case 1:{
            header.titlesLabel.text = @"健康护理";
            [header.moreButton setTitle:@"更多" forState:UIControlStateNormal];
            [header.moreButton removeTarget:self action:@selector(healthMore) forControlEvents:UIControlEventTouchUpInside];
                [header.moreButton addTarget:self action:@selector(healthMore) forControlEvents:UIControlEventTouchUpInside];
            
            break;
      
            }
            default:
            
            break;
    }
        return header;
    }
   return nil;
}

//育儿课堂：“更多”按钮的点击事件
- (void)classMore{
    __weak typeof(self)weakSelf = self;
    ClassViewController *classVC = [[ClassViewController alloc] init];
    
    [UIView animateWithDuration:0.7f animations:^{

        weakSelf.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -900);
            } completion:^(BOOL finished) {
                
    [weakSelf.navigationController pushViewController:classVC animated:NO];
    
    }];
    
}

//健康护理：“更多”按钮的点击事件
- (void)healthMore{
    
    __weak typeof(self)weakSelf = self;
 HealthViewController *healthVC = [[HealthViewController alloc] init];
    
    [UIView animateWithDuration:0.7f animations:^{
        weakSelf.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, -900);
    } completion:^(BOOL finished) {
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:healthVC animated:NO];
        weakSelf.hidesBottomBarWhenPushed = NO;
       
    }];
}

//collectionView 的click事件 section->row
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ClassDetailViewController *detailVC = [[ClassDetailViewController alloc] init];
        ListModel *model = self.allDataArray[indexPath.row];
        detailVC.model = model;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else{
        HealthDetailViewController *healthVC = [[HealthDetailViewController alloc] init];
        HealthModel *model = self.allHealthData[indexPath.row];
        healthVC.model = model;
        [self.navigationController pushViewController:healthVC animated:YES];
    }
    
    
}


@end
