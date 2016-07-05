//
//  RootCell.m
//  UILesson15_瀑布流
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "RootCell.h"

@implementation RootCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout {
    self.photoView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.photoView];
}
//重写
-(void)layoutSubviews {
    self.photoView.frame = self.bounds;
}


@end
