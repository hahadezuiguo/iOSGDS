//
//  Travel.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>
//地图定位
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import "Singleton.h"


@interface Travel : NSObject

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKUserLocation *userLocation;

@property (nonatomic, strong) BMKGeoCodeSearch *searcher;
//当前的城市
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) BMKReverseGeoCodeResult *result;

singleton_interface(Travel)


@end
