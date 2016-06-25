//
//  NSString+JSON.m
//  Where
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}
@end
