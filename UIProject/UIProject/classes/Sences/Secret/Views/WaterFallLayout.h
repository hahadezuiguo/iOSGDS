//
//  WaterFallLayout.h
//  UIProject
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WaterfallDelegate <NSObject>
//声明一个方法返回每个item的高度
- (float)heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFallLayout : UICollectionViewLayout

//item的大小
@property (nonatomic, assign) CGSize itemSize;

//内边距
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

//item的间距
@property (nonatomic, assign) CGFloat spacing;

//列数
@property (nonatomic, assign) NSInteger numberOfColumn;

@property (nonatomic, weak) id<WaterfallDelegate> delegate;


@end
