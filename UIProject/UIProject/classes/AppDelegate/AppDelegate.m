//
//  AppDelegate.m
//  UIProject
//
//  Created by lanou3g on 16/6/22.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "AppDelegate.h"

#import "RootVC/RootViewController.h"

#pragma mark - 新添代码
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM/AVOSCloudIM.h>


//引入头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

//引入语音
#import "iflyMSC/IFlySpeechUtility.h"


//引入导航
#import "BNCoreServices.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()
@property (nonatomic, strong) BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[RootViewController alloc] init];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bar5.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"8FLG8Yv5Ap1hH0VWq8iIwZ54BnUzAT0P"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    
    //第二步：登录科大讯飞语音平台
    NSString *appID = [NSString stringWithFormat:@"appid=%@",@"5750d5ff"];
    [IFlySpeechUtility createUtility:appID];
    

    
#pragma mark - 新添代码
    // applicationId 即 App Id，clientKey 是 App Key。
    [AVOSCloud setApplicationId:@"BjC7DlP0qrXJ33QGnfu5bBWa-gzGzoHsz"
                      clientKey:@"LFWCQxtyfi6s80V9SfsGbJG7"];
    
    
    
     //初始化导航SDK
    [BNCoreServices_Instance initServices:@"8FLG8Yv5Ap1hH0VWq8iIwZ54BnUzAT0P"];
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil];
#pragma mark - 第一次出现

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }

    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"577ca1e4e0f55a085f0002b5"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx346f7d141c8a0aa3" appSecret:@"3bd1d3c3c1db68b9aaa58051503a30fd" url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:@"1105524404" appKey:@"UroHv8aa3OBIx97M" url:@"http://www.baidu.com"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3525723822"
                                              secret:@"9cc0eefd77b17e9e258d6898ac28c6a9"
                                         RedirectURL:@"http://www.baidu.com"];


    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
#pragma mark - MPPlayer

// 在播放视频全屏界面让视频横屏
- (NSUInteger)supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isShow) {
        return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    }
    
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
