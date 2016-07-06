//
//  DetailView.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{

    self.backgroundColor = [UIColor lightGrayColor];
    

    // 添加imageView用于存放请求的图片
    self.myImageView = [[UIImageView alloc] init];
    _myImageView.frame = CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width - 60);
    //_myImageView.backgroundColor = [UIColor whiteColor];
    // 设置图片的中心点
    _myImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, ([UIScreen mainScreen].bounds.size.width - 60) / 2 + 44);
    _myImageView.userInteractionEnabled = YES;
    //_myImageView.backgroundColor = [UIColor orangeColor];
    //[_myImageView setImage:[UIImage imageNamed:@"bg2.jpg"]];
    [self addSubview:_myImageView];
    
    // 为展示图片添加playButton
    self.playButton = [[UIButton alloc] init];
    _playButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.4, ([UIScreen mainScreen].bounds.size.width - 60) * 0.4, [[UIScreen mainScreen] bounds].size.width * 0.2, [[UIScreen mainScreen] bounds].size.width * 0.2);
    [_playButton setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
    [self.myImageView addSubview:_playButton];
    
    
    // 添加imageView添加背景图片
    self.bgImageView = [[UIImageView alloc] init];
    _bgImageView.frame = CGRectMake(0, CGRectGetMaxY(_myImageView.frame), CGRectGetWidth(_myImageView.frame), [UIScreen mainScreen].bounds.size.height - _myImageView.frame.size.height - 44);
    _bgImageView.userInteractionEnabled = YES;
    //_bgImageView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, [[UIScreen mainScreen] bounds].size.width / 2 + CGRectGetHeight(_myImageView.frame));
    [_bgImageView setImage:[UIImage imageNamed:@"mohu"]];
    [self addSubview:_bgImageView];
//
//    // 添加View设置透明度实现模糊效果
//    self.bgView = [[UIView alloc] init];
//    _bgView.frame = CGRectMake(0, 0, CGRectGetWidth(_bgImageView.frame), CGRectGetHeight(_bgImageView.frame));
//    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    [self.bgImageView addSubview:_bgView];
    
    self.titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, _bgImageView.frame.size.height * 0.1, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(_bgImageView.frame) * 0.1);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //_titleLabel.backgroundColor = [UIColor orangeColor];
    [self.bgImageView addSubview:_titleLabel];
    
    self.informationLabel = [[UILabel alloc] init];
    _informationLabel.frame = CGRectMake(10, CGRectGetMaxY(_titleLabel.frame), [[UIScreen mainScreen] bounds].size.width - 10, CGRectGetHeight(_bgImageView.frame) * 0.5);
    _informationLabel.textColor = [UIColor whiteColor];
    _informationLabel.font = [UIFont systemFontOfSize:15];
    _informationLabel.numberOfLines = 0;
    //_informationLabel.backgroundColor = [UIColor orangeColor];
    [self.bgImageView addSubview:_informationLabel];
    
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _collectionButton.frame = CGRectMake(10,_bgImageView.frame.size.height * 0.8, [[UIScreen mainScreen] bounds].size.width * 0.1, [[UIScreen mainScreen] bounds].size.width * 0.1);
    _collectionButton.backgroundColor = [UIColor clearColor];
    //[_collectionButton setImage:[UIImage imageNamed:@"collection"] forState:(UIControlStateNormal)];
    [_collectionButton setBackgroundImage:[UIImage imageNamed:@"collection"] forState:(UIControlStateNormal)];
    
    
    
    // 两个collection的label
    self.collectionButtonLabel = [[UILabel alloc] init];
    _collectionButtonLabel.frame = CGRectMake(CGRectGetMaxX(_collectionButton.frame) + 5, CGRectGetMinY(_collectionButton.frame) + 10, 40, 20);
    _collectionButtonLabel.text = @"收藏";
    _collectionButtonLabel.font = [UIFont systemFontOfSize:10];
    _collectionButtonLabel.textColor = [UIColor whiteColor];
    
    
    self.shareButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _shareButton.frame = CGRectMake(CGRectGetMaxX(_collectionButtonLabel.frame) + 5, CGRectGetMinY(_collectionButton.frame), CGRectGetWidth(_collectionButton.frame), CGRectGetHeight(_collectionButton.frame));
    //_shareButton.backgroundColor = [UIColor clearColor];
    //[_shareButton setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
    [_shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
    
    
    self.shareButtonLabel = [[UILabel alloc] init];
    _shareButtonLabel.frame = CGRectMake(CGRectGetMaxX(_shareButton.frame) + 5, CGRectGetMinY(_shareButton.frame) + 10, 40, 20);
    _shareButtonLabel.text = @"分享";
    _shareButtonLabel.textColor = [UIColor whiteColor];
    _shareButtonLabel.font = [UIFont systemFontOfSize:10];
    
    [self.bgImageView addSubview:_collectionButton];
    [self.bgImageView addSubview:_shareButton];
    [self.bgImageView addSubview:_collectionButtonLabel];
    [self.bgImageView addSubview:_shareButtonLabel];
    
    
}








@end
