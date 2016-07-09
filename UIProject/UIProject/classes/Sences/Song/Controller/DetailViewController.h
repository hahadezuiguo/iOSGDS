//
//  DetailViewController.h
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortDetailModel.h"
typedef void(^Block)();
@interface DetailViewController : UIViewController
// 设置属性用于接收从RecommendViewController传过来的值
@property (nonatomic,strong)NSString *passImageUrl;
@property (nonatomic,strong)NSString *passTitle;
@property (nonatomic,strong)NSString *passDescription;
@property (nonatomic,strong)NSString *passPlayUrl;
// 添加属性接收视频时间和分类在收藏的时候使用
@property (nonatomic,strong)NSString *passCategory;
@property (nonatomic,strong)NSString *passTime;
@property (nonatomic,strong)NSString *passObjectId;
//@property (nonatomic,copy)Block myBlock;
//
//@property (nonatomic,strong)SortDetailModel *sortdetailemodel;
@end
