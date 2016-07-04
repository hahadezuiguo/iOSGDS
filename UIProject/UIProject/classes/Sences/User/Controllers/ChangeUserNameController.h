//
//  ChangeUserNameController.h
//  UIProject
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^block)(NSString *);
@interface ChangeUserNameController : UIViewController

@property (nonatomic,copy)block myBlock;

@end
