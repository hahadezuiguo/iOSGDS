//
//  UserFileHandle.h
//  UIProject
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
///管理用户信息的类
@interface UserFileHandle : NSObject




//存储用户信息
+ (void)saveUserInfo:(User *)user;

//删除用户信息

+ (void)deleteUserInfo;
//查询用户信息
+ (User *)selectUserInfo;


@end
