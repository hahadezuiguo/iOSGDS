//
//  TravelAddressCell.m
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelAddressCell.h"

@implementation TravelAddressCell
-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //布局子视图
        [self initLayout];
    }
    return self;
}
-(void)initLayout {
    //创建对象
    self.addressImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    self.addressImage.layer.cornerRadius = self.frame.size.width / 2;
    self.addressImage.layer.masksToBounds = YES;
    [self.contentView addSubview:self.addressImage];
    
    self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addressImage.frame), self.frame.size.width, self.frame.size.height -self.addressImage.frame.size.height)];
    self.addressLabel.textColor = [UIColor purpleColor];
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.addressLabel];
}

@end
