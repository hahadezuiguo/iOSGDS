//
//  ABCIntroViewController.m
//  Project_B
//
//  Created by 魏辉 on 15/8/3.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import "ABCIntroViewController.h"
#import "ABCIntroView.h"
@interface ABCIntroViewController ()<ABCIntroViewDelegate>
@property (nonatomic,strong)ABCIntroView *guideView;
@end

@implementation ABCIntroViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.guideView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
    
    // 实现代理
    self.guideView.delegate = self;
    [self.view addSubview:_guideView];
}

#pragma mark 代理方法
- (void)onDoneButtonPressed{

    [UIView animateWithDuration:0.5 delay:0 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
        self.guideView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
