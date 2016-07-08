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

#import <SDWebImage/UIImage+GIF.h>

//引入头文件
//文字识别的回调方法接口
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>

//文字识别对象
#import <iflyMSC/IFlySpeechSynthesizer.h>

//科大讯飞语音框架定义的常量
#import <iflyMSC/IFlySpeechConstant.h>


@interface TravelViewController ()<IFlySpeechSynthesizerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *weatherText;

@property (nonatomic, strong) NSArray *messageArray;
@property (nonatomic, assign) NSInteger weatherCount;

@property (nonatomic, strong) MessageView *messageView;
//文字识别对象
@property (strong, nonatomic) IFlySpeechSynthesizer *synthesizer;


@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;


@end

@implementation TravelViewController

-(void)viewDidAppear:(BOOL)animated {
    if (self.isSpeeching == YES) {
        [self tapAction:nil];
    }
    self.isSpeeching = NO;
}
-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    
  
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addWeatherImageView];
       //创建文字识别对象
    [self createSynthesizer];

    
    //播放第一条并加入Timer设定切换间隔时间
    [self msgChange];
    [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(msgChange) userInfo:nil repeats:YES];
    
}

-(void)addWeatherImageView {
    UIImage *image = [UIImage sd_animatedGIFNamed:@"weaherImageView"];
    self.weatherImageView.image = image;
    self.weatherImageView.alpha = 0.6f;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.weatherImageView addGestureRecognizer:tap];
}

-(void)tapAction:(UITapGestureRecognizer *)tap {
    

    //    NSString *string2 = [[_weather.suggestion objectForKey:@"comf"]objectForKey:@"brf"];
    NSString *string22 = [[_weather.suggestion objectForKey:@"comf"]objectForKey:@"txt"];
    
    //    NSString *string3 = [[_weather.suggestion objectForKey:@"flu"]objectForKey:@"brf"];
    NSString *string33 = [[_weather.suggestion objectForKey:@"flu"]objectForKey:@"txt"];
    
    //    NSString *string4 = [[_weather.suggestion objectForKey:@"sport"]objectForKey:@"brf"];
    NSString *string44 = [[_weather.suggestion objectForKey:@"sport"]objectForKey:@"txt"];
    
    //    NSString *string5 = [[_weather.suggestion objectForKey:@"trav"]objectForKey:@"brf"];
    //    NSString *string55 = [[_weather.suggestion objectForKey:@"trav"]objectForKey:@"txt"];
    //
    //    NSString *string6 = [[_weather.suggestion objectForKey:@"uv"]objectForKey:@"brf"];
    //    NSString *string66 = [[_weather.suggestion objectForKey:@"uv"]objectForKey:@"txt"];
    
    //    NSString *str = [NSString stringWithFormat:@"感觉质数为%@，%@，发病质数为%@，%@，运动质数为%@，%@，出游质数为%@，%@，紫外线质数%@，%@",string2, string22,string3,string33, string4,string44, string5,string55, string6, string66];
    NSString *string = [NSString stringWithFormat:@"今天%@，%@，%@",string22,string33,string44];
    
    //把文字转成声音
    [self.synthesizer startSpeaking:string];
    
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:2 animations:^{
        weakSelf.messageView = [[MessageView alloc]initWithFrame:weakSelf.view.bounds];
        [weakSelf.view addSubview:weakSelf.messageView];
        [weakSelf showGifView];
    } completion:^(BOOL finished) {
        
        
    }];
    
}


-(void)requestWeather {
            NSString *string = [_weather.basic[@"update"] objectForKey:@"loc"];
            self.dateLabel.text = [NSString stringWithFormat:@"今天：%@",[string substringToIndex:10]];
            NSString *string1 = [[_weather.daily_forecast[0] objectForKey:@"cond"]objectForKey:@"txt_d"];
            NSString *string2 = [[_weather.daily_forecast[0] objectForKey:@"cond"]objectForKey:@"txt_n"];

            NSString *string3 = [[_weather.daily_forecast[0] objectForKey:@"tmp"]objectForKey:@"max"];
            NSString *string4 = [[_weather.daily_forecast[0] objectForKey:@"tmp"]objectForKey:@"min"];
            NSString *string5 = [[_weather.daily_forecast[0] objectForKey:@"wind"]objectForKey:@"dir"];
            NSString *string6 = [[_weather.daily_forecast[0] objectForKey:@"wind"]objectForKey:@"sc"];
            
            self.messageArray = [NSArray arrayWithObjects:@"温馨提示",
                                     [NSString stringWithFormat:@"今天天气白天%@,晚上%@",string1,string2],
                                     [NSString stringWithFormat:@"最高气温%@度",string3],
                                     [NSString stringWithFormat:@"最低气温%@度",string4],
                                     [NSString stringWithFormat:@" %@ 风力%@",string5, string6],
                                     @"出行请注意天气变化",
                                     nil];
            self.weatherCount = 0;
}
-(void)createSynthesizer {
    //创建文字识别对象
    self.synthesizer = [IFlySpeechSynthesizer sharedInstance];
    
    //指定文字识别对象的代理对象
    self.synthesizer.delegate = self;
    
    //设置文字识别对象的关键属性
    [self.synthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    [self.synthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    [self.synthesizer setParameter:@"vils" forKey:[IFlySpeechConstant VOICE_NAME]];
    [self.synthesizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    [self.synthesizer setParameter:@"temp.pcm" forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    [self.synthesizer setParameter:@"custom" forKey:[IFlySpeechConstant PARAMS]];

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
    [MBProgressHUD setUpGifWithFrame:CGRectMake(0, 0, 150,150) gifName:@"where" text:self.messageArray[1] andShowToView:self.messageView];
}
-(void)hideGifView {
    [MBProgressHUD hideHUDForView:self.messageView animated:YES];
}





- (IBAction)GoAction:(id)sender {
    
[self pushNextController];
  
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.messageView) {
    [self pushNextController];
    [self.synthesizer stopSpeaking];
    }
}
-(void)pushNextController {
     [self hideGifView];
    [self.messageView removeFromSuperview];
    self.messageView = nil;
    self.hidesBottomBarWhenPushed = YES;
    WhereViewController *whereVC = [[WhereViewController alloc]init];
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
