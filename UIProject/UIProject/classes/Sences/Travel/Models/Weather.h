//
//  Weather.h
//  UIProject
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject


@property (nonatomic, strong) NSDictionary *aqi;
@property (nonatomic, strong) NSDictionary *basic;
@property (nonatomic, strong) NSArray *daily_forecast;
@property (nonatomic, strong) NSArray *hourly_forecast;
@property (nonatomic, strong) NSDictionary *now;

@property (nonatomic, strong) NSDictionary *suggestion;

@end
