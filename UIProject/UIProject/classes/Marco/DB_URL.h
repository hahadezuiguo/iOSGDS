//
//  DB_URL.h
//  UIProject
//
//  Created by lanou3g on 16/6/22.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#ifndef DB_URL_h
#define DB_URL_h

//BASEURL
#define DB_BASE_URL @"http://au.umeng.com/check_config_update"

//POST
#define DB_DETAIL @"?content=%7B%22appkey%22%3A%225424c4fbfd98c58f0901fc47%22%2C%22channel%22%3A%22App%20Store%22%2C%22ad_request%22%3A1%2C%22time%22%3A%2219%3A03%3A41%22%2C%22package%22%3A%22com.lighting.BabyFoodAll%22%2C%22type%22%3A%22online_config%22%2C%22sdk_type%22%3A%22iOS%22%2C%22sdk_version%22%3A%223.1.6%22%7D"



#define SECRET_LIST_URL @"http://wp.asopeixun.com:5000/get_post_from_category_id?category_id=191"

#define HEALTH_URL @"http://api.addinghome.com/adco/v3/getContentList"

#define HEALTH_URL_BODY @"birthdate=1425657600.0&categoryId=0&channelId=1&ci=%E5%8C%97%E4%BA%AC%E5%B8%82&deviceToken=d2670e402293d4a2956b64e75803e029a8c775834c0a3e7d40af1abd48ba201b&oauth_token=&pr=%E5%8C%97%E4%BA%AC%E5%B8%82&size=15&start=0&userStatus=2"


#define COOK_URL @"http://api.bbwansha.com:8080/bbwssubclass2/index.php/Home/Healthy/healthylist?type=2&page=1"

#define CLASS_BASE_URL @"http://wp.asopeixun.com/archives/"
//歌曲界面
#define SONG_ALLLIST_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedan&page_no=1&page_size=30&from=ios&version=5.7.2&from=ios&channel=appstore&operator=3"
//collection1
#define SONG_C1_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=6727&isUGC=0&version=5.7.2&from=ios&channel=appstore&operator=3"

#define SONG_C2_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=3305&isUGC=0&version=5.7.2&from=ios&channel=appstore&operator=3"

#define SONG_C3_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=4861&isUGC=0&version=5.7.2&from=ios&channel=appstore&operator=3"

#define SONG_C4_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=6721&isUGC=0&version=5.7.2&from=ios&channel=appstore&operator=3"

#define SONG_C5_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=5429&isUGC=0&version=5.7.2&from=ios&channel=appstore&operator=3"

#define SONG_C6_URL @"http://tingapi.ting.baidu.com/v1/restserver/ting?method=baidu.ting.diy.gedanInfo&from=ios&listid=6725&isUGC=0&version=5.7.2&from=ios&channel=appstore&operator=3"
#endif /* DB_URL_h */
