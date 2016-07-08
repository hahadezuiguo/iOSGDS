//
//  WeatherCell.h
//  UIProject
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addressAndWeather;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *hightTemp;
@property (weak, nonatomic) IBOutlet UILabel *lowTemp;

@property (weak, nonatomic) IBOutlet UILabel *windLabel;

@property (weak, nonatomic) IBOutlet UILabel *windPowerLabel;

@property (weak, nonatomic) IBOutlet UILabel *sunLabel;



@end
