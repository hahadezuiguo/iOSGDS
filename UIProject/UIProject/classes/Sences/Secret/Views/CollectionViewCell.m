//
//  CollectionViewCell.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout{
    
    self.listImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20)];
    
    self.listImage.layer.cornerRadius = 20;
    self.listImage.layer.masksToBounds = YES;
    
    self.listTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    self.listTitle.numberOfLines = 0;
    self.listTitle.font = [UIFont systemFontOfSize:12];
    self.listTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.listImage];
    [self.contentView addSubview:self.listTitle];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
