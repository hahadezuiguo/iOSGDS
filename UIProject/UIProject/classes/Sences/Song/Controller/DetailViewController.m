//
//  DetailViewController.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"
#import "UIImageView+WebCache.h"
#import "DetailViewModel.h"
#import "PlayerViewController.h"
//#import "UMSocial.h"
#import <AVOSCloud/AVOSCloud.h>
@interface DetailViewController ()
@property (nonatomic,strong)DetailView *detailView;
@end

@implementation DetailViewController

- (void)loadView{

    self.detailView = [[DetailView alloc] init];
    self.view = _detailView;
}

- (void)viewDidDisappear:(BOOL)animated{

    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //返回模态
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    // 隐藏tabBar
    self.navigationController.tabBarController.tabBar.hidden = YES;
    [self initLayout];
    // 播放按钮点击事件
    [self.detailView.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 收藏按钮点击事件
    [self.detailView.collectionButton addTarget:self action:@selector(collectionButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 分享按钮
    [self.detailView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}
#pragma mark Button方法
- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initLayout{

    NSURL *urlStr = [NSURL URLWithString:self.passImageUrl];
    [self.detailView.myImageView sd_setImageWithURL:urlStr];//
    self.detailView.titleLabel.text = self.passTitle;
    self.detailView.informationLabel.text = self.passDescription;
    
//    // 模糊处理
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *inputImage = [[CIImage alloc] initWithImage:self.detailView.myImageView.image];
//    // create gaussian blur filter
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:inputImage forKey:kCIInputImageKey];
//    [filter setValue:[NSNumber numberWithFloat:20.0] forKey:@"inputRadius"];
//    // blur image
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    [self.detailView.bgImageView setImage:image];

    
}

#pragma mark 私有方法
- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertView addAction:alertAction1];
    [self presentViewController:alertView animated:YES completion:nil];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
}
#warning 收藏
#pragma mark 点击事件方法
- (void)collectionButtonAction:(UIButton *)sender{
//
//    AVUser *currentUser = [AVUser currentUser];
//    if (currentUser != nil) {
//        
//        // 判断用户是否已经收藏过了
//        
//        AVQuery *query = [AVQuery queryWithClassName:@"Collection"];
//        // 查询 先查询是否有这个用户名,在查询这个用户是否收藏过这个,如果两个条件同时成立则不能收藏
//        [query whereKey:@"userName" equalTo:currentUser.username];
//        [query whereKey:@"title" containsString:self.passTitle];
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//            // error是指在查询的过程中是否遇到了异常(如服务器关闭)
//            if (!error) {
//                // 返回的是数组,应该判断数组的个数,如果数组有值那么就说明查询成功!
//                if (objects.count > 0) {
//                    [self alertViewWithTitle:@"收藏失败" message:@"您已收藏过了"];
//                }else{
//                    
//                    AVObject *collection = [AVObject objectWithClassName:@"Collection"];
//                    
//                    //        NSData *imageData = [currentUser objectForKey:@"userImage"];
//                    //        NSData *imageDataTemp = UIImageJPEGRepresentation([UIImage imageWithData:imageData], 0.1);
//                    //        [collection setObject:imageDataTemp forKey:@"collectionImage"];
//                    
//                    [collection setObject:currentUser.username forKey:@"userName"];
//                    [collection setObject:self.passImageUrl forKey:@"imageUrl"];
//                    [collection setObject:self.passTitle forKey:@"title"];
//                    [collection setObject:self.passCategory forKey:@"category"];
//                    [collection setObject:self.passTime forKey:@"time"];
//                    [collection setObject:self.passPlayUrl forKey:@"playUrl"];
//                    // 收藏时将详细信息收藏 再收藏页面并不展示,为的是由收藏页面转向详情页面时传值
//                    [collection setObject:self.passDescription forKey:@"myDescription"];
//                    // 存储
//                    [collection save];
//                    [self alertViewWithTitle:@"收藏成功" message:@"您可以到我的收藏中查看了"];
//                }
//                
//            }else{
//            
//                // 说明在查询的过程中遇到了问题
//                [self alertViewWithTitle:@"服务器不给力" message:@"请稍后再试"];
//            
//            }
//            
//            
//        }];
//
//        
//    }else{
//    
//        [self alertViewWithTitle:@"请登录" message:@"您尚未登录,无法收藏哦~"];
//        
//    }
//    
//    
//    
}

- (void)playButtonAction:(UIButton *)sender{

//    NSLog(@"开始播放");
//    VideoPlayerController *videoPlayer = [[VideoPlayerController alloc] init];
//    // 跳转到播放页面之前先把url传入
//    videoPlayer.receiveUrl = self.passPlayUrl;
//    
//    [self.navigationController pushViewController:videoPlayer animated:YES];
    
    PlayerViewController *playerVC = [[PlayerViewController alloc] init];
    playerVC.movieUrlString = self.passPlayUrl;
    [self.navigationController pushViewController:playerVC animated:YES];
    
    
}
#warning 分享
- (void)shareButtonAction:(UIButton *)sender{
//
//    
//    AVUser *currentUser = [AVUser currentUser];
//    if (currentUser != nil) {
//        [UMSocialSnsService presentSnsIconSheetView:self
//                                             appKey:@"55c0ab5a67e58e23970014a3"
//                                          shareText:@"世觉,带给你不一样的视听享受...快来App Store下载吧~"
//                                         shareImage:[UIImage imageNamed:@"appIcon"]
//                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
//                                           delegate:nil];
//    }else{
//    
//    
//        [self alertViewWithTitle:@"请登录" message:@"登录后才能分享哦~"];
//    }
//    
//    
}







@end
