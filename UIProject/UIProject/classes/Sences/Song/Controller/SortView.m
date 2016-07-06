//
//  SortView.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "SortView.h"

@implementation SortView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    
    // 创建CollectionView用于展示热门
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // layout 控制布局
    
    // item大小
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.5 - 1, [UIScreen mainScreen].bounds.size.width * 0.5 - 1);
    // 设置行距
    layout.minimumLineSpacing = 2;
    // 设置左右间距
    layout.minimumInteritemSpacing = 0; // 最小间距
    // 内间距(逆时针的方向 方向数据分别为上左下右)
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    
    // header
    //layout.headerReferenceSize = CGSizeMake(100, 200);
    
    
    // 创建CollectionView (默认是黑色)
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //下滑时滚动条消除
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
    
    
    
}

@end
