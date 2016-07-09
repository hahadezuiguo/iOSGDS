//
//  ChangeUserNameController.m
//  UIProject
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "ChangeUserNameController.h"

@interface ChangeUserNameController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *textField;



@end

@implementation ChangeUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.delegate = self;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    //    回收键盘,取消第一响应者
    [self.textField resignFirstResponder];

    return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.textField resignFirstResponder];

}



- (IBAction)sureAction:(id)sender {
    if (self.textField.text.length > 0) {
         self.myBlock(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
