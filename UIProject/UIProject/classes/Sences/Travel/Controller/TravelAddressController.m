//
//  TravelAddressController.m
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelAddressController.h"
#import "HeaderView.h"
#import "TravelAddressView.h"
#import "TravelAddressCell.h"
#import "TravelCategory.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface TravelAddressController ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) TravelAddressView *travelAddressView;

@end

@implementation TravelAddressController
//定义全局的重用标识符
static NSString *const identifier_cell = @"identifier_cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addHeaderView];
    //设置代理
    self.travelAddressView.collectionView.dataSource = self;
    self.travelAddressView.collectionView.delegate = self;
    
    //注册
    [self.travelAddressView.collectionView registerClass:[TravelAddressCell class] forCellWithReuseIdentifier:identifier_cell];
    
    //注册头视图
    [self.travelAddressView.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
}

-(void)addHeaderView {
    self.headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kWidth/2)];
    [self.view addSubview:self.headerView];
    self.travelAddressView = [[TravelAddressView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kWidth, self.view.frame.size.height - kWidth/2)];
    [self.view addSubview:self.travelAddressView];
    self.headerView.scrollView.delegate = self;
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timer:) userInfo:nil repeats:YES];
}

//实现代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int temp = self.headerView.scrollView.contentOffset.x / kWidth;
    if (temp == 0) {
        self.headerView.scrollView.contentOffset = CGPointMake(6*kWidth, 0);
        self.headerView.pageControl.currentPage = 5;
    }else if (temp == 7) {
        self.headerView.scrollView.contentOffset = CGPointMake(kWidth, 0);
        self.headerView.pageControl.currentPage = 0;
    }else {
        self.headerView.pageControl.currentPage = temp - 1;
    }
}

-(void)timer:(NSTimer *) sendr {
    int temp = self.headerView.scrollView.contentOffset.x / kWidth;
    int index = temp;
    if (temp == 7) {
        self.headerView.scrollView.contentOffset = CGPointMake(kWidth, 0);
        index = 1;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.headerView.scrollView.contentOffset = CGPointMake(kWidth*(index + 1), 0);
    }];
    if (temp == 6) {
        self.headerView.pageControl.currentPage = 0;
    }else {
        self.headerView.pageControl.currentPage = index;
    }
}

//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
//返回每一个item的cell对象
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
    NSArray *array = @[@"演出展览",@"手工制作",@"游乐园",@"亲子游",@"景点",@"早教培训"];
    cell.backgroundColor = [UIColor clearColor];
    cell.addressImage.image = [UIImage imageNamed:array[indexPath.row]];
    cell.addressLabel.text = array[indexPath.row];
    return cell;

}




//点击item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelCategory *travelCateVC = [[TravelCategory alloc]init];
    travelCateVC.index = indexPath.row + 1;
    [self.navigationController pushViewController:travelCateVC animated:YES];
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
