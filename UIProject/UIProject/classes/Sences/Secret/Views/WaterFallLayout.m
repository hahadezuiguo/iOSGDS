//
//  WaterFallLayout.m
//  UIProject
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "WaterFallLayout.h"

@interface WaterFallLayout ()

//item数量
@property (nonatomic, assign) NSInteger numberOfItems;

//保存每个Item的信息
@property (nonatomic, strong) NSMutableArray *allDataArray;

//每列的高度
@property (nonatomic, strong) NSMutableArray *heightOfColumn;

//当前最长列
-(NSInteger)indexOfLongestColumn;

//当前最短列
-(NSInteger)indexOfShortestColumn;

@end

@implementation WaterFallLayout
//懒加载
- (NSMutableArray *)allDataArray{
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (NSMutableArray *)heightOfColumn{
    if (_heightOfColumn == nil) {
        _heightOfColumn = [NSMutableArray array];
    }
    return _heightOfColumn;
}

//当前最长列
-(NSInteger)indexOfLongestColumn{
    NSInteger index = 0;
    float length = 0;
    for (int i = 0; i < self.heightOfColumn.count; i++) {
        float currentLength = [self.heightOfColumn[i] floatValue];
        if (currentLength >= length) {
            length = currentLength;
            index = i;
        }
    }
    
    return index;
}

//当前最短列
-(NSInteger)indexOfShortestColumn{
    
    NSInteger index = 0;
    float length = MAXFLOAT;
    for (int i = 0; i < self.heightOfColumn.count; i++) {
        float currentLength = [self.heightOfColumn[i] floatValue];
        if (currentLength <= length) {
            length = currentLength;
            index = i;
        }
    }
    return index;
}

//重写以下三个方法
//准备布局，在这里计算每个Item的frame
- (void)prepareLayout{
    
    //item的数量
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];
    //每一列添加一个top高度
    for (int i = 0; i < self.numberOfColumn; i++) {
        self.heightOfColumn[i] = @(self.sectionInsets.top);
    }
    //依次为每个item设置位置信息，存储在数组中
    for (int i = 0; i < self.numberOfItems; i++) {
      //找到最短列
        NSInteger shortestInedx = [self indexOfShortestColumn];
        //计算X ，目标x = 内边距左间距+（宽+item间距）*最短列下标
        CGFloat detailX = self.sectionInsets.left + shortestInedx * (self.itemSize.width + self.spacing);
        //计算最短列的高度
        CGFloat height = [self.heightOfColumn[shortestInedx] floatValue];
        //计算Y
        CGFloat detailY = height + self.spacing;
        //创建indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //调用代理方法计算高度
        CGFloat itemHeight = 0;
        if (_delegate && [_delegate respondsToSelector:@selector(heightForItemAtIndexPath:)]) {
            itemHeight = [_delegate heightForItemAtIndexPath:indexPath];
        }
        //定义保存位置信息的对象
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        //生成frame
        attributes.frame = CGRectMake(detailX, detailY, self.itemSize.width, itemHeight);
        //将位置信息添加到数组
        [self.allDataArray addObject:attributes];
        //更新这一行的高度
        self.heightOfColumn[shortestInedx] = @(detailY + itemHeight);
       
    }
    
}

//返回UICollectionView的大小
- (CGSize)collectionViewContentSize{
    
    //求最高列的下标
    NSInteger heightestIndex = [self indexOfLongestColumn];
    //最高列的高度
    CGFloat height = [self.heightOfColumn[heightestIndex] floatValue];
    //拿到collectionView的原始大小
    CGSize size = self.collectionView.frame.size;
    size.height = height + self.sectionInsets.bottom;
    return size;
    
}

//返回每个item的位置信息
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.allDataArray;
 
}




@end
