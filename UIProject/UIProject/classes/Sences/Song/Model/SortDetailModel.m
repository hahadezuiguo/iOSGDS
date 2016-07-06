//
//  SortDetailModel.m
//  Project_B
//
//  Created by 魏辉 on 15/7/30.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import "SortDetailModel.h"

@implementation SortDetailModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

    
}

- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
    
    self.coverForDetail = keyedValues[@"coverForDetail"];
    self.title = keyedValues[@"title"];
    self.category = keyedValues[@"category"];
    self.duration = keyedValues[@"duration"];
    NSLog(@"%@",keyedValues[@"duration"]);
    self.videoInformation = keyedValues[@"description"];
    self.playUrl = keyedValues[@"playUrl"];
    
    
}

@end
