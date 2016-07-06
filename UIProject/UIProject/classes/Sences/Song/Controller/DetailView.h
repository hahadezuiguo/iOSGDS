//
//  DetailView.h
//  Project_B
//
//  Created by 曲国威 on 15/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIView
@property (nonatomic,strong)UIImageView *myImageView;
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *informationLabel;
// 添加Button
@property (nonatomic,strong)UIButton *playButton;
@property (nonatomic,strong)UIButton *collectionButton;
@property (nonatomic,strong)UIButton *shareButton;
// Button信息
@property (nonatomic,strong)UILabel *collectionButtonLabel;
@property (nonatomic,strong)UILabel *shareButtonLabel;
@end
