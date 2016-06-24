//
//  ClassViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ClassViewController.h"
#import <AFNetworking.h>
#import "URL.h"
#import <UIImageView+WebCache.h>
#import "ListModel.h"
#import "ClassTableViewCell.h"
#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>

@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *listTable;
// 声明可变数组存放解析出的育儿课堂数据
@property (nonatomic, strong) NSMutableArray *allDataArray;

@end

@implementation ClassViewController

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
    self.listTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:self.listTable];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    [self.listTable registerNib:[UINib nibWithNibName:@"ClassTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //育儿课堂网络请求
    [self netClassRequest];
}

//网络请求育儿课堂
- (void)netClassRequest{
    
    __weak typeof(self)weakSelf = self;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:SECRET_LIST_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [responseObject[@"list"] firstObject][@"list"];
        if (array.count > 0) {
            for (NSDictionary *dict in array) {
                ListModel *model = [ListModel new];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allDataArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.listTable reloadData];
                [weakSelf hiden];
                
            });
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据请求失败");
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
    
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ListModel *model = self.allDataArray[indexPath.row];
    cell.mainImageV.layer.cornerRadius = 40;
    cell.mainImageV.layer.masksToBounds = YES;
    [cell.mainImageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeHold.png"]];
    cell.titleLable.text = model.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


@end
