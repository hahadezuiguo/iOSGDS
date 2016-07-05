//
//  MenuCell.m
//  UIProject
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout {
    self.menuImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.menuImageView];
    self.menuImageView.userInteractionEnabled = YES;
}
//重写
-(void)layoutSubviews {
    self.menuImageView.frame =CGRectMake(0, 0, self.bounds.size.width, 50);
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
