//
//  CollectionCell.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
//收藏视图
@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
//标题
@property (weak, nonatomic) IBOutlet UILabel *CollectionTitle;

@end
