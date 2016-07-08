//
//  OtherWeatherCell.h
//  UIProject
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherWeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIImageView *dImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nImageView;
@property (weak, nonatomic) IBOutlet UILabel *tmpLabel;

@end
