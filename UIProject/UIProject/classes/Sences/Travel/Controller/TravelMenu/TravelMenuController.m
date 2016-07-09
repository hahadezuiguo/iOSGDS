//
//  TravelMenuController.m
//  UIProject
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 王晓南. All rights reserved.
//

#import "TravelMenuController.h"

#import "TravelViewController.h"
#import "WhereViewController.h"
#import "NaviViewController.h"
#import "MapViewController.h"

//地图定位
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件


//瀑布流
#import "DataModel.h"
#import "WaterFlowLayout.h"
#import "RootCell.h"
#import "UIImageView+WebCache.h"

#import "MenuTableViewCell.h"
#import "TravelAddressController.h"
#import "WeatherViewController.h"

#import "Travel.h"
//请求天气
#import "Weather.h"
#import "APIStoreSDK.h"
#import "NSString+JSON.h"
@interface TravelMenuController ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UICollectionViewDataSource, UICollectionViewDelegate, WaterFlowLayoutDelegate>
{
    NSMutableArray *list;  //  菜单列表数据源
    NSMutableArray *labelList;
    
    BOOL menuViewOn;
    
}

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIView *rootView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewWidth;


//定位
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;
//当前的城市
@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) BMKReverseGeoCodeResult *result;

//瀑布
//声明大数组用来存放数据
@property (nonatomic, strong) NSMutableArray *allDataArray;
//定义collectionView
@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) Weather *weather;
@end

@implementation TravelMenuController

-(NSMutableArray *)allDataArray {
    if (!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }return _allDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //读取数据
    [self loadData];
    //初始化布局
    [self initLayout];
    //注册cell
    [self.collectionView registerClass:[RootCell class] forCellWithReuseIdentifier:@"RootCell"];
    
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"tableCell"];
    
    menuViewOn = NO;
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"down"] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarButtonItemAction:)];
    
    list = [[NSMutableArray alloc]init];
    [list addObject:@"travel.jpg"];
    [list addObject:@"weathermenu.jpeg"];
    [list addObject:@"map"];
    [list addObject:@"address.jpeg"];
    labelList = [[NSMutableArray alloc]init];
    labelList = @[@"快乐出行",@"天气预报",@"地图导航",@"景点查找"].mutableCopy;
    
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    //定位
    [self locationService];
    
    
    
}

//初始化布局
-(void)initLayout {
    //1.创建UICollectionView的布局样式对象
    WaterFlowLayout *water = [[WaterFlowLayout alloc]init];
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 40)/3;
    
    water.itemSize = CGSizeMake(width, width);
    //设置内边距
    water.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //设置间距
    water.spacing = 10;
    //设置有多少列
    water.numberOfColumn = 3;
    //设置代理
    water.delegate = self;
    
    
    //2.布局UICollectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:water];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.rootView addSubview:self.collectionView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(collectionViewAction)];
    [self.collectionView addGestureRecognizer:tap];
}

//读取数据
-(void)loadData {
    //第一步：获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];
    //第二步：根据路径读取数据，转化为NSData对象
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    //第三步：根据json格式解析数据
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    
    //第四步：遍历数组将数据转为model对象
    for (NSDictionary *dict in dataArray) {
        //创建model对象
        DataModel *dataModel = [[DataModel alloc]init];
        //使用KVC 给model赋值
        [dataModel setValuesForKeysWithDictionary:dict];
        
        //添加到大数组
        [self.allDataArray addObject:dataModel];
        
    }
    
    
    
    
}

//设置分区个数
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//设置每个分区的item个数

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allDataArray.count;
}



//返回每一个item的cell对象
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"RootCell" forIndexPath:indexPath];
    //设置cell数据
    DataModel *model = self.allDataArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.thumbURL];
    
    [cell.photoView sd_setImageWithURL:url];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
    
}

//实现代理方法，返回每一个item的高度
-(CGFloat)heightFOrItemAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *model = self.allDataArray[indexPath.row];
    CGFloat width =([UIScreen mainScreen].bounds.size.width - 40.1) / 3;
    //计算item高度
    CGFloat height  = model.height / model.width * width;
    return height;
}




//定位
-(void)locationService {
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    self.userLocation = userLocation;
    [Travel shareTravel].userLocation = userLocation;
    [self getGeoCode];
}

//编码
-(void)getGeoCode {
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){_userLocation.location.coordinate.latitude, _userLocation.location.coordinate.longitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

//实现Deleage处理回调结果

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSString *string = [NSString stringWithFormat:@"%@",result.addressDetail.city];
        NSString *str = [string substringToIndex:string.length - 1];
        self.city = str;
        self.result = result;
        [self requestWeather];
        
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
    
    _locService.delegate = nil;
}

