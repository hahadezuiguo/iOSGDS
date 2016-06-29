//
//  UserFileHandle.m
//  UIProject
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "UserFileHandle.h"


#define kUserName @"userName"
#define kAvatar @"avatar"
#define kPassword @"password"
#define kIsLogin @"isLogin"
#define kUserId @"userId"
#define kTelephone @"telephone"
#define kEmail @"email"

///存储对象类型
#define kUserNameInfoSaveObject(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]

#define kUserNameInfoSaveBOOL(value,key) [[NSUserDefaults standardUserDefaults] setBool:value forKey:key]


@implementation UserFileHandle




//存储用户信息
+ (void)saveUserInfo:(User *)user {
    
    kUserNameInfoSaveObject(user.userId,kUserId);
    kUserNameInfoSaveObject(user.avatar, kAvatar);
    kUserNameInfoSaveObject(user.userName, kUserName);
    kUserNameInfoSaveObject(user.password, kPassword);
    kUserNameInfoSaveBOOL(user.isLogin, kIsLogin);
    kUserNameInfoSaveObject(user.telephone, kTelephone);
    kUserNameInfoSaveObject(user.email, kEmail);
    
}

//删除用户信息

+ (void)deleteUserInfo {
    kUserNameInfoSaveObject(nil,kUserId);
    kUserNameInfoSaveObject(nil, kAvatar);
    kUserNameInfoSaveObject(nil, kUserName);
    kUserNameInfoSaveObject(nil, kPassword);
    kUserNameInfoSaveBOOL(NULL, kIsLogin);
    kUserNameInfoSaveObject(nil, kTelephone);
    kUserNameInfoSaveObject(nil, kEmail);
    
}
//查询用户信息
+ (User *)selectUserInfo {
    
    User *user = [[User alloc] init];
    
    user.userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    user.userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserId];
    user.password = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    user.avatar = [[NSUserDefaults standardUserDefaults] objectForKey:kAvatar];
    user.isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kIsLogin];
    user.telephone = [[NSUserDefaults standardUserDefaults] objectForKey:kTelephone];
    user.email = [[NSUserDefaults standardUserDefaults] objectForKey:kEmail];
    return user;

    
}

@end
