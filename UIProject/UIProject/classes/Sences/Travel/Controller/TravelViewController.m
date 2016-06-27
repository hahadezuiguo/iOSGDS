//
//  TravelViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelViewController.h"
#import "WhereViewController.h"

#import "MessageView.h"

#import "NSString+JSON.h"

#import "APIStoreSDK.h"
#import "Weather.h"

#import "MBProgressHUD+GifHUD.h"



//引入头文件
//文字识别的回调方法接口
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>

//文字识别对象
#import <iflyMSC/IFlySpeechSynthesizer.h>

//科大讯飞语音框架定义的常量
#import <iflyMSC/IFlySpeechConstant.h>

//地图定位
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface TravelViewController ()<IFlySpeechSynthesizerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *weatherText;

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, assign) NSInteger weatherCount;

@property (nonatomic, strong) MessageView *messageView;
//文字识别对象
@property (strong, nonatomic) IFlySpeechSynthesizer *synthesizer;

@property (strong, nonatomic) Weather *weather;

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKUserLocation *userLocation;

@property (nonatomic, strong) BMKGeoCodeSearch *searcher;
//当前的城市
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) BMKReverseGeoCodeResult *result;

@end

@implementation TravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    //创建文字识别对象
    [self createSynthesizer];
      //定位
    [self locationService];
        //请求天气数据
    [self requestWeather];
   
    
    //播放第一条并加入Timer设定切换间隔时间
    [self msgChange];
    [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(msgChange) userInfo:nil repeats:YES];
    
}

//编码
-(void)getGeoCode {
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_userLocation.location.coordinate.latitude, _userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
 
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}

//定位
-(void)locationService {
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    self.userLocation = userLocation;
    [self getGeoCode];
}

