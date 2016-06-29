//
//  SongCollectionView.h
//  UIProject
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongCollectionView : UIView
///声明集合视图属性
@property (nonatomic,strong) UICollectionView *collection;

//UICollectionViewFlowLayout用来给collectionView布局
@property (nonatomic,strong)UICollectionViewFlowLayout *collectionFlowLayout;
@end
