//
//  UINavigationBar+NavigationBarImage.m
//  UIProject
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "UINavigationBar+NavigationBarImage.h"

@implementation UINavigationBar (NavigationBarImage)

- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"bar.jpg"];
   [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
