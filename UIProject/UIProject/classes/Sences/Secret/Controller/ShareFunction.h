//
//  ShareFunction.h
//  UIProject
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface ShareFunction : NSObject

+ (void)sharetitle:(NSString *)title image:(NSString *)image viewController:(UIViewController *)controller content:(NSString *)content;

@end
