//
//  MapViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
@interface MapViewController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKPoiSearchDelegate>
//地图视图
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mapSegment;

//定位
@property (nonatomic, strong) BMKLocationService *locService;

//POI检索
@property (nonatomic,strong) BMKPoiSearch *poiSearch;//搜索服务

@property (nonatomic,strong) NSMutableArray *dataArray;
//当前位置

@property (nonatomic, strong) BMKUserLocation *location;

@end

@implementation MapViewController

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.navigationController.navigationBar.translucent = NO;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     _mapView.showsUserLocation = YES;//显示定位图层
    
    [self addLocService];
    
    [self.mapSegment addTarget:self action:@selector(controlPressed:) forControlEvents: UIControlEventValueChanged];
    
    
}

-(void)controlPressed:(id)sender {
     NSInteger selectedSegment = self.mapSegment.selectedSegmentIndex;
    switch (selectedSegment) {
        case 0:
            self.mapView.mapType = BMKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = BMKMapTypeSatellite;
            break;
        case 2:
            [self openTrafficAction];
            break;
        default:
            break;
    }
    
}

-(void)addLocService {
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

}


static BOOL isOpen = YES;
-(void)openTrafficAction {
    //路况打开
    if (!isOpen) {
        [_mapView setTrafficEnabled:YES];
        isOpen = YES;
    }else {
        //路况关闭
        [_mapView setTrafficEnabled:NO];
        isOpen = NO;
    }
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poiSearch.delegate = nil;
    
}


#pragma mark -------BMKLocationServiceDelegate 
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    
    //展示定位
    self.mapView.showsUserLocation = YES;
    
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    //获取用户的坐标
    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
    self.mapView.zoomLevel =18;
    
    //初始化搜索
    self.poiSearch =[[BMKPoiSearch alloc] init];
    
    
    self.poiSearch.delegate = self;
    
    
    
    //初始化一个周边云检索对象
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    
    //索引 默认为0
    option.pageIndex = 0;
    
    //页数默认为10
    option.pageCapacity = 50;
    
    //搜索半径
    option.radius = 200;
    
    //检索的中心点，经纬度
    option.location = userLocation.location.coordinate;
    NSLog(@"******************************%lf",userLocation.location.coordinate.latitude);
    //搜索的关键字
    option.keyword = self.searchString;
    
    
    
    //根据中心点、半径和检索词发起周边检索
    BOOL flag = [self.poiSearch poiSearchNearBy:option];
    if (flag) {
        NSLog(@"搜索成功");
        //关闭定位
        [self.locService stopUserLocationService];
    }
    else {
        
        NSLog(@"搜索失败");
    }

}


#pragma mark -------BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    
    //若搜索成功
    if (errorCode ==BMK_SEARCH_NO_ERROR) {
        
        //POI信息类
        //poi列表
        for (BMKPoiInfo *info in poiResult.poiInfoList) {
            
            [self.dataArray addObject:info];
            
            //初始化一个点的注释 //只有三个属性
            BMKPointAnnotation *annotoation = [[BMKPointAnnotation alloc] init];
            
            //坐标
            annotoation.coordinate = info.pt;
            
            //title
            annotoation.title = info.name;
            
            //子标题
            annotoation.subtitle = info.address;
            
            //将标注添加到地图上
            [self.mapView addAnnotation:annotoation];
        }
    }
    
    
}

#pragma mark -------------BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    //如果是注释点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        //根据注释点,创建并初始化注释点视图
        BMKPinAnnotationView  *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorRed;
        
        //设置动画
        newAnnotation.animatesDrop = YES;
        
        return newAnnotation;
        
    }
    
    return nil;
}


/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    
    //poi详情检索信息类
    BMKPoiDetailSearchOption *option = [[BMKPoiDetailSearchOption alloc] init];
    
    
    BMKPoiInfo *info = self.dataArray.firstObject;
    
    //poi的uid，从poi检索返回的BMKPoiResult结构中获取
    option.poiUid = info.uid;
    
    /**
     *根据poi uid 发起poi详情检索
     *异步函数，返回结果在BMKPoiSearchDelegate的onGetPoiDetailResult通知
     *@param option poi详情检索参数类（BMKPoiDetailSearchOption）
     *@return 成功返回YES，否则返回NO
     */
    BOOL flag = [self.poiSearch poiDetailSearch:option];
    
    if (flag) {
        NSLog(@"检索成功");
        
        
        
    }
    else {
        
        NSLog(@"检索失败");
    }

    
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
