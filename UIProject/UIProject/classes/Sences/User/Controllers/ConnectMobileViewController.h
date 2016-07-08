//
//  ConnectMobileViewController.h
//  UIProject
//
//  Created by lanou3g on 16/7/8.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSString *);
@interface ConnectMobileViewController : UIViewController

@property (nonatomic,copy)block myBlock;

@end