-(void)requestWeather {
    //实例化一个回调，处理请求的返回值
    APISCallBack* callBack = [APISCallBack alloc];
    //部分请求参数
    NSString *url = @"http://apis.baidu.com/heweather/weather/free";
    NSString *method = @"post";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    if (self.city) {
        [parameter setObject:self.city forKey:@"city"];
    }else {
        [parameter setObject:@"北京" forKey:@"city"];
    }
    
    //请求API
    [ApiStoreSDK executeWithURL:url method:method apikey:@"c2c6467774885923b4629db0ab700dc0" parameter:parameter callBack:callBack];
    
    self.weather = [[Weather alloc]init];
    __weak typeof(self) weakSelf = self;
    callBack.onSuccess = ^(long status, NSString* responseString) {
       
        if(responseString != nil) {
         
            NSDictionary *dic = [NSString parseJSONStringToNSDictionary:responseString];
           
            NSArray *array = dic[@"HeWeather data service 3.0"];
            NSDictionary *dict = array[0];
        
            [_weather setValuesForKeysWithDictionary:dict];
            NSString *string = [_weather.basic[@"update"] objectForKey:@"loc"];
            weakSelf.dateLabel.text = [NSString stringWithFormat:@"今天：%@",[string substringToIndex:10]];
            NSString *string1 = [[_weather.daily_forecast[0] objectForKey:@"cond"]objectForKey:@"txt_d"];
            NSString *string2 = [[_weather.daily_forecast[0] objectForKey:@"cond"]objectForKey:@"txt_n"];

            NSString *string3 = [[_weather.daily_forecast[0] objectForKey:@"tmp"]objectForKey:@"max"];
            NSString *string4 = [[_weather.daily_forecast[0] objectForKey:@"tmp"]objectForKey:@"min"];
            NSString *string5 = [[_weather.daily_forecast[0] objectForKey:@"wind"]objectForKey:@"dir"];
            NSString *string6 = [[_weather.daily_forecast[0] objectForKey:@"wind"]objectForKey:@"sc"];
            
            weakSelf.messageArray = [NSArray arrayWithObjects:@"温馨提示",
                                     [NSString stringWithFormat:@"今天天气白天%@,晚上%@",string1,string2],
                                     [NSString stringWithFormat:@"最高气温%@度",string3],
                                     [NSString stringWithFormat:@"最低气温%@度",string4],
                                     [NSString stringWithFormat:@"有%@ 是%@",string5, string6],
                                     @"出行请注意天气变化",
                                     nil];
            weakSelf.weatherCount = 0;
            
        }
        
    };
    
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
    };
    
    callBack.onComplete = ^() {
        NSLog(@"onComplete");
    };
    
}
-(void)createSynthesizer {
    //创建文字识别对象
    self.synthesizer = [IFlySpeechSynthesizer sharedInstance];
    
    //指定文字识别对象的代理对象
    self.synthesizer.delegate = self;
    
    //设置文字识别对象的关键属性
    [self.synthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    [self.synthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    [self.synthesizer setParameter:@"XIAOYAN" forKey:[IFlySpeechConstant VOICE_NAME]];
    [self.synthesizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    [self.synthesizer setParameter:@"temp.pcm" forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    [self.synthesizer setParameter:@"custom" forKey:[IFlySpeechConstant PARAMS]];

}

-(void)viewDidAppear:(BOOL)animated {
   
}


- (void)msgChange {
    
    if (self.weatherCount <= self.messageArray.count) {
        self.weatherText.text = [self.messageArray objectAtIndex:self.weatherCount];
        self.weatherCount++;
        if (self.weatherCount == self.messageArray.count) {
            self.weatherCount = 0;
        }
    }
    
    [self.weatherText sizeToFit];
    CGRect frame = self.weatherText.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    self.weatherText.frame = frame;
    
    [UIView beginAnimations:@"scrollLabelTest" context:NULL];
    [UIView setAnimationDuration:4.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:0];
    
    frame = self.weatherText.frame;
    frame.origin.x = -frame.size.width;
    self.weatherText.frame = frame;
    [UIView commitAnimations];
}


- (void)showGifView {
    //加载等待视图
    [MBProgressHUD setUpGifWithFrame:CGRectMake(0, 0, 150,150) gifName:@"where" text:self.weatherText.text andShowToView:self.messageView];
}
-(void)hideGifView {
    [MBProgressHUD hideHUDForView:self.messageView animated:YES];
}





- (IBAction)GoAction:(id)sender {
    
   
    NSString *string2 = [[_weather.suggestion objectForKey:@"comf"]objectForKey:@"brf"];
    NSString *string22 = [[_weather.suggestion objectForKey:@"comf"]objectForKey:@"txt"];
    
    NSString *string3 = [[_weather.suggestion objectForKey:@"flu"]objectForKey:@"brf"];
    NSString *string33 = [[_weather.suggestion objectForKey:@"flu"]objectForKey:@"txt"];

    NSString *string4 = [[_weather.suggestion objectForKey:@"sport"]objectForKey:@"brf"];
    NSString *string44 = [[_weather.suggestion objectForKey:@"sport"]objectForKey:@"txt"];

    NSString *string5 = [[_weather.suggestion objectForKey:@"trav"]objectForKey:@"brf"];
    NSString *string55 = [[_weather.suggestion objectForKey:@"trav"]objectForKey:@"txt"];

    NSString *string6 = [[_weather.suggestion objectForKey:@"uv"]objectForKey:@"brf"];
    NSString *string66 = [[_weather.suggestion objectForKey:@"uv"]objectForKey:@"txt"];

    NSString *str = [NSString stringWithFormat:@"感觉质数为%@，%@，发病质数为%@，%@，运动质数为%@，%@，出游质数为%@，%@，紫外线质数%@，%@",string2, string22,string3,string33, string4,string44, string5,string55, string6, string66];

    //把文字转成声音
    [self.synthesizer startSpeaking:str];

    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
            weakSelf.messageView = [[MessageView alloc]initWithFrame:weakSelf.view.bounds];
            [weakSelf.view addSubview:weakSelf.messageView];
            [weakSelf showGifView];
    } completion:^(BOOL finished) {
        
//        [self performSelector:@selector(pushNextController) withObject:nil afterDelay:5.0f];
        
    }];
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.messageView) {
    [self pushNextController];
    }
}
-(void)pushNextController {
     [self hideGifView];
    [self.messageView removeFromSuperview];
    self.messageView = nil;
    self.hidesBottomBarWhenPushed = YES;
    WhereViewController *whereVC = [[WhereViewController alloc]init];
    whereVC.result = self.result;
    [self.navigationController pushViewController:whereVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 语音代理方法
//成功
- (void) onCompleted:(IFlySpeechError*) error {
    if (self.messageView) {
        [self performSelector:@selector(pushNextController) withObject:nil afterDelay:1.0f];
    }else {
        return;
    }
}




//实现Deleage处理回调结果

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      NSString *string = [NSString stringWithFormat:@"%@",result.addressDetail.city];
      NSString *str = [string substringToIndex:string.length - 1];
      self.city = str;
   self.result = result;
 
}
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
    
    _locService.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
