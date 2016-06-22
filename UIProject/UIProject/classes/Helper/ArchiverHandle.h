//
//  ArchiverHandle.h
//  DoubanMovie
//
//  Created by lanou3g on 16/6/21.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Movie.h"
@interface ArchiverHandle : NSObject

singleton_interface(ArchiverHandle)
//归档
- (NSData *)dataOfArchiverObject:(id)object forKey:(NSString *)key;;
//反归档
- (id)unAchiverObject:(NSData *)data forKey:(NSString *)key;
@end
