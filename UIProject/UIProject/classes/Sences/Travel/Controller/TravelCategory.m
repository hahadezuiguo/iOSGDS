//
//  TravelCategory.m
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelCategory.h"
#import "NetWordRequestManager.h"
#import "TravelCategoryModel.h"
#import "TravelCategoryCell.h"
#import "TravelCategoryDetailController.h"
@interface TravelCategory ()

//储存model对象的数组
@property (nonatomic, strong) NSMutableArray *allDatasArray;
@property (nonatomic, strong) UIImage *modelImage;

@end

@implementation TravelCategory

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //请求数据
    [self requestData];
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelCategoryCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)requestData {
    NSString *string = [NSString stringWithFormat:@"http://www.qubaobei.com/ios/weekend/home_page_v14.php?mobile=104&version=141&cate=%ld&city_id=40000&lat=0&limit=10&lon=0&mobile_type=iPhone&mobile_udid=9b6e6857f19830ef08a84fefdb779db042944390&page=1&user_id=0",self.index];
    __weak typeof(self) weakSelf = self;
    [NetWordRequestManager requstType:GET urlString:string prama:nil success:^(id data) {
        //解析数据
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //数据安全判断（判断ret 等于1）
        if ([dic[@"ret"]isEqualToString:@"1"]) {
            NSArray *array = dic[@"lists"];
            for (NSDictionary *dict in array) {
                TravelCategoryModel *model = [[TravelCategoryModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [weakSelf.allDatasArray addObject:model];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           //刷新数据
            [weakSelf.tableView reloadData];
        });
        
    } failed:^(NSError *error) {
        
        NSLog(@"请求数据失败");
        
    }];
}
//懒加载
-(NSMutableArray *)allDatasArray {
    if (!_allDatasArray) {
        _allDatasArray = [NSMutableArray array];
    }
    return _allDatasArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDatasArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   TravelCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TravelCategoryModel *model = self.allDatasArray[indexPath.row];
    [cell setTravelCategorymodel:model];
   
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelCategoryDetailController *travelCDVC = [[TravelCategoryDetailController alloc]init];
    
    TravelCategoryModel *model = self.allDatasArray[indexPath.row];
    travelCDVC.act_id = model.act_id;
    [self.navigationController pushViewController:travelCDVC animated:YES];
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
