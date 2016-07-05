//
//  TravelCategoryModel.h
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelCategoryModel : NSObject

@property (nonatomic, strong) NSString *act_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *a_name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *org_price;
@property (nonatomic, strong) NSString *real_price;
@property (nonatomic, strong) NSString *use_num;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSArray *tag;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *bus;
@property (nonatomic, strong) NSString *discount;


@end
