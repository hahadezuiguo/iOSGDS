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

@interface MapViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>



@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

//创建地理编码对象
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;


//POI检索
@property (nonatomic, strong) BMKPoiSearch *POISearcher;


@end

@implementation MapViewController

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _searcher.delegate = nil;
    _POISearcher.delegate = nil;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    //上个页面传过来的地址
    
    geoCodeSearchOption.address = self.searchString;
    
    //    geoCodeSearchOption.city= @"北京市";
    //    geoCodeSearchOption.address = @"海淀区上地10街10号";
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    
    
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
    
    
    UIBarButtonItem *traffic = [[UIBarButtonItem alloc]initWithTitle:@"打开路况" style:(UIBarButtonItemStylePlain) target:self action:@selector(openTrafficAction:)];
    
    self.navigationItem.rightBarButtonItems = @[traffic];

    
    
}

static BOOL isOpen = YES;
-(void)openTrafficAction:(id)sender {
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


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        //将上一次的大头针数据清空
        NSArray *array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        
        //将上一次添加的覆盖视图清空
        
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        
        //添加大头针
        
        
        // 添加一个PointAnnotation
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        
        annotation.coordinate = result.location;
        annotation.title = self.searchString;
        [_mapView addAnnotation:annotation];
        
        //设置地图中心
        _mapView.centerCoordinate = result.location;
        
        
        //添加覆盖视图
        //周边检索
        
        //初始化检索对象
        self.POISearcher =[[BMKPoiSearch alloc]init];
        _searcher.delegate = self;
        //发起检索
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
        option.pageIndex = 0;
        option.pageCapacity = 10;
        option.location = result.location;
        option.keyword = @"小吃";
        BOOL flag = [_POISearcher poiSearchNearBy:option];
        
        if(flag)
        {
            NSLog(@"周边检索发送成功");
        }
        else
        {
            NSLog(@"周边检索发送失败");
        }
        
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        NSArray *POIinfoList = poiResultList.poiInfoList;
        [POIinfoList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BMKPoiInfo *info = (BMKPoiInfo *)obj;
            NSLog(@"name = %@,address = %@",info.name,info.address);
            
            // 添加一个PointAnnotation
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            
            annotation.coordinate = info.pt;
            annotation.title = info.name;
            [_mapView addAnnotation:annotation];
            
            
            
            
            
            
            
        }];
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}









// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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
