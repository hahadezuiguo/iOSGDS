//
//  HealthDetailViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "HealthDetailViewController.h"

#import "DB_URL.h"
#import <MBProgressHUD.h>

#import "ShareFunction.h"

@interface HealthDetailViewController ()
@property (nonatomic, strong) UIWebView *showView;
@end

@implementation HealthDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initLayout];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shares)];
}

- (void)shares{
    
    [ShareFunction sharetitle:self.model.title image:nil viewController:self content:self.model.wurl];
    
}

- (void)initLayout{
    
    self.showView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.showView];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"努力加载中，稍等片刻...";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.wurl]];
    [self.showView loadRequest:request];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
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
