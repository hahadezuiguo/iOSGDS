//
//  TravelViewController.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
@interface TravelViewController : UIViewController
@property (nonatomic, assign) BOOL isSpeeching;
@property (nonatomic, strong) Weather *weather;

@end
