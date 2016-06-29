//
//  imageDownloader.h
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 曲国威. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class imageDownloader;
@protocol imageDownloaderDelegate <NSObject>

- (void)imageDownloader:(imageDownloader *)downloader didFinishedLoading:(UIImage *)image;

@end
@interface imageDownloader : NSObject
//可以将delegate直接作为参数设置,避免可能出现的忘记设置代理问题的发生
- (instancetype)initWithImageUrlString:(NSString *)urlString delegate:(id<imageDownloaderDelegate>)delegate;

+ (instancetype)imageDownloaderWithUrlString:(NSString *)urlString delegate:(id<imageDownloaderDelegate>)delegate;
@end
