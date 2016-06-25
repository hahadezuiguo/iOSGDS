//
//  MBProgressHUD+GifHUD.h
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (GifHUD)

//设置GIF

//frame 标记视图的大小
//gifName GIF名字
//view 目标view
+(void)setUpGifWithFrame:(CGRect)frame gifName:(NSString *)gifName text:(NSString *)text andShowToView:(UIView *)view;
@end
