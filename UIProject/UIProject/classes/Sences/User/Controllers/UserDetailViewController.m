//
//  UserDetailViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "UserDetailViewController.h"

#import "ImageCell.h"
#import "NormalCell.h"

#define kImageCell @"ImageCell"
#define kNormalCell @"NormalCell"
@interface UserDetailViewController ()  <UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *infoTableView;


@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    
    //注册cell
    [self.infoTableView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellReuseIdentifier:kImageCell];
    [self.infoTableView registerNib:[UINib nibWithNibName:@"NormalCell" bundle:nil] forCellReuseIdentifier:kNormalCell];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 实现代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:kImageCell forIndexPath:indexPath];
        return imageCell;
    }
    NormalCell *normalCell = [tableView dequeueReusableCellWithIdentifier:kNormalCell forIndexPath:indexPath];
    return normalCell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (IBAction)logoutACtion:(id)sender {
    
    
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
