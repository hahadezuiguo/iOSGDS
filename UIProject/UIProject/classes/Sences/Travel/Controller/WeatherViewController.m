//
//  WeatherViewController.m
//  UIProject
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherCell.h"
#import "OtherWeatherCell.h"
#import "TravelViewController.h"
#import "WhereViewController.h"
@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WeatherCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"OtherWeatherCell" bundle:nil] forCellReuseIdentifier:@"otherCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     Weather *weather = self.weather;
    if (indexPath.row == 0) {
        WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     
        cell.addressAndWeather.text = [NSString stringWithFormat:@"%@  %@",weather.basic[@"city"], [weather.now[@"cond"] objectForKey:@"txt"]];
        NSString *string = [NSString stringWithFormat:@"%@",[weather.now[@"cond"] objectForKey:@"txt"]];
        NSString *imageStr = [NSString stringWithFormat:@"%@.jpg",string];
        cell.weatherImageView.image = [UIImage imageNamed:imageStr];
        
        cell.dateLabel.text = [weather.daily_forecast[indexPath.row] objectForKey:@"date"];
        
        cell.tempLabel.text = [NSString stringWithFormat:@"%@°C", weather.now[@"tmp"]];
        cell.hightTemp.text = [NSString stringWithFormat:@"最高温度：%@°C",[[weather.daily_forecast[indexPath.row]objectForKey:@"tmp"]objectForKey:@"max"]];
        cell.lowTemp.text = [NSString stringWithFormat:@"最低温度：%@°C",[[weather.daily_forecast[indexPath.row]objectForKey:@"tmp"]objectForKey:@"min"]];
        cell.windLabel.text = [NSString stringWithFormat:@"%@",[[weather.daily_forecast[indexPath.row]objectForKey:@"wind"]objectForKey:@"dir"]];
        cell.windPowerLabel.text = [NSString stringWithFormat:@"风力：%@",[[weather.daily_forecast[indexPath.row]objectForKey:@"wind"]objectForKey:@"sc"]];
        cell.sunLabel.text = [NSString stringWithFormat:@"日出时间：%@     日落时间：%@",[[weather.daily_forecast[indexPath.row]objectForKey:@"astro"]objectForKey:@"sr"],[[weather.daily_forecast[indexPath.row]objectForKey:@"astro"]objectForKey:@"ss"]];

        return cell;
    }else {
        OtherWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherCell" forIndexPath:indexPath];
        
        
        cell.dateLabel.text = [weather.daily_forecast[indexPath.row] objectForKey:@"date"];
        
        NSString *string_d = [[weather.daily_forecast[indexPath.row] objectForKey:@"cond"] objectForKey:@"txt_d"];
       
        NSString *string_n = [[weather.daily_forecast[indexPath.row] objectForKey:@"cond"] objectForKey:@"txt_n"];
        NSString *imageStr_d = [NSString stringWithFormat:@"%@.jpg",string_d];
         NSString *imageStr_n = [NSString stringWithFormat:@"%@.jpg",string_n];
        cell.dImageView.image = [UIImage imageNamed:imageStr_d];
        cell.nImageView.image = [UIImage imageNamed:imageStr_n];
        
        
        
        NSString * maxTmp = [[weather.daily_forecast[indexPath.row] objectForKey:@"tmp"] objectForKey:@"max"];
        NSString * minTmp = [[weather.daily_forecast[indexPath.row] objectForKey:@"tmp"] objectForKey:@"min"];
        
        cell.tmpLabel.text = [NSString stringWithFormat:@"最高温: %@°C  最低温: %@°C",maxTmp,minTmp];
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.view.frame.size.height * 5/ 12;
    }else {
    return self.view.frame.size.height * 7/ 72 ;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelViewController *whereVC = [[TravelViewController alloc]init];
    whereVC.isSpeeching = YES;
    whereVC.weather = self.weather;
    [self.navigationController pushViewController:whereVC animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
