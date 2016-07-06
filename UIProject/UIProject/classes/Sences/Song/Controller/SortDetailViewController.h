//
//  SortDetailViewController.h
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SortModel.h"
@interface SortDetailViewController : UIViewController
// 创建属性用于接收分类页面传入的网址中不同分类的参数名
@property (nonatomic,strong)NSString *receiveString;
@property (nonatomic,strong)SortModel *sortmodel;
@end
