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

@interface TravelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UITextView *weatherText;

@property (nonatomic, strong) MessageView *messageView;
@end

@implementation TravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
   
    
  
    
    
// Weather *weather = [WhereDataHandle getNowWeatherWithAddressString:@"保定"];
    
    //实例化一个回调，处理请求的返回值
    APISCallBack* callBack = [APISCallBack alloc];
    Weather *weather = [[Weather alloc]init];
    __weak typeof(self) weakSelf = self;
    callBack.onSuccess = ^(long status, NSString* responseString) {
        NSLog(@"onSuccess");
        if(responseString != nil) {
            
            NSDictionary *dic = [NSString parseJSONStringToNSDictionary:responseString];
            
            NSArray *array = dic[@"HeWeather data service 3.0"];
            NSDictionary *dict = array[0];
           
            [weather setValuesForKeysWithDictionary:dict];
            NSString *string = [weather.basic[@"update"] objectForKey:@"loc"];
            weakSelf.dateLabel.text = [NSString stringWithFormat:@"今天：%@",[string substringToIndex:10]];
            
            
            
            NSString *string1 = [[weather.daily_forecast[0] objectForKey:@"cond"]objectForKey:@"txt_d"];
            NSString *string2 = [[weather.daily_forecast[0] objectForKey:@"cond"]objectForKey:@"txt_n"];
            NSString *string3 = [[weather.daily_forecast[0] objectForKey:@"tmp"]objectForKey:@"max"];
            NSString *string4 = [[weather.daily_forecast[0] objectForKey:@"tmp"]objectForKey:@"min"];
            NSString *string5 = [[weather.daily_forecast[0] objectForKey:@"wind"]objectForKey:@"dir"];
            NSString *string6 = [[weather.daily_forecast[0] objectForKey:@"wind"]objectForKey:@"sc"];
            NSString *str = [NSString stringWithFormat:@"今天天气%@转%@，最高气温%@，最低气温%@，%@%@",string1,string2,string3,string4,string5,string6];
            
            weakSelf.weatherText.text = str;

        }
        
    };
    
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
    };
    
    callBack.onComplete = ^() {
        NSLog(@"onComplete");
    };
    //部分请求参数
    NSString *url = @"http://apis.baidu.com/heweather/weather/free";
    NSString *method = @"post";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:@"保定" forKey:@"city"];
    
    //请求API
        [ApiStoreSDK executeWithURL:url method:method apikey:@"c2c6467774885923b4629db0ab700dc0" parameter:parameter callBack:callBack];
    
    
    
    
    
    
    
}
- (IBAction)GoAction:(id)sender {
    
    if (self.messageView == nil) {
        self.messageView = [[MessageView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)];
        self.messageView.center = self.view.center;
        
        [self.view addSubview:self.messageView];
        
        [self.messageView.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
   
}

-(void)buttonAction:(UIButton *)sender {
    if (self.messageView) {
     [self.messageView removeFromSuperview];
    }
    self.hidesBottomBarWhenPushed = YES;
    WhereViewController *whereVC = [[WhereViewController alloc]init];
    [self.navigationController pushViewController:whereVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
