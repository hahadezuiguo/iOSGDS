//
//  ShareFunction.m
//  UIProject
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ShareFunction.h"

@implementation ShareFunction

+ (void)sharetitle:(NSString *)title image:(NSString *)image viewController:(UIViewController<UMSocialUIDelegate> *)controller content:(NSString *)content{
    
    
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:image];
    
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:@"577ca1e4e0f55a085f0002b5"
                                      shareText:content
                                     shareImage:[UIImage imageNamed:@"AppIcon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:controller];
    
    
}

@end
