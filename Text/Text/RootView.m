//
//  RootView.m
//  UILesson15_UICollectionView
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "RootView.h"

@implementation RootView

// 添加头视图，尾视图，需要在RootView中设置size  headerRefrenceSize 



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化布局
        [self initLayout];
    }
    return self;
}

// 初始化布局
- (void)initLayout {
    
    
    // 1.定义collectionView样式
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置属性
    // 给定Item的大小
    self.myFlowLayout.itemSize = CGSizeMake((self.bounds.size.width - 40.1) / 3 , 80);
    // 相邻两个Item之间的最小间隙(垂直滚动)
    self.myFlowLayout.minimumInteritemSpacing = 10;
    // 相邻两个Item之间的最小间距(水平滚动)
    self.myFlowLayout.minimumLineSpacing = 10;
    // 设置滚动方向
//    self.myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;// 垂直方向
//    // 设置视图的内边距(上左下右)
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    // 布局collectionView
    
//    // 布局头视图尺寸
//    self.myFlowLayout.headerReferenceSize = CGSizeMake(30, 80);
//    // 布局尾视图尺寸
//    self.myFlowLayout.footerReferenceSize = CGSizeMake(30 , 40);
    
    
    // 创建对象并指定样式
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds  collectionViewLayout:self.myFlowLayout];
    NSLog(@"%lf",self.bounds.size.width);
    
    self.collectionView.backgroundColor = [UIColor cyanColor];
    
    // 将collectionView添加到视图上
    [self addSubview:self.collectionView];
    
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
