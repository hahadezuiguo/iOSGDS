//
//  HealthViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "HealthViewController.h"

#import <AFNetworking.h>
#import "DB_URL.h"
#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "HealthModel.h"

#import "HealthTableViewCell.h"

#import "HealthDetailViewController.h"

@interface HealthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *healthTable;
// 声明可变数组存放解析出的育儿课堂数据
@property (nonatomic, strong) NSMutableArray *allDataArray;

@end

@implementation HealthViewController


//懒加载
-(NSMutableArray *)allDataArray {
    
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.healthTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.healthTable];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//加到self.view上并且"View must not be nil."
    hud.labelText = @"正在努力加载....";
    hud.labelColor = [UIColor grayColor];
    hud.color = [UIColor lightGrayColor];
    
    
    self.healthTable.delegate = self;
    self.healthTable.dataSource = self;
    [self.healthTable registerNib:[UINib nibWithNibName:@"HealthTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //健康护理网络请求
    [self netHealthRequest];

    
}

//网络请求健康护理
//健康护理网络请求
- (void)netHealthRequest{
    
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager GET:HEALTH_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"data"];
        if (array.count > 0) {
            for (NSDictionary *dict in array) {
                HealthModel *model = [[HealthModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allDataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.healthTable reloadData];
                [weakSelf hiden];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"健康护理数据请求失败");
    }];
    
    
}

- (void)hiden{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HealthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     HealthModel *model = self.allDataArray[indexPath.row];
//    cell.mainImageV.layer.cornerRadius = 40;
//    cell.mainImageV.layer.masksToBounds = YES;
    [cell.mainImageV sd_setImageWithURL:[NSURL URLWithString:model.imageurl] placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = model.timer;
    cell.timeLabel.tintColor = [UIColor lightGrayColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HealthDetailViewController *healthVC = [[HealthDetailViewController alloc] init];
    HealthModel *model = self.allDataArray[indexPath.row];
    healthVC.model = model;
    [self.navigationController pushViewController:healthVC animated:YES];
    
    
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
