//
//  SortViewCell.m
//  Project_B
//
//  Created by 魏辉 on 15/7/26.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import "SortViewCell.h"

@implementation SortViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}


- (void)initLayout{
    self.backgroundColor = [UIColor whiteColor];
    
    self.bgPictureView = [[UIImageView alloc] init];
    _bgPictureView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5 - 1, [UIScreen mainScreen].bounds.size.width * 0.5 - 1);
    //_bgPictureView.backgroundColor = [UIColor redColor];
    [self addSubview:_bgPictureView];

    self.sortLabel = [[UILabel alloc] init];
    _sortLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width * 0.5 - 1, [UIScreen mainScreen].bounds.size.width * 0.5 - 1);
    _sortLabel.textAlignment = NSTextAlignmentCenter;
    _sortLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    _sortLabel.textColor = [UIColor whiteColor];
    [self.bgPictureView addSubview:_sortLabel];
    
}

@end
