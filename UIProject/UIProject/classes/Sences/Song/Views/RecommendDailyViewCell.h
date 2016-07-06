//
//  RecommendDailyViewCell.h
//  Project_B
//
//  Created by 魏辉 on 15/7/27.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendDailyViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *myImageView;
@property (nonatomic,strong) UIView *upImageView;
@property (nonatomic,strong) UILabel *imageLabel_one;
@property (nonatomic,strong) UILabel *imageLabel_two;

+ (CGFloat)cellHeight;
@end
