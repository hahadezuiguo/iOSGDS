//
//  SongDetailViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "SongDetailViewController.h"
#import "DB_URL.h"
#import "NetWordRequestManager.h"
#import "SongList.h"
#import "SongPlayViewController.h"
#import "SongDetailViewCell.h"
#import "SongViewController.h"
@interface SongDetailViewController ()
//存储歌单的数组
@property(nonatomic,strong)NSMutableArray *allSongListArr;
@end

@implementation SongDetailViewController
- (NSMutableArray *)allSongListArr{
    if (!_allSongListArr) {
        _allSongListArr = [NSMutableArray array];
    }
    return _allSongListArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self requestData];
    // Uncomment the following line to preserve selection between presentations.
    [self.tableView registerNib:[UINib nibWithNibName:@"SongDetailViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (void)requestData{
    __weak typeof(self)songDetailVC= self;
    [NetWordRequestManager requstType:GET urlString:self.sendUrl prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *allDataArr = dic[@"content"];
        for (NSDictionary *dict in allDataArr) {
            SongList *songlist = [[SongList alloc]init];
            [songlist setValuesForKeysWithDictionary:dict];
            [songDetailVC.allSongListArr addObject:songlist];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
 
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
    return self.allSongListArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    SongList *songlist = self.allSongListArr[indexPath.row];
    // Configure the cell...
    cell.songNameLabel.text = songlist.title;
    cell.albumLabel.text = songlist.author;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
