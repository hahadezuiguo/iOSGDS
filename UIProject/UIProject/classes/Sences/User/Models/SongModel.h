//
//  SongModel.h
//  UIProject
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongModel : NSObject

@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *playUrl;
@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,strong)NSString *category;
@property (nonatomic,strong)NSString *time;
// 创建属性 存放视频详细信息,在点击收藏跳转时传给详情页面
@property (nonatomic,strong)NSString *myDescription;
@property (nonatomic,strong)NSString *objectId;


//@property (nonatomic,copy)NSString *coverForDetail;// 图片网址
//@property (nonatomic,copy)NSString *title;// 图片名称
//@property (nonatomic,copy)NSString *category;// 图片类别
//@property (nonatomic,assign)NSString *duration;//时长
//@property (nonatomic,copy)NSString *videoInformation; //影片详细信息
//@property (nonatomic,copy)NSString *playUrl; // 播放网址

@end
