//
//  TravelCategoryDetailController.m
//  UIProject
//
//  Created by lanou3g on 16/7/5.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelCategoryDetailController.h"
#import "NetWordRequestManager.h"
#import "imageDownloader.h"
#import "TravelCategoryDetailModel.h"
#import "MapViewController.h"
#import "Travel.h"
@interface TravelCategoryDetailController ()<imageDownloaderDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewHeight;
@end

@implementation TravelCategoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self requestData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"去这里" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    
   
}

-(void)rightAction:(UIBarButtonItem *)sender {
    MapViewController *mapVC = [[MapViewController alloc]init];
    mapVC.haveAddress = YES;
    mapVC.searchAddress = self.addressLabel.text;
    mapVC.userLocation = [Travel shareTravel].userLocation;
    [self.navigationController pushViewController:mapVC animated:YES];
}

-(void)requestData {
    __weak typeof(self) weakSelf = self;
    //拼接网址
    NSString *urlString = [NSString stringWithFormat:@"http://www.qubaobei.com/ios/weekend/act_info_v14.php?mobile=104&version=141&act_id=%@&city_id=40000&crc_qq=&lat=0&lon=0&mix_id=&mobile_type=iPhone&mobile_udid=9b6e6857f19830ef08a84fefdb779db042944390&user_id=0",self.act_id];
    
   [NetWordRequestManager requstType:GET urlString:urlString prama:nil success:^(id data) {
       //解析数据
       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       NSDictionary *dict = dic[@"data"];
       TravelCategoryDetailModel *model = [[TravelCategoryDetailModel alloc]init];
       [model setValuesForKeysWithDictionary:dict];
       dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf showUIWithModelInfo:model];
       });
       
   } failed:^(NSError *error) {
       NSLog(@"数据请求失败");
   }];

}


-(void)showUIWithModelInfo:(TravelCategoryDetailModel *)model {
    //请求图片
    [imageDownloader imageDownloaderWithUrlString:model.pic delegate:self];
    self.nameLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"地址：%@",model.address];
    
}

-(void)imageDownloader:(imageDownloader *)downloader didFinishedLoading:(UIImage *)image {
     self.detailImageView.image = image;
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
