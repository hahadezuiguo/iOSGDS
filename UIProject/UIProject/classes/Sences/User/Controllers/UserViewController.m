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




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    self.rootView = [[CollectionView alloc] initWithFrame:self.colView.frame];
    [self.colView addSubview:self.rootView];
//    [self.view addSubview:self.colView];
    self.navigationController.navigationBar.translucent = YES;
    //注册
    // 第一步 注册cell
    [self.rootView.collection registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.rootView.collection.delegate = self;
    self.rootView.collection.dataSource = self;
    
    NSLog(@"%lf",self.colView.bounds.origin.y);
    [self.collectionSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.index = 4;
    
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
         self.ViewHeight.constant = (370 + (self.index - 1) / 3 * 170);
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
