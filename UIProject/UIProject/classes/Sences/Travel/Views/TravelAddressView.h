//
//  TravelAddressView.h
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelAddressView : UIView
//声明集合视图属性
@property (nonatomic, strong) UICollectionView *collectionView;
//UICollectionViewFlowLayout用来给UICollectionView布局
@property (nonatomic, strong) UICollectionViewFlowLayout *myFolwLayout;
@end
