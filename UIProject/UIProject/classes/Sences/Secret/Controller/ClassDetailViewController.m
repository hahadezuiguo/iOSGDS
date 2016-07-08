//
//  ClassDetailViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "DB_URL.h"
#import <MBProgressHUD.h>

#import "ShareFunction.h"

@interface ClassDetailViewController ()

@property (nonatomic, strong) UIWebView *showView;

@end

@implementation ClassDetailViewController

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

- (void)initLayout{
    
    self.showView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.showView];
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"努力加载中，稍等片刻...";
    NSString *ID = [NSString stringWithFormat:@"%@", self.model.ID];
    NSString *str = [CLASS_BASE_URL stringByAppendingString:ID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [self.showView loadRequest:request];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (void)shares{
    
    NSString *ID = [NSString stringWithFormat:@"%@", self.model.ID];
    NSString *str = [CLASS_BASE_URL stringByAppendingString:ID];
    
    [ShareFunction sharetitle:self.model.title image:self.model.thumb viewController:self content:str];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
