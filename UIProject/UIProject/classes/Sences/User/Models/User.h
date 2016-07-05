//
//  User.h
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
///用户名
@property (nonatomic, copy) NSString *userName;
///密码
@property (nonatomic, copy) NSString *password;
///头像
@property (nonatomic, copy) NSString *avatar;
///id
@property (nonatomic, copy) NSString *userId;
///是否处于登录状态
@property (nonatomic, assign) BOOL isLogin;

///邮箱
@property (nonatomic,copy) NSString *email;
///电话号码
@property (nonatomic,copy) NSString *telephone;

@end
