//
//  NetWordRequestManager.h
//  MusicPlayer2
//
//  Created by lanou3g on 16/6/15.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef NS_ENUM(NSUInteger,RequestType) {
    GET,
    POST
};
typedef void(^RequestSucceess)(id data);

typedef void(^RequestFailed)(NSError *error);

@interface NetWordRequestManager : NSObject




singleton_interface(NetWordRequestManager)

+ (void)requstType:(RequestType)type urlString:(NSString *)urlString prama:(NSDictionary *)pramas success:(RequestSucceess)success failed:(RequestFailed)fail;


@end
