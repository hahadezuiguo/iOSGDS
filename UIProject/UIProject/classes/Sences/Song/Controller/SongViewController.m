//
//  SongViewController.m
//  UIProject
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "SongViewController.h"
#import "SongCollectionView.h"
#import "SongCollectionViewCell.h"
#import "SongDetailViewController.h"
#import "NetWordRequestManager.h"
#import "DB_URL.h"
#import "Song.h"
@interface SongViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *collectionBGview;
@property(nonatomic,strong)SongCollectionView *rootView;
//存储list数据的数组
@property(nonatomic,strong)NSMutableArray *allListArr;
@end

@implementation SongViewController
//懒加载
- (NSMutableArray *)allListArr{
    if (!_allListArr) {
        _allListArr = [NSMutableArray array];
    }
    return _allListArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.rootView = [[SongCollectionView alloc] initWithFrame:self.collectionBGview.frame];
    [self.collectionBGview addSubview:self.rootView];
    //先初始化以后，才能设置代理
    self.rootView.collection.delegate = self;
    self.rootView.collection.dataSource = self;
    //注册cell
    [self.rootView.collection registerNib:[UINib nibWithNibName:@"SongCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ccell"];
    [self requestData];
}
- (void)requestData{
    __weak typeof(self)songVC= self;
    [NetWordRequestManager requstType:GET urlString:SONG_ALLLIST_URL prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *allDataArr = dic[@"content"];
        for (NSDictionary *dict in allDataArr) {
            Song *song = [[Song alloc]init];
            [song setValuesForKeysWithDictionary:dict];
            [songVC.allListArr addObject:song];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.rootView.collection reloadData];
        });
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 实现collectionView方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allListArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SongCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccell" forIndexPath:indexPath];
    Song *song = self.allListArr[indexPath.row];
    cell.song = song;
    if (song.songMainimage != nil) {
        cell.UpImage.image = song.songMainimage;
    }else{
        [song loadImage];
        //使用KVO监听image的变化
        [song addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:(void *)CFBridgingRetain(indexPath)];
    }
    return cell;
}
//监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    //获取图片
    UIImage *image = change[NSKeyValueChangeNewKey];
    //获取cell位置
    NSIndexPath *indexPath = (__bridge NSIndexPath *)context;
    
    //获取cell
    SongCollectionViewCell *cell = (SongCollectionViewCell *)[self.rootView.collection cellForItemAtIndexPath:indexPath];
    cell.UpImage.image = image;
    //释放indexpath权限
    CFBridgingRelease((__bridge CFTypeRef _Nullable)(indexPath));
    //移除观察者
    [object removeObserver:self forKeyPath:@"image" context:context];
    //[self.tableView reloadData];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SongDetailViewController *songDVC = [[SongDetailViewController alloc]init];
    switch (indexPath.row) {
        case 10:
            songDVC.sendUrl = SONG_C1_URL;
            break;
        case 11:
            songDVC.sendUrl = SONG_C2_URL;
            break;
        case 12:
            songDVC.sendUrl = SONG_C3_URL;
            break;
        case 13:
            songDVC.sendUrl = SONG_C4_URL;
            break;
        case 14:
            songDVC.sendUrl = SONG_C5_URL;
            break;
        case 15:
            songDVC.sendUrl = SONG_C6_URL;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:songDVC animated:YES];
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
