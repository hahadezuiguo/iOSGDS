//
//  SongCollectionViewCell.m
//  UIProject
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "SongCollectionViewCell.h"

@implementation SongCollectionViewCell
- (void)setSong:(Song *)song{
    if (song != _song) {
        _song = nil;
        _song = song;
        self.SongListTitleLabel.text = _song.title;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
