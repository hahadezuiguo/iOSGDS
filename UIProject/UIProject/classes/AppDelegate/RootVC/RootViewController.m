//
//  RootViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "RootViewController.h"

#import "SecretViewController.h"
#import "ContentViewController.h"
#import "TravelViewController.h"
#import "UserViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //创建四个跟视图控制器
    [self createChildViewController];
    
}

- (void)createChildViewController {
    [self addOneChildViewController:[[SecretViewController alloc] init] title:@"育儿秘籍" normalImage:@"" selectorImage:@""];
    
    [self addOneChildViewController:[[ContentViewController alloc] init] title:@"宝贝爱听" normalImage:@"" selectorImage:@""];
    
    [self addOneChildViewController:[[TravelViewController alloc] init] title:@"宝贝去哪儿？" normalImage:@"" selectorImage:@""];
    
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
