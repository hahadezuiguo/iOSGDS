//
//  MBProgressHUD+GifHUD.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "MBProgressHUD+GifHUD.h"
#import <SDWebImage/UIImage+GIF.h>

@implementation MBProgressHUD (GifHUD)

+(void)setUpGifWithFrame:(CGRect)frame gifName:(NSString *)gifName text:(NSString *)text andShowToView:(UIView *)view  {
    //使用MBProgress 播放GIF 需要自定义视图显示
    UIImage *image = [UIImage sd_animatedGIFNamed:gifName];
    //自定义视图
    UIImageView *gifView = [[UIImageView alloc]initWithFrame:frame];
    gifView.layer.cornerRadius = 75;
    
    gifView.image = image;
    
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    
    hud.color = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = text;
    hud.labelColor = [UIColor orangeColor];
    hud.labelFont = [UIFont systemFontOfSize:13.f];
    hud.customView = gifView;

}

@end


