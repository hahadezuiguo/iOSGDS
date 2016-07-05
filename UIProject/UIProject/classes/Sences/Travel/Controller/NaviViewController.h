//
//  NaviViewController.h
//  UIProject
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface NaviViewController : UIViewController



//开始位置
@property (nonatomic, strong) BMKUserLocation *startLocation;


//结束位置
@property (nonatomic, assign) CLLocationCoordinate2D endLocation;



@end
