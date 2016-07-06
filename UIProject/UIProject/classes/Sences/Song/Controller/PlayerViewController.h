//
//  PlayerViewController.h
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface PlayerViewController : UIViewController
@property (nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property (nonatomic,copy)NSString *movieUrlString;
//@property (nonatomic,strong)UIButton *reStart;
@end
