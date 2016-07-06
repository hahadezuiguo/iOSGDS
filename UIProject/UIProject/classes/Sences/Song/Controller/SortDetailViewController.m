//
//  SortDetailViewController.m
//  Project_B
//
//  Created by 曲国威 on 16/7/1.
//  Copyright (c) 2016年 曲国威. All rights reserved.
//

#import "SortDetailViewController.h"
#import "SortDetailView.h"
#import "SortDetailViewCell.h"
#import "NetWordRequestManager.h"
#import "SortDetailModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
@interface SortDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)SortDetailView *sortDetailView;
@property (nonatomic,strong)NSMutableArray *dataArr; // 创建可变数组,存放Model类
@property (nonatomic,strong)NSMutableString *nextUrlStr; // 创建可变字符串记录下次加载网址
//@property (nonatomic,strong)NSMutableString *referenceStr; //创建可变字符串用于参考nextUrlStr是否改变

@property (nonatomic,strong)NSString *timeStr;
@end

@implementation SortDetailViewController

- (void)loadView{

    self.sortDetailView = [[SortDetailView alloc] init];
    self.view = _sortDetailView;
}

- (void)viewWillAppear:(BOOL)animated{
    //播放界面隐藏tabbar样式
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //改变左上角按钮的数据
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.sortmodel.name style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    // 除此请求
    [self requestFirst];
    // 自定义Cell类注册Cell
    [self.sortDetailView registerClass:[SortDetailViewCell class] forCellReuseIdentifier:@"tableViewCell"];
    
    // 设置代理
    self.sortDetailView.dataSource = self;
    self.sortDetailView.delegate = self;
    
    // 下拉刷新头部
    [self.sortDetailView addHeaderWithTarget:self action:@selector(requestFirst)];
    //上拉加载
    [self.sortDetailView addFooterWithTarget:self action:@selector(requestNext)];
    
}
#pragma mark Button方法
- (void)leftBarButtonAction:(UIBarButtonItem *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 首次解析
- (void)requestFirst{

    //1.首先根据传入分类参数的字符串进行编码
    NSString *changeStr = [self.receiveString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"*****%@*****",changeStr);
    // 2.根据不同参数拼接网址
    NSString *urlStr = [NSString stringWithFormat:@"http://baobab.wandoujia.com/api/v1/videos?num=10&categoryName=%@&vc=67&t=MjAxNTA3MzAxNDQ2MTI0MjIsOTYzMQ%3%3D&u=fccb123580108076556393d900a3d5bfd2e2fc43&net=wifi&v=1.7.0&f=iphone",changeStr];
    [NetWordRequestManager requstType:GET urlString:urlStr prama:nil success:^(id data) {
        //此处开始解析
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        
                // 初始化可变字符串,准备记录下次请求网址
                self.nextUrlStr = [NSMutableString stringWithFormat:@"%@",dic[@"nextPageUrl"]];
        
                // 初始化存放Model类的数组
                self.dataArr = [NSMutableArray array];
        
                for (NSDictionary *dict in dic[@"videoList"]) {
                    SortDetailModel *model = [[SortDetailModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataArr addObject:model];
        
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.sortDetailView reloadData];
                    [self.sortDetailView headerEndRefreshing];
                });
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    /*
//    [Tool solveDataWithUrlString:urlStr httpMethod:@"GET" httpBody:nil backDataBlock:^(id data) {
//        
//        //此处开始解析
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//        
//        // 初始化可变字符串,准备记录下次请求网址
//        self.nextUrlStr = [NSMutableString stringWithFormat:@"%@",dic[@"nextPageUrl"]];
//        
//        // 初始化存放Model类的数组
//        self.dataArr = [NSMutableArray array];
//        
//        for (NSDictionary *dict in dic[@"videoList"]) {
//            SortDetailModel *model = [[SortDetailModel alloc]init];
//            [model setValuesForKeysWithDictionary:dict];
//            [self.dataArr addObject:model];
//            
//        }
//        
//        [self.sortDetailView reloadData];
//        [self.sortDetailView headerEndRefreshing];
//        
//    }];
    */
    

}


// 二次解析
- (void)requestNext{
    
    // 判断下次请求的网址是否为空,如果为空的话就直接提示用户无法再刷新
    //为空，跳转，继续走下面解析，赋给nextUrlStr空，继续走上重复
    if (!self.nextUrlStr) {
        NSLog(@"没有更多数据了");
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"通知" message:@"没有更多数据了" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertView addAction:alertAction];
        //弹出alert
        [self presentViewController:alertView animated:YES completion:nil];
        [self.sortDetailView footerEndRefreshing];
        return;
    }
    [NetWordRequestManager requstType:GET urlString:self.nextUrlStr prama:nil success:^(id data) {
            // 开始解析
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            
            // 解析的时候判断下次请求网址是否为空,为空则返回nil（空指针，空对象）
            if (!dict[@"nextPageUrl"] || [dict[@"nextPageUrl"] isKindOfClass:[NSNull class]]) {
                self.nextUrlStr = nil;
            } else {
                self.nextUrlStr = dict[@"nextPageUrl"];
            }
            for (NSDictionary *dictTemp in dict[@"videoList"]) {
                SortDetailModel *model = [[SortDetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dictTemp];
                [self.dataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.sortDetailView reloadData];
                // 停止加载
                [self.sortDetailView footerEndRefreshing];
            });

        } failed:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    /*
//        [Tool solveDataWithUrlString:self.nextUrlStr httpMethod:@"GET" httpBody:nil backDataBlock:^(id data) {
//            // 开始解析
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
//
//            // 解析的时候判断下次请求网址是否为空,为空则返回nil（空指针，空对象）
//            if (!dict[@"nextPageUrl"] || [dict[@"nextPageUrl"] isKindOfClass:[NSNull class]]) {
//                self.nextUrlStr = nil;
//            } else {
//                self.nextUrlStr = dict[@"nextPageUrl"];
//            }
//            for (NSDictionary *dictTemp in dict[@"videoList"]) {
//                SortDetailModel *model = [[SortDetailModel alloc]init];
//                [model setValuesForKeysWithDictionary:dictTemp];
//                [self.dataArr addObject:model];
//            }
//            [self.sortDetailView reloadData];
//            // 停止加载
//            [self.sortDetailView footerEndRefreshing];
//            
//        }];

    */
    
}

#pragma mark TableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    SortDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    
    //cell.backgroundColor = [UIColor orangeColor];
    SortDetailModel *model = self.dataArr[indexPath.row];
    cell.imageLabel_one.text = model.title;
    
    // 换算时间
    int temp = [model.duration intValue];
    int min = temp / 60;
    int second = temp % 60;
    
    // 将时间转换为字符串类型
    self.timeStr = [NSString stringWithFormat:@"%@  %d分%d秒",model.category,min,second];
    // 将图片信息给Label赋值
    cell.imageLabel_two.text = _timeStr;
    NSURL *urlStr = [NSURL URLWithString:model.coverForDetail];
    [cell.myImageView sd_setImageWithURL:urlStr];
//    [cell.myImageView sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:nil] options:(SDWebImageRetryFailed)];
    
    return cell;
    
}

// tableViewCell方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return [SortDetailViewCell cellHeight];
    
}

// tableView跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detailVC = [[DetailViewController alloc] init];
    // 创建Model类实现跳转
    SortDetailModel *model = self.dataArr[indexPath.row];
    detailVC.passImageUrl = model.coverForDetail;
    detailVC.passTitle = model.title;
    detailVC.passDescription = model.videoInformation;
    detailVC.passPlayUrl = model.playUrl;
    detailVC.passCategory = model.category;
    detailVC.passTime = self.timeStr;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
