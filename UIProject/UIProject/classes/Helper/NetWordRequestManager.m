//
//  NetWordRequestManager.m
//  MusicPlayer2
//
//  Created by lanou3g on 16/6/15.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "NetWordRequestManager.h"

@implementation NetWordRequestManager

singleton_implementation(NetWordRequestManager)

+ (void)requstType:(RequestType)type urlString:(NSString *)urlString prama:(NSDictionary *)pramas success:(RequestSucceess)success failed:(RequestFailed)fail {
    NetWordRequestManager *manager = [NetWordRequestManager shareNetWordRequestManager];
    [manager requstType:type urlString:urlString prama:pramas success:success failed:fail];
}

- (void)requstType:(RequestType)type urlString:(NSString *)urlString prama:(NSDictionary *)pramas success:(RequestSucceess)success failed:(RequestFailed)fail {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (type == POST) {
        request.HTTPMethod = @"POST";
        if (pramas.count > 0) {
            NSData *data = [self parDicToDataWithDic:pramas];
            [request setHTTPBody:data];
        }
    }
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            if (success) {
                success(data);
            } else {
                if (!data) {
                    NSLog(@"请求数据为空");
                } else {
                    fail(error);
                }
            }
        }
    }];
    [task resume];
}

- (NSData *)parDicToDataWithDic:(NSDictionary *)dic {
    NSMutableArray *array = [NSMutableArray array];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
    }];
    NSString *parString = [array componentsJoinedByString:@"&"];
    return [parString dataUsingEncoding:NSUTF8StringEncoding];
}


@end
