//
//  WaterfallCollectionViewCell.m
//  UIProject
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "WaterfallCollectionViewCell.h"

@implementation WaterfallCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _waterImage = [[UIImageView alloc] init];
        [self.contentView addSubview:_waterImage];
    }
    return self;

}
//这里self.waterImage.frame = self.bounds;最好写在layoutSubviews里，写在上面的初始化中图片会出现错位
- (void)layoutSubviews {
    
    self.waterImage.frame = self.bounds;
    
}

@end
