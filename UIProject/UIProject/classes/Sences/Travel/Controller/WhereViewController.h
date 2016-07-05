//
//  WhereViewController.h
//  Where
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
//地图定位
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface WhereViewController : UIViewController

@property (nonatomic, strong) BMKReverseGeoCodeResult *result;
@property (nonatomic, strong) BMKUserLocation *userLocation;

@end
