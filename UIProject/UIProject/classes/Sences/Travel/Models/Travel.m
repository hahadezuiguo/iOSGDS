//
//  Travel.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "Travel.h"

@interface Travel ()<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>

@end
static Travel *travl = nil;
@implementation Travel

singleton_implementation(Travel)


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(instancetype)init {
    self = [super init];
    if (self) {
        [self initLayout];
    }
    return self;
}

-(void)initLayout {
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    self.userLocation = userLocation;
    [self getGeoCode];
}

//编码
-(void)getGeoCode {
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_userLocation.location.coordinate.latitude, _userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}
//实现Deleage处理回调结果

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSString *string = [NSString stringWithFormat:@"%@",result.addressDetail.city];
        NSString *str = [string substringToIndex:string.length - 1];
        self.city = str;
        self.result = result;
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}



@end
