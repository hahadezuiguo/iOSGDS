//
//  DataModel.m
//  UILesson15_瀑布流
//
//  Created by lanou3g on 16/4/27.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

//防崩
-(void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    NSLog(@"看看这个%@ 对不对",key);
}

@end
