//
//  SortDetailViewCell.h
//  Project_B
//
//  Created by 魏辉 on 15/7/30.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortDetailViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *myImageView; //存放图片
@property (nonatomic,strong) UIView *upImageView; //在图片上添加view控制透明度
@property (nonatomic,strong) UILabel *imageLabel_one; //图片标题
@property (nonatomic,strong) UILabel *imageLabel_two; // 图片分类和播放信息


+ (CGFloat)cellHeight; // 类方法控制cell高度
@end
