//
//  ViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/22.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ViewController.h"

#import "DB_URL.h"
#import "NetWordRequestManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    
    

    NSLog(@"123");

    NSLog(@"老司机快开车");
    [self requestData];

}

- (void)requestData {
    __weak typeof (self)weakSelf = self;
    [NetWordRequestManager requstType:GET urlString:DB_BASE_URL prama:nil success:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    } failed:^(NSError *error) {
        NSLog(@"请求数据失败error = %@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
