//
//  MessageView.m
//  UIProject
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}


-(void)initLayout {
    self.MgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.MgImageView.backgroundColor = [UIColor redColor];
    
    [self addSubview:self.MgImageView];
    
    self.MgTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
    self.MgTextView.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.MgTextView];
    
    self.button = [UIButton buttonWithType:(UIButtonTypeContactAdd)];
    self.button.frame = CGRectMake(100, 0, 40, 30);
    self.button.backgroundColor = [UIColor purpleColor];
    [self.button setTitle:@"确定" forState:(UIControlStateNormal)];
    
    [self addSubview:self.button];
    
    
}

@end
