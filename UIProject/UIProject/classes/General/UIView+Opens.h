//
//  UIView+Opens.h
//  testRefresh
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 刘洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Opens)

/**
 *  根据图片随机分配颜色
 *
 *  @param image baseImage
 */
- (void)bubbingImage:(UIImage *)image;

/**
 *  多张图片中随机出现
 *
 *  @param images 图片数据
 */
- (void)bubbingImages:(NSArray *)images;

@end
