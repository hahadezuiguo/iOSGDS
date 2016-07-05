//
//  TravelCategoryCell.m
//  UIProject
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelCategoryCell.h"
#import "imageDownloader.h"

@interface TravelCategoryCell ()<imageDownloaderDelegate>

@end
@implementation TravelCategoryCell



-(void)setTravelCategorymodel:(TravelCategoryModel *)cateModel {
    if (_model != cateModel) {
        _model = nil;
    }

    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",cateModel.name,cateModel.a_name];
    self.addressLabel.text =[NSString stringWithFormat:@"地址：%@",cateModel.address];
    [imageDownloader imageDownloaderWithUrlString:cateModel.pic delegate:self];
}
-(void)imageDownloader:(imageDownloader *)downloader didFinishedLoading:(UIImage *)image {
    self.picImageView.image = image;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
