//
//  Song.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Song : NSObject
@property(nonatomic,strong)NSString *title;
//图片链接
@property(nonatomic,strong)NSString *pic_w300;
//通过连接拿到image
@property (nonatomic,strong) UIImage *songMainimage;
- (void)loadImage;
@end
