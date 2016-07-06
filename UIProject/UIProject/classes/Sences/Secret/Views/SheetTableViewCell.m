//
//  SheetTableViewCell.m
//  UIProject
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "SheetTableViewCell.h"

@implementation SheetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _leftView = [[UIImageView alloc]init];
        _InfoLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.leftView];
        [self.contentView addSubview:self.InfoLabel];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.leftView.frame = CGRectMake(20, (self.frame.size.height-20)/2, 25, 25);
    self.InfoLabel.frame = CGRectMake(self.leftView.frame.size.width+self.leftView.frame.origin.x+15, (self.frame.size.height-20)/2, 140, 25);
    
    
    
    
    
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
