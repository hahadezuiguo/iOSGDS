//
//  RootView.m
//  UICollectionView
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 刘洋. All rights reserved.
//

#import "RootView.h"

@implementation RootView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //初始化布局
        [self initLayout];
    }
    
    return self;
}
//初始化布局
- (void)initLayout {
    //1.定义collectionView的样式
    self.myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置属性
    //给定item的大小
    
    self.myFlowLayout.itemSize = CGSizeMake((self.bounds.size.width - 40.1) / 3, (self.bounds.size.width - 40.1) / 3);
    //垂直滚动的间隙：任意两个item的最小间隙
    self.myFlowLayout.minimumInteritemSpacing = 10;
    //水平滚动的间隙：任意两个item的最小间隙
    self.myFlowLayout.minimumLineSpacing = 10;
    //设置滚动方向
    self.myFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直方向
    //设置视图的内边距（上左下右）
    self.myFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //指定头视图的尺寸
    self.myFlowLayout.headerReferenceSize = CGSizeMake(100, 30);//默认是屏幕的宽度，高度自己设定
    //指定尾视图的尺寸
    //self.myFlowLayout.footerReferenceSize = CGSizeMake(100, 10);//默认是屏幕的宽度，高度自己设定

    //2.布局collectionView
    //创建对象并指定样式
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.myFlowLayout];
        self.collectionView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    //添加到父视图
    [self addSubview:self.collectionView];
}

@end
