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
    BOOL ret = [_mapManager start:@"s8AIKKpdESCLzHYNdXekAMTlILgOmpPK"  generalDelegate:nil];
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
    
    return YES;
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
