//
//  SheetView.m
//  UIProject
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "SheetView.h"
#import "SheetTableViewCell.h"
#import "SheetModel.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@implementation SheetView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (instancetype)initWithInforArray:(NSArray *)infors{
    
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kWidth, kHeight);
        
        self.myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeight, kWidth, 44 * (infors.count)) style:UITableViewStylePlain];
        self.myTable.delegate = self;
        self.myTable.dataSource = self;
        //self.myTable.backgroundColor = [UIColor lightGrayColor];
        self.dataArray = infors;
        [self addSubview:self.myTable];
        [self.myTable registerClass:[SheetTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return self;
}

- (void)layoutSubviews{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.myTable.frame = CGRectMake(0, kHeight - weakSelf.myTable.frame.size.height, kWidth, weakSelf.myTable.frame.size.height);
        
        weakSelf.alpha = 1;
    } completion:^(BOOL finished) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(tapAction)];
        tap.delegate = weakSelf;
        [weakSelf addGestureRecognizer:tap];
    }];
}
//以前没用过，重点记忆
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isKindOfClass:[self class]]){
        return YES;//返回YES优先响应tap事件，点击事件如did select  需要按时间长点，才能响应。
    }
    NSLog(@"waimianwaimianwaimianwaimian");
    return NO;//返回NO,阻隔手势识别器，不响应tap事件
}

- (void)tapAction {
    
    self.myTable.frame = CGRectMake(0, kHeight, kWidth, 0);
    
    [self removeFromSuperview];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    SheetModel *model = self.dataArray[indexPath.row];
    cell.InfoLabel.text = model.title;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)showInView:(UIViewController *)Sview
{
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];//没用过，重点记记忆！！！！！！！！！！！！
    }else{
        
        [Sview.view addSubview:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tapAction];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedRow:)]) {
        [_delegate selectedRow:indexPath.row];
        return;
    }
    
}



@end
