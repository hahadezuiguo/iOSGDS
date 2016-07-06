//
//  RecommendDailyViewCell.m
//  Project_B
//
//  Created by 魏辉 on 15/7/27.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import "RecommendDailyViewCell.h"

@implementation RecommendDailyViewCell

// 重写初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 布局方法
- (void)p_setupView{

    self.myImageView = [[UIImageView alloc] init];
    _myImageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.width * 777) / 1242);
    [self addSubview:_myImageView];
    
    self.upImageView = [[UIView alloc] init];
    _upImageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, CGRectGetHeight(_myImageView.frame));
    _upImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.myImageView addSubview:_upImageView];
    
    
    self.imageLabel_one = [[UILabel alloc] init];
    _imageLabel_one.frame = CGRectMake(0,CGRectGetHeight(_myImageView.frame) * 0.4,CGRectGetWidth(_myImageView.frame),CGRectGetHeight(_myImageView.frame) * 0.2);
    _imageLabel_one.textAlignment = NSTextAlignmentCenter;
    _imageLabel_one.textColor = [UIColor whiteColor];
    
    
    self.imageLabel_two = [[UILabel alloc] init];
    _imageLabel_two.frame = CGRectMake(0, CGRectGetMaxY(_imageLabel_one.frame) - 10, CGRectGetWidth(_imageLabel_one.frame), CGRectGetHeight(_imageLabel_one.frame));
    _imageLabel_two.textAlignment = NSTextAlignmentCenter;
    _imageLabel_two.font = [UIFont systemFontOfSize:10];
    _imageLabel_two.textColor = [UIColor whiteColor];
    [self.upImageView addSubview:_imageLabel_one];
    [self.upImageView addSubview:_imageLabel_two];
    
    
    
    
}


+ (CGFloat)cellHeight{

    return ([[UIScreen mainScreen] bounds].size.width * 777) / 1242;
}


@end
