//
//  MapViewController.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
@interface MapViewController : UIViewController
@property (nonatomic, strong) NSString *searchString;
//当前位置
@property (nonatomic, strong) BMKUserLocation *userLocation;
@end
