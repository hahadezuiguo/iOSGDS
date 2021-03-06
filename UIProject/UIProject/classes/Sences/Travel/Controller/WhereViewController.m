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
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;

//美食
@property (weak, nonatomic) IBOutlet UIView *cateView;
@property (weak, nonatomic) IBOutlet UILabel *cateLabel;

//药店
@property (weak, nonatomic) IBOutlet UIView *drugstore;
@property (weak, nonatomic) IBOutlet UILabel *drugstoreLabel;

//公园
@property (weak, nonatomic) IBOutlet UIView *parkView;
@property (weak, nonatomic) IBOutlet UILabel *parkLabel;

//机场
@property (weak, nonatomic) IBOutlet UIView *airdromeView;
@property (weak, nonatomic) IBOutlet UILabel *airdromeLabel;

//洗手间
@property (weak, nonatomic) IBOutlet UIView *ToiletView;
@property (weak, nonatomic) IBOutlet UILabel *toiletLabel;

//超市
@property (weak, nonatomic) IBOutlet UIView *SupermarketView;
@property (weak, nonatomic) IBOutlet UILabel *supermarketLabel;

//游乐场
@property (weak, nonatomic) IBOutlet UIView *Playground;
@property (weak, nonatomic) IBOutlet UILabel *playgroundLabel;

//银行
@property (weak, nonatomic) IBOutlet UIView *bankView;

@property (weak, nonatomic) IBOutlet UILabel *bankLabel;

@property (nonatomic, strong) UITapGestureRecognizer * ViewTap;

@property (weak, nonatomic) IBOutlet UITextField *textField;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation WhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self viewAddTap];
    [self textFieldAction];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
   
}

- (IBAction)GoAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    MapViewController *mapVC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    [self.navigationController pushViewController:mapVC animated:YES];
    mapVC.searchString = self.textField.text;
    self.hidesBottomBarWhenPushed = NO;
    mapVC.userLocation = self.userLocation;
   
    
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
     NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    

    self.textFieldHeight.constant = height;
   
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{

    self.textFieldHeight.constant = 10;
  

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
    
    UILabel *label = [tap.view viewWithTag:101];
    
    NSLog(@"%@", label.text);
  
    self.textField.text = label.text;

    [self performSelector:@selector(GoAction:) withObject:nil afterDelay:1.5f];
    
    
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
