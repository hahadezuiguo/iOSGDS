//
//  NaviViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "NaviViewController.h"
#import "BNCoreServices.h"
@interface NaviViewController ()<BNNaviRoutePlanDelegate,BNNaviUIManagerDelegate>
@end

@implementation NaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self startNaviWithStartNode:self.startLocation endNode:self.endLocation];
    
   
    
}

-(void)startNaviWithStartNode:(BMKUserLocation *)startLocation endNode:(CLLocationCoordinate2D)endLocation {
    //节点函数
    NSMutableArray *nodesArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    //起点
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc]init];
    startNode.pos = [[BNPosition alloc]init];
    startNode.pos.x = startLocation.location.coordinate.longitude;
    startNode.pos.y = startLocation.location.coordinate.latitude;
    startNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:startNode];
    
    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = endLocation.longitude;
    endNode.pos.y = endLocation.latitude;
    endNode.pos.eType = BNCoordinate_BaiduMapSDK;
    [nodesArray addObject:endNode];
    //发起路径规划
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:nil];
}


//算路成功后，在回调函数中发起导航

//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{
    NSLog(@"算路成功");
    
    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI: BN_NaviTypeReal delegete:self isNeedLandscape:YES];
}

//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    if ([error code] == BNRoutePlanError_LocationFailed) {
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_RoutePlanFailed)
    {
        NSLog(@"定位服务未开启");
    }
}

//算路取消
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}



//第一次进入导航页面会显示导航声明页，导航回调包括退出导航回调和退出导航声明页回调。

//退出导航回调
-(void)onExitNaviUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航页面");
    [self.navigationController popViewControllerAnimated:YES];
}
//退出导航声明页面回调
- (void)onExitDeclarationUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
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
