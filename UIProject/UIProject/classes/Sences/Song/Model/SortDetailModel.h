//
//  SortDetailModel.h
//  Project_B
//
//  Created by 魏辉 on 15/7/30.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SortDetailModel : NSObject
@property (nonatomic,copy)NSString *coverForDetail;// 图片网址
@property (nonatomic,copy)NSString *title;// 图片名称
@property (nonatomic,copy)NSString *category;// 图片类别
@property (nonatomic,assign)NSString *duration;//时长
@property (nonatomic,copy)NSString *videoInformation; //影片详细信息
@property (nonatomic,copy)NSString *playUrl; // 播放网址
// 是否被收藏
@property (nonatomic, assign) BOOL isFavorite;
@end
