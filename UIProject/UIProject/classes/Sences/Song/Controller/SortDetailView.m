//
//  SortDetailView.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "SortDetailView.h"

@implementation SortDetailView

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
    self.separatorStyle = UITableViewCellSelectionStyleNone;
}

@end
