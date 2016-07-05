//
//  TravelViewController.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>
//地图定位
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface TravelViewController : UIViewController

@property (nonatomic, strong) BMKUserLocation *userLocation;

@end
