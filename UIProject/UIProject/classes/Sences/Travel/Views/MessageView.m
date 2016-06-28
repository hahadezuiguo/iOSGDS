//
//  MessageView.m
//  UIProject
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "MessageView.h"

#import <SDWebImage/UIImage+GIF.h>
@implementation MessageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayout];
    }
    return self;
}


-(void)initLayout {
    self.MgImageView = [[UIImageView alloc]initWithFrame:self.frame];
    self.MgImageView.center = self.center;
    UIImage *image = [UIImage sd_animatedGIFNamed:@"weather"];
    self.MgImageView.image = image;
    [self addSubview:self.MgImageView];
    
    
    
}



@end
