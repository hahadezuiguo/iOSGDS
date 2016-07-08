//
//  PlayerViewController.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "PlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
@interface PlayerViewController ()
@property (nonatomic,strong)UIActivityIndicatorView *loading;

//@property (nonatomic,strong)UIView *view1;

@end

@implementation PlayerViewController
// 观察者的添加与释放
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillEnterFullscreenNotification object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerWillExitFullscreenNotification object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:_moviePlayer];
    _loading = nil;
    _moviePlayer = nil;
    _movieUrlString = nil;
    
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
        // 监听播放器全屏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreen) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
        // 监听播放器退出全屏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notFullScreen) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStateChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        
        
    }
    return self;
}


- (void)loadStateChange:(NSNotification *)sender
{
    if (_moviePlayer.loadState == MPMovieLoadStateStalled) {
        [_loading startAnimating];
        NSLog(@"11111");
    }else if (_moviePlayer.loadState == MPMovieLoadStatePlayable )
    {
        [_loading stopAnimating];
        NSLog(@"22222");
    }else if (_moviePlayer.loadState == MPMovieLoadStateUnknown)
    {
        [_loading startAnimating];
        NSLog(@"33333");
    }else if (_moviePlayer.loadState == MPMovieLoadStatePlaythroughOK)
    {
        [_loading stopAnimating];
        NSLog(@"44444");
    }
    
}


- (void)viewDidLoad {
    //改变左上角按钮的数据
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [UIViewController attemptRotationToDeviceOrientation];
    // 菊花
    self.loading = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    _loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    [self.view addSubview:_loading];
    [_loading startAnimating];
    
    
    NSURL *url = [NSURL URLWithString:self.movieUrlString];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    _moviePlayer.view.frame = CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height);
    [self.view addSubview:_moviePlayer.view];
    _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer play];
    
    [self.view bringSubviewToFront:_loading];
    _loading.center = _moviePlayer.view.center;

}

#pragma mark Button方法
- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 全屏横屏
- (void)fullScreen
{
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate setIsShow:YES];
}

// 不全屏退出横屏
- (void)notFullScreen
{
    [(AppDelegate *)[UIApplication sharedApplication].delegate setIsShow:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"headView"]]];
}

// 播放完成之后方法
- (void)finishPlay
{
    _moviePlayer.fullscreen = NO;
    [_loading stopAnimating];
    [self.moviePlayer stop];
    
    // 当播放完成后退回到视频详情页面
    [self.navigationController popViewControllerAnimated:YES];
    
    
//    self.view1 = [[UIView alloc] initWithFrame:_moviePlayer.view.frame];
//    _view1.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:_view1];
//    self.reStart = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    _reStart.frame = CGRectMake(10, 10, 70, 70);
//    _reStart.center = _view1.center;
//    
//    
//    [_reStart setBackgroundImage:[UIImage imageNamed:@"hot_btnPlay_n.png"] forState:(UIControlStateNormal)];
//    [_reStart addTarget:self action:@selector(reStartAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [_view1 addSubview:_reStart];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 重新播放
//- (void)reStartAction:(UIButton *)sender
//{
//    NSURL *url = [NSURL URLWithString:self.movieUrlString];
//    _moviePlayer.contentURL = url;
//    [_moviePlayer play];
//    [_reStart removeFromSuperview];
//    [_view1 removeFromSuperview];
//    
//}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}



@end
