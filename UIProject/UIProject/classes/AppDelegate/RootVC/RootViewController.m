//
//  RootViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "RootViewController.h"

#import "SecretViewController.h"
#import "SortViewController.h"
#import "TravelViewController.h"
#import "UserViewController.h"
#import "TravelMenuController.h"
#import "ABCIntroView.h"
@interface RootViewController ()<ABCIntroViewDelegate>
//
@property (nonatomic,strong)ABCIntroView *introView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
    //创建四个跟视图控制器
    [self createChildViewController];
    // 加载引导试图方法
    [self p_setupGuideView];
    
}
#pragma mark 判断是否为首次启动,如果首次启动那么出现引导图
- (void)p_setupGuideView{
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        self.navigationController.navigationBar.hidden = YES;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"intro_screen_viewed"]) {
            self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
            self.introView.delegate = self;
            self.introView.backgroundColor = [UIColor greenColor];
            [self.view addSubview:self.introView];
        }
        
    //}
}


#pragma mark 引导图代理方法
- (void)onDoneButtonPressed{
    
    [UIView animateWithDuration:1.0 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.introView.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [self.introView removeFromSuperview];
        
    }];
}
- (void)createChildViewController {
    [self addOneChildViewController:[[SecretViewController alloc] init] title:@"育儿秘籍" normalImage:@"" selectorImage:@""];
    
    [self addOneChildViewController:[[SortViewController alloc] init] title:@"family一起看" normalImage:@"" selectorImage:@""];
    
    [self addOneChildViewController:[[TravelMenuController alloc] init] title:@"宝贝去哪儿？" normalImage:@"" selectorImage:@""];
    
    [self addOneChildViewController:[[UserViewController alloc] init] title:@"妈咪空间" normalImage:@"" selectorImage:@""];
    
}

- (void)addOneChildViewController:(UIViewController *)viewController title:(NSString *)title normalImage:(NSString *)normalImage selectorImage:(NSString *)selectorImage {
    viewController.title = title;
    
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:normalImage];
    
    UIImage *selectImage = [UIImage imageNamed:selectorImage];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = selectImage;
    
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:viewController]];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
