//
//  NSString+JSON.h
//  Where
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
@end
