//
//  SortModel.m
//  Project_B
//
//  Created by 魏辉 on 15/7/28.
//  Copyright (c) 2015年 魏辉. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
//- (void)setValuesForKeysWithDictionary:(NSDictionary *)keyedValues{
//
//    
//}

- (NSString *)description{

    return [NSString stringWithFormat:@"%@,%@",_bgPicture,_name];
}

@end
