//
//  TravelCategoryCell.h
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TravelCategoryModel.h"
@interface TravelCategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) TravelCategoryModel *model;
-(void)setTravelCategorymodel:(TravelCategoryModel *)cateModel;
@end