-(void)leftBarButtonItemAction:(UIBarButtonItem *)sender {
    
    if (menuViewOn == NO) {
        
        [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"up"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        //平移动画
        CABasicAnimation *basicAnimation1 = [CABasicAnimation animation];
        basicAnimation1.keyPath = @"transform.translation.x";
        basicAnimation1.fromValue = @(10);
        basicAnimation1.toValue = @(20);
        //设置成缩放动画
        CABasicAnimation *basicAnimation2 = [CABasicAnimation animation];
        basicAnimation2.keyPath = @"transform.scale";
        basicAnimation2.fromValue = @(0.1);
        basicAnimation2.toValue = @(0.8);
        //需要创建管理各个动画的动画组
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[basicAnimation1,basicAnimation2];
        
        group.duration = 0.4f;
        [self.menuTableView.layer addAnimation:group forKey:@"groupAnimatiom"];
        __weak typeof (self) weakSelf = self;
        [UIView animateWithDuration:0.4f delay:0.1f usingSpringWithDamping:0.1 initialSpringVelocity:10 options:(UIViewAnimationOptionTransitionFlipFromLeft) animations:^{
            
            weakSelf.menuTableView.alpha = 1.0f;
            weakSelf.tableViewWidth.constant = [UIScreen mainScreen].bounds.size.width / 3;
        } completion:^(BOOL finished) {
            weakSelf.viewWidth.constant = self.menuTableView.frame.size.width;
            
        }];
        menuViewOn = YES;
        
    }else {
        
        
        [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"down"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        //平移动画
        CABasicAnimation *basicAnimation1 = [CABasicAnimation animation];
        basicAnimation1.keyPath = @"transform.translation.x";
        basicAnimation1.fromValue = @(100);
        basicAnimation1.toValue = @(20);
        basicAnimation1.duration = 0.2f;
        [self.view.layer addAnimation:basicAnimation1 forKey:@"transform.translation"];
        self.tableViewWidth.constant = 0;
        self.viewWidth.constant = 0;
        menuViewOn = NO;
        
        
    }
    
    
    
    
}

//改变行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.height / 5;
}
//返回TableView中有多少数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [list count];
}
//返回有多少个TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//组装每一条的数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CustomCellIdentifier = @"tableCell";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    if (cell ==nil) {
        cell = [[MenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
    }
    
    NSString *string = [NSString stringWithFormat:@"%@",list[indexPath.row]];
    cell.menuImageView.image = [UIImage imageNamed:string];
    cell.menuLabel.text = labelList[indexPath.row];
    
    return cell;
}

//选中Cell响应事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0) {
        
        TravelViewController *viewController = [[TravelViewController alloc]init];
        viewController.userLocation = self.userLocation;
        
        [self.navigationController pushViewController:viewController animated:YES];
    } else if(indexPath.row == 1){
        
        WeatherViewController  *controller = [[WeatherViewController alloc] init];
        controller.weather = self.weather;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if(indexPath.row == 2){
        MapViewController *controller = [[MapViewController alloc] init];
        controller.userLocation = self.userLocation;
        [self.navigationController pushViewController:controller animated:YES];
        
    } else if(indexPath.row == 3){
        TravelAddressController *controller = [[TravelAddressController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}


-(void)requestWeather {
    //实例化一个回调，处理请求的返回值
    APISCallBack* callBack = [APISCallBack alloc];
    //部分请求参数
    NSString *url = @"http://apis.baidu.com/heweather/weather/free";
    NSString *method = @"post";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    
    if (self.city) {
        [parameter setObject:self.city forKey:@"city"];
    }else {
        [parameter setObject:@"承德" forKey:@"city"];
    }
    
    //请求API
    [ApiStoreSDK executeWithURL:url method:method apikey:@"c2c6467774885923b4629db0ab700dc0" parameter:parameter callBack:callBack];
    
    self.weather = [[Weather alloc]init];
    callBack.onSuccess = ^(long status, NSString* responseString) {
        if(responseString != nil) {
            
            NSDictionary *dic = [NSString parseJSONStringToNSDictionary:responseString];
            
            NSArray *array = dic[@"HeWeather data service 3.0"];
            NSDictionary *dict = array[0];
            
            [_weather setValuesForKeysWithDictionary:dict];
            
        }
        
    };
    
    callBack.onError = ^(long status, NSString* responseString) {
        NSLog(@"onError");
    };
    
    callBack.onComplete = ^() {
        NSLog(@"onComplete");
    };
    

}

-(void)collectionViewAction {
    [self leftBarButtonItemAction:nil];
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
