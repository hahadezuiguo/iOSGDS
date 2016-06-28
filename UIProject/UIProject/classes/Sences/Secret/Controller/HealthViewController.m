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

#import "EGOViewCommon.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
const CGFloat kTableHeaderViewHeight = 65.f;
const CGFloat kTableFooterViewHeight = 65.f;

@interface HealthViewController ()<UITableViewDelegate,UITableViewDataSource,EGORefreshTableDelegate>

@property (nonatomic, strong) UITableView *healthTable;
// 声明可变数组存放解析出的育儿课堂数据
@property (nonatomic, strong) NSMutableArray *allDataArray;
//下载状态
@property (nonatomic, assign) BOOL isLoading;
//下拉刷新添加的顶部视图
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
//上拉刷新的底部视图
@property (nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;

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

    _isLoading = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.healthTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.healthTable.separatorStyle = NO;
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
    [self setHeaderView];
    
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

#pragma mark - Private Methods
- (void)setHeaderView
{
    if (_refreshHeaderView == nil)
    {
        // create the header view
        UIColor *viewTextColoer = [UIColor colorWithRed:216.0/255.0 green:196.0/255.0 blue:172.0/255.0 alpha:0.7f];
        UIColor *viewBackgroundColor = [UIColor colorWithRed:251.0/255.0 green:243.0/255.0 blue:231.0/255.0 alpha:1.0f];
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, -kTableHeaderViewHeight, self.healthTable.frame.size.width, kTableFooterViewHeight)
                                                               arrowImageName:@"refresh_up_arrow"
                                                             loadingImageNmae:@"refresh_loading"
                                                                    textColor:viewTextColoer];
        _refreshHeaderView.backgroundColor = viewBackgroundColor;
        _refreshHeaderView.delegate = self;
        
        [self.healthTable addSubview:_refreshHeaderView];
    }
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableView Delegate
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    [self beginReloadData];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
    return _isLoading;
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
    return [NSDate date];
}

- (void)beginReloadData
{
    _isLoading = YES;
    
    // 异步请求刷新数据
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.healthTable reloadData];
        _isLoading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:weakSelf.healthTable];
    });
}




@end
