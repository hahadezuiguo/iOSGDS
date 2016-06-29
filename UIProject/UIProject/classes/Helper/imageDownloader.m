//
//  imageDownloader.m
//  豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 曲国威. All rights reserved.
//

#import "imageDownloader.h"

@implementation imageDownloader
- (instancetype)initWithImageUrlString:(NSString *)urlString delegate:(id<imageDownloaderDelegate>)delegate {
    //网络请求
    //返回得到的url
    if (self = [super init]) {
        __weak typeof (imageDownloader)*downloader = self;
        //准备ulr
        NSURL *ulr = [NSURL URLWithString:urlString];
        //
        NSURLSession *session = [NSURLSession sharedSession];
        //创建连接对象，发送请求
        NSURLSessionTask *task = [session dataTaskWithURL:ulr completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!data) {
                return ;
            }
            //将图片传值
            UIImage *image = [UIImage imageWithData:data];
            //执行协议方法
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //调用协议方法
                [delegate imageDownloader:downloader didFinishedLoading:image];
            });
            
        }];
        [task resume];
    }
    
    return self;
}

+ (instancetype)imageDownloaderWithUrlString:(NSString *)urlString delegate:(id<imageDownloaderDelegate>)delegate {
    return [[[self class] alloc] initWithImageUrlString:urlString delegate:delegate];
}
@end
