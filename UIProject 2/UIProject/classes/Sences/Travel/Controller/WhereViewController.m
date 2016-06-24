//
//  WhereViewController.m
//  Where
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "WhereViewController.h"
#import "MapViewController.h"
@interface WhereViewController ()<UITextFieldDelegate>
//医院
@property (weak, nonatomic) IBOutlet UIView *hospitalView;
//美食
@property (weak, nonatomic) IBOutlet UIView *cateView;
//药店
@property (weak, nonatomic) IBOutlet UIView *drugstore;
//公园
@property (weak, nonatomic) IBOutlet UIView *parkView;
//机场
@property (weak, nonatomic) IBOutlet UIView *airdromeView;
//洗手间
@property (weak, nonatomic) IBOutlet UIView *ToiletView;
//超市
@property (weak, nonatomic) IBOutlet UIView *SupermarketView;
//游乐场
@property (weak, nonatomic) IBOutlet UIView *Playground;
//银行
@property (weak, nonatomic) IBOutlet UIView *bankView;


@property (nonatomic, strong) UITapGestureRecognizer * ViewTap;

@property (weak, nonatomic) IBOutlet UITextField *textField;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldHeight;

@end

@implementation WhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self viewAddTap];
    [self textFieldAction];
    self.navigationController.navigationBar.translucent = NO;
    
}



- (IBAction)GoAction:(id)sender {
    MapViewController *mapVC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
    mapVC.searchString = self.textField.text;
}


//键盘处理
-(void)textFieldAction {
    self.textField.delegate = self;
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

   
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    /*
     iphone 6:
     中文
     2014-12-31 11:16:23.643 Demo[686:41289] 键盘高度是  258
     2014-12-31 11:16:23.644 Demo[686:41289] 键盘宽度是  375
     英文
     2014-12-31 11:55:21.417 Demo[1102:58972] 键盘高度是  216
     2014-12-31 11:55:21.417 Demo[1102:58972] 键盘宽度是  375
     
     iphone  6 plus：
     英文：
     2014-12-31 11:31:14.669 Demo[928:50593] 键盘高度是  226
     2014-12-31 11:31:14.669 Demo[928:50593] 键盘宽度是  414
     中文：
     2015-01-07 09:22:49.438 Demo[622:14908] 键盘高度是  271
     2015-01-07 09:22:49.439 Demo[622:14908] 键盘宽度是  414
     
     iphone 5 :
     2014-12-31 11:19:36.452 Demo[755:43233] 键盘高度是  216
     2014-12-31 11:19:36.452 Demo[755:43233] 键盘宽度是  320
     */
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    int offset = CGRectGetMaxY(self.view.frame) - (self.view.frame.size.height - height);
    if (offset > 0) {
        //整个视图向上移动
        self.view.frame = CGRectMake(0, -offset, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

//view添加事件
-(void)viewAddTap {
    for (int i = 1; i < 10; i++) {
        
        self.ViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [[self.view viewWithTag:i] addGestureRecognizer:self.ViewTap];
    }
    

}


-(void)tapAction:(UITapGestureRecognizer *)tap{
    CASpringAnimation *springAnimation = [CASpringAnimation animation];
    springAnimation.keyPath = @"transform.scale";
    
    springAnimation.fromValue = @1;
    springAnimation.toValue = @1.5;
    springAnimation.duration = 1.5f;
    
    
    [tap.view.layer addAnimation:springAnimation forKey:@"springAnimation"];
    NSLog(@"点击");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
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
