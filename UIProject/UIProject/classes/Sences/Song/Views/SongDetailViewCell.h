//
//  SongDetailViewCell.h
//  UIProject
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIButton *optionButton;

@end
