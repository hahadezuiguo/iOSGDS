//
//  CollectionView.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化布局
        [self initLayout];
    }
    return self;
}
///初始化布局方法
- (void)initLayout {
    //定义collectionView样式
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置属性
    
    //给定Item大小
    _flowLayout.itemSize = CGSizeMake((self.bounds.size.width - 40.1) / 3, 150);
    //相邻Item之间最小间距
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.minimumLineSpacing = 20; 
      self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //设置滚动方向（垂直方向）
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collection = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
//    NSLog(@"%lf",self.collection.frame.size.width);
    self.collection.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collection];
    
    
}


@end
