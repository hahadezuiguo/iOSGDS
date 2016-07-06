//
//  ShareBabyViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ShareBabyViewController.h"

#import "WaterfallModel.h"
#import "WaterFallLayout.h"
#import "WaterfallCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+Opens.h"

@interface ShareBabyViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, WaterfallDelegate>

//声明大数组存放所有数据
@property (nonatomic, strong) NSMutableArray *allDataArray;
//定义collectionView；
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *images;

@end

@implementation ShareBabyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
//懒加载
- (NSMutableArray *)allDataArray{
    
    if (_allDataArray == nil) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //读取数据
    [self loadData];
    //初始化布局
    [self initLayout];
    
    [self.collectionView registerClass:[WaterfallCollectionViewCell class] forCellWithReuseIdentifier:@"waterCell"];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(bubbingLove) userInfo:nil repeats:YES];
    
    _images = @[@"ic_menu_bluepig",
                @"ic_menu_bluepig2",
                @"ic_menu_greenpig",
                @"ic_menu_greenpig2",
                @"ic_menu_pinkpig",
                @"ic_menu_pinkpig2",
                @"ic_menu_purplepig",
                @"ic_menu_purplepig2",
                @"ic_menu_yellowpig",
                @"ic_menu_yellowpig2"];


}

-(void)bubbingLove{
    [self.view bubbingImage:[UIImage imageNamed:@"love"]];
    [self.view bubbingImages:_images];
}

//读取数据
- (void)loadData {
    //第一步：获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"waterfall" ofType:@"plist"];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
    //第四步：遍历数组，将数据转为model对象
    for (NSDictionary *dict in dataArray) {
        //创建model对象
        WaterfallModel *model = [[WaterfallModel alloc] init];
        //KVC赋值
        [model setValuesForKeysWithDictionary:dict];
        //将model添加到大数组
        [self.allDataArray addObject:model];
        
    }
   
}

//初始化布局
- (void)initLayout {
    //1.创建UICollectionView的布局样式对象
    WaterFallLayout *water = [[WaterFallLayout alloc] init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 40) / 3;
    water.itemSize = CGSizeMake(width, width);
    //设置内边距
    water.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //设置间距
    water.spacing = 10;
    //设置有多少列
    water.numberOfColumn = 3;
    //设置代理
    water.delegate = self;
    
    //2.布局UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:water];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    
}
//设置section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

//设置每个分区的Item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allDataArray.count;
    
}
//返回每个Item的cell对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterfallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"waterCell" forIndexPath:indexPath];
    //设置cell数据
    WaterfallModel *model = self.allDataArray[indexPath.row];
    
    NSURL *urlString = [NSURL URLWithString:model.img];
    [cell.waterImage sd_setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
    
    
    return cell;
}

//实现代理方法，返回每个Item的高度
-(float)heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterfallModel *model = self.allDataArray[indexPath.row];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 40) / 3;
    //计算Item高度
    CGFloat height = model.h / model.w * width;
    return height;

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
