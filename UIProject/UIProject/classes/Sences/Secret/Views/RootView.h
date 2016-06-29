//
//  RootView.h
//  UICollectionView
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 刘洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootView : UIView
//声明集合视图属性
@property (nonatomic, strong) UICollectionView *collectionView;
//专门给cllectionView布局的（必须有）
@property (nonatomic, strong) UICollectionViewFlowLayout *myFlowLayout;

@end
