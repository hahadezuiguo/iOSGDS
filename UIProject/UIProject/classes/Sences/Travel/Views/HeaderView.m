//
//  HeaderView.m
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "HeaderView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation HeaderView
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //初始化布局
        [self initLayout];
    }
    return self;
}

-(void)initLayout {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kWidth/2)];
    self.scrollView.contentSize = CGSizeMake(8*kWidth, 0);
    self.scrollView.contentOffset = CGPointMake(kWidth, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    for (int i = 0; i < 8; i++) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kWidth/2)];
        if (i == 0) {
            self.imageView.image = [UIImage imageNamed:@"travel6"];
            }else if (i == 7) {
                self.imageView.image = [UIImage imageNamed:@"travel1"];
            }else {
                self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"travel%d",i]];

            }
            [self.scrollView addSubview:self.imageView];
    }
    [self addSubview:self.scrollView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, self.scrollView.frame.size.height - 15, 100, 10)];
    self.pageControl.numberOfPages = 6;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:self.pageControl];
    
    
}

@end
