//
//  WaterFlowLayout.h
//  UILesson15_瀑布流
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFlowLayoutDelegate <NSObject>

//返回每一个item的高度
-(CGFloat)heightFOrItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WaterFlowLayout : UICollectionViewLayout

//item 的 大小，需要根据这个获取宽度
@property (nonatomic, assign) CGSize itemSize;

//内边距的设置
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

//item 的间距(这里水平方向和垂直方向间距一样)
@property (nonatomic, assign) CGFloat spacing;

//列数
@property (nonatomic, assign) NSInteger numberOfColumn;

//设置代理，用于获取item的高度
@property (nonatomic, weak) id<WaterFlowLayoutDelegate> delegate;
@end
