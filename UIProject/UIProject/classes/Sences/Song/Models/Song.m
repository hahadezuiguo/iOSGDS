//
//  Song.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "Song.h"
#import "imageDownloader.h"

@interface Song ()<imageDownloaderDelegate>

@end

@implementation Song

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
//通过图片连接获取图片，保存在image属性中，
- (void)loadImage{
    [imageDownloader imageDownloaderWithUrlString:self.pic_w300 delegate:self];
}

#pragma mark - imageDownloaderDelegate
- (void)imageDownloader:(imageDownloader *)downloader didFinishedLoading:(UIImage *)image{
    self.songMainimage = image;
}
@end
