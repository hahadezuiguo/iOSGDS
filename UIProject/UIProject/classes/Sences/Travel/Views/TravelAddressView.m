//
//  TravelAddressView.m
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelAddressView.h"
@implementation TravelAddressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}



-(void)initLayout {
    //1.定义collectionView的样式
    self.myFolwLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置属性
    //2.给定item的大小
    self.myFolwLayout.itemSize = CGSizeMake((self.bounds.size.width - 40.00000000001)/3 , self.frame.size.height/2.8);
    //每两个item的最小间隙(垂直)
    self.myFolwLayout.minimumInteritemSpacing = 10;
    //每两个item的最小间隙(水平)
    self.myFolwLayout.minimumLineSpacing = 10;
    //设置滚动方向
    self.myFolwLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//垂直方向
    //设置视图内边距（上左下右）
    self.myFolwLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //布局头视图尺寸
    self.myFolwLayout.headerReferenceSize = CGSizeMake(30, 10);
    
    //布局尾视图
    self.myFolwLayout.footerReferenceSize = CGSizeMake(202, 40);
    
    
    //布局collectionView
    //创建对象并指定样式
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.myFolwLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
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
