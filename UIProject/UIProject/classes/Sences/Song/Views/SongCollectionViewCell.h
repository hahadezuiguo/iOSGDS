//
//  SongCollectionViewCell.h
//  UIProject
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
@interface SongCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *UpImage;
@property (weak, nonatomic) IBOutlet UILabel *SongListTitleLabel;
@property (nonatomic, strong) Song *song;
@end
