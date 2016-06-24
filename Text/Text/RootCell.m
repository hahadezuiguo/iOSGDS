//
//  RootCell.m
//  UILesson15_UICollectionView
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "RootCell.h"

@implementation RootCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

- (void)initLayout {
    self.photoImage = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.photoImage];
    
      
    
}


@end
