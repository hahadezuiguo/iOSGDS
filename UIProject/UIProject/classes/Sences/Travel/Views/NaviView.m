//
//  NaviView.m
//  UIProject
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "NaviView.h"

@implementation NaviView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout {
    self.addressTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    self.addressTF.placeholder = @"请输入要去的地方";
    self.addressTF.backgroundColor = [UIColor cyanColor];
    self.addressTF.alpha = 0.6f;
    self.addressTF.borderStyle = UITextBorderStyleRoundedRect;
    self.addressTF.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.addressTF];
    
    self.naviButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.naviButton.frame = CGRectMake(50, 50, 100, 40);
    self.naviButton.backgroundColor = [UIColor yellowColor];
    self.naviButton.layer.cornerRadius = 20;
    self.naviButton.layer.masksToBounds = YES;
    [self.naviButton setTitleColor:[UIColor redColor]forState:UIControlStateNormal];
    [self.naviButton setTitle:@"确定" forState:(UIControlStateNormal)];
    [self addSubview:self.naviButton];
    
    self.cancelButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.cancelButton.frame = CGRectMake(50,100, 100, 40);
    self.cancelButton.backgroundColor = [UIColor orangeColor];
    self.cancelButton.layer.cornerRadius = 20;
    self.cancelButton.layer.masksToBounds = YES;
    [self.naviButton setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [self addSubview:self.cancelButton];

    
}

@end
