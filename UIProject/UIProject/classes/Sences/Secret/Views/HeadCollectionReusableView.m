//
//  HeadCollectionReusableView.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "HeadCollectionReusableView.h"



@implementation HeadCollectionReusableView



- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, [UIScreen mainScreen].bounds.size.width - 16, 2)];
    self.lineLabel.backgroundColor = [UIColor lightGrayColor];
    self.titlesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 100, 20)];
    self.titlesLabel.font = [UIFont systemFontOfSize:15];
    //"更多"按钮
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.moreButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 10, 60, 30);
    
    //添加
    [self addSubview:self.lineLabel];
    [self addSubview:self.titlesLabel];
    [self addSubview:self.moreButton];
    
}

@end
