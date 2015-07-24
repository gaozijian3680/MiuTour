//
//  HomeViewController.m
//  MiuTour
//
//  Created by Miutour on 15/7/20.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "SaoyiSaoViewController.h"
#import "TabBarController.h"

#import <CoreLocation/CoreLocation.h>

#import "MainViewCell.h"
#import "TravelDressViewCell.h"

#define ChangeCount -55   // (55)越大,头部流出的宽度越大

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

// *********** test headFile ************
#import "MainViewController.h"




@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,HomeHeaderViewDelegate,CLLocationManagerDelegate>

// UI
@property (nonatomic ,retain) UITableView *tableView0;
@property (nonatomic ,retain) UITableView *tableView1;
@property (nonatomic ,retain) UITableView *tableView2;


@property (nonatomic ,retain) CLLocationManager *locationManager;

@property (nonatomic ,weak) HomeHeaderView *headerView;

@property (nonatomic ,weak) UIImageView *bottomView;

@property (nonatomic ,weak) UIScrollView *scrollView;

// 反地理编码 对象
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic,retain) NSMutableArray *arrayDatas;

@end

@implementation HomeViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)arrayDatas
{
    if (_arrayDatas == nil){
        _arrayDatas = [NSMutableArray array];
    }
    return _arrayDatas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createScrollView];
    
    [self createBottomView];
    
    [self locationDressAtNow];
    
    
}

- (void)locationDressAtNow
{
    _locationManager = [[CLLocationManager alloc]init];
    

    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    [_locationManager startUpdatingLocation];


}



#pragma mark - 最底层的CollectionView
- (void)createScrollView//createCollectionView
{
//    item1
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(3 * ScreenWidth, [UIScreen mainScreen].bounds.size.height);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
//    // 创建三个tableView
    [self createTableView0];
//    [self createTableView1];
//    [self createTableView2];
    
    
    
    
    //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
//    
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
//    
//    [self.view addSubview:collectionView];
//
//    collectionView registerClass:<#(__unsafe_unretained Class)#> forCellWithReuseIdentifier:<#(NSString *)#>
//    
}


#pragma mark - 加载View整体头部视图
- (void)loadHomeHeaderView
{
    HomeHeaderView *headerView = [[HomeHeaderView alloc]init];
    //[[NSBundle mainBundle]loadNibNamed:@"HomeHeaderView1" owner:nil options:nil].lastObject;
    //headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240);
    headerView.delegate = self;
    [self.view addSubview:headerView];
    
    _headerView = headerView;
    
        // 控制器在加载时 改变header上的值
    _headerView.country_info = _country_info;
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backImageView.image = [UIImage imageNamed:@"back1"];
    [self.view addSubview:backImageView];
    [self.view sendSubviewToBack:backImageView];

}

#pragma mark - tableView的创建及协议方法
- (void)createTableView0
{
    _tableView0 = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];

    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    
    _tableView0.rowHeight = 200;
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView0];
    
    // 设置tableView 的偏移量在HeaderView的下部
    _tableView0.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);
    
    // headerView位于tableView的顶层
    [self loadHomeHeaderView];
    
}

- (void)createTableView1
{
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    
    _tableView1.contentOffset = CGPointMake(0, -240);
    _tableView1.rowHeight = 230;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView1];
    
    // 设置tableView 的偏移量在HeaderView的下部
    _tableView1.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);

    
}

- (void)createTableView2
{
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    
    _tableView2.contentOffset = CGPointMake(0, -240);
    _tableView2.rowHeight = 230;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView2];
    
    // 设置tableView 的偏移量在HeaderView的下部
    _tableView2.contentInset = UIEdgeInsetsMake(240, 0, 0, 0);
    
}




- (void)createBottomView
{
    UIImageView *bottomView =[[UIImageView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50,ScreenWidth , 50)];
//    bottomView.image = [UIImage imageNamed:@"bottomBg"];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    bottomBtn.frame = CGRectMake(0, 0, 200, 30);
    bottomBtn.center = CGPointMake(ScreenWidth * 0.5, 20);
    bottomBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:90/255.0 blue:95/255.0 alpha:1];
    [bottomBtn setTitle:@"我要拼车" forState:0];
    bottomBtn.layer.borderWidth = 1;
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:0];
    bottomBtn.layer.borderColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:0.8].CGColor;
    bottomBtn.layer.cornerRadius = 5;
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bottomView addSubview:bottomBtn];
    _bottomView = bottomView;
    _bottomView.hidden = YES;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 20;
   // return self.arrayDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableView0 == tableView){
        static NSString *cellID = @"MainCell";
        
        TravelDressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if ( !cell ){
            cell = [[TravelDressViewCell alloc]init];
        }
        
        return cell;
    }
    
    
    else {// if (_tableView1 == tableView){
        
        static NSString *cellID = @"HomeCell";
        
        MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if ( !cell ){
            cell = [[MainViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        return cell;
    }
    
    
//    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) return;
    

    if (scrollView.contentOffset.y <= ChangeCount && scrollView.contentOffset.y >= -240){   // 定位偏移量1
        CGRect frame = _headerView.frame;
        frame.origin.y = -scrollView.contentOffset.y - 240;
        _headerView.frame = frame;
    }
    
    // ***** 优化头部 的滑动定位效果 *****
    // 固定 tableView的 顶部限位
    if (scrollView.contentOffset.y <= -240) [scrollView setContentOffset:CGPointMake(0, -240)];
    
    // <优化> 保证头部始终能固定在窗口最顶端
    if (scrollView.contentOffset.y >= ChangeCount) {    // 定位偏移量2
        CGRect frame = _headerView.frame;
        frame.origin.y = -240 - ChangeCount;      // 定位偏移量3
        _headerView.frame = frame;
    }
    
    

    
    // 头部视图 粉色背景的最大透明度 设置
    if (scrollView.contentOffset.y >= ChangeCount && scrollView.contentOffset.y <= 0){
        _headerView.redBackView.alpha = (( scrollView.contentOffset.y - ChangeCount) / (- ChangeCount)) * 0.97;
    }
    
    // ************** 优化最大透明度 ***********
    if (scrollView.contentOffset.y >= 0){
        _headerView.redBackView.alpha = 0.97;
    }
    
    if (scrollView.contentOffset.y <= ChangeCount){
        _headerView.redBackView.alpha = 0;
    }
    // **************************************
    

    
 
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 底层滚动视图的滚动停止效果时 , 创建tableView
    if (_scrollView == scrollView){
        _headerView.redBackView.alpha = 0;
        
        int index = scrollView.contentOffset.x / ScreenWidth;
        switch (index) {
            case 0:
            {
                if (_tableView0 == nil){
                    [self createTableView0];
                    
                }
//                [UIView animateWithDuration:0.5 animations:^{
//                    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 240);
//                    
//                }completion:^(BOOL finished) {
                    [_tableView0 setContentOffset:CGPointMake(0, -240) animated:YES];
                
//                }];
                
            }
                break;
                
            case 1:
            {
                if (_tableView1 == nil){
                    [self createTableView1];
                    
                }
                
//                [UIView animateWithDuration:0.5 animations:^{
//                    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 240);
//                }completion:^(BOOL finished) {
                    [_tableView1 setContentOffset:CGPointMake(0, -240) animated:YES];
//                }];
            }
                break;
                
            case 2:
            {
                if (_tableView2 == nil){
                    [self createTableView2];
                    
                }
                
//                [UIView animateWithDuration:0.5 animations:^{
//                    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 240);
//                }completion:^(BOOL finished) {
                    [_tableView2 setContentOffset:CGPointMake(0, -240) animated:YES];
//                }];
                
            }
                break;
                
            default:
                break;
        }
        
        
        
        return;
    }

}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // 去除scrollView 的速度效果
    if (scrollView == _scrollView) return;
    
    
    //    向上滑
    if (velocity.y >= 0.1){
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = _bottomView.frame;
            frame.origin.y = [UIScreen mainScreen].bounds.size.height;
            _bottomView.frame = frame;
        }];
    }
    //    向下滑
    else {
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = _bottomView.frame;
            frame.origin.y = [UIScreen mainScreen].bounds.size.height - 50;
            _bottomView.frame = frame;
            
        }];
        
    }
}

#pragma mark - homeHeaderView 协议方法

- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView segmentValueDidChangedFromIndex:(NSInteger)index toIndex:(NSInteger)toIndex
{
    if (index == toIndex) return;
    
    if (toIndex == 1) _bottomView.hidden = NO;
    else _bottomView.hidden = YES;
    
    [_scrollView setContentOffset:CGPointMake(toIndex * ScreenWidth, 0) animated:YES];
    
    [UIView animateWithDuration:0.25 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        _headerView.frame = CGRectMake(0, 0, ScreenWidth, 240);
    } completion:^(BOOL finished) {
        
    }];
    
    // 性能优化
    switch (toIndex) {
        case 0:
            if (_tableView0.contentOffset.y == -240){
               
            }
            
            break;
          
        case 1:
            if (_tableView1.contentOffset.y == -240){
                
            }
            
            break;
            
        case 2:
            if (_tableView2.contentOffset.y == -240){
                

            }
            
            break;
            
        default:
            break;
    }

    
}

- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView xingchengActionToTurn:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView saosaoActionToTurn:(UIButton *)sender
{
    /*
     UIModalTransitionStyleCoverVertical = 0,
     UIModalTransitionStyleFlipHorizontal,
     UIModalTransitionStyleCrossDissolve,
     UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2),
     */
    
    SaoyiSaoViewController *saosaoVC = [[SaoyiSaoViewController alloc]init];
    [saosaoVC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:saosaoVC animated:YES completion:nil];
}

- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView arrayButtonActionToTurnWithSender:(UIButton *)sender withTag:(NSUInteger)tag
{
    if (tag == 101){
        TabBarController *tabBarC = [[TabBarController alloc]init];
        [tabBarC setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:tabBarC animated:YES completion:nil];
    }
}


#pragma mark - 定位服务

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"faile");
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"error");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.firstObject;
    
    _geocoder = [[CLGeocoder alloc]init];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = placemarks.firstObject;
        /*
         *name; // eg. Apple Inc.
         *thoroughfare; // street address, eg. 1 Infinite Loop
         *subThoroughfare; // eg. 1
         *locality; // city, eg. Cupertino
         *subLocality; // neighborhood, common name, eg. Mission District
         *administrativeArea; // state, eg. CA
         *subAdministrativeArea; // county, eg. Santa Clara
         *postalCode; // zip code, eg. 95014
         *ISOcountryCode; // eg. US
         *country; // eg. United States
         *inlandWater; // eg. Lake Tahoe
         *ocean; // eg. Pacific Ocean
         *areasOfInterest; // eg. Golden Gate Park
         */
        
        NSLog(@"country: %@",placemark.country);
        NSLog(@"ISOcountryCode: %@",placemark.ISOcountryCode);
        NSLog(@"locality: %@",placemark.locality);
        NSLog(@"name: %@",placemark.name);
        NSLog(@"thoroughfare: %@",placemark.thoroughfare);
        NSLog(@"subThoroughfare: %@",placemark.subThoroughfare);
        NSLog(@"subLocality: %@",placemark.subLocality);
        NSLog(@"administrativeArea: %@",placemark.administrativeArea);
        NSLog(@"subAdministrativeArea: %@",placemark.subAdministrativeArea);
        NSLog(@"postalCode: %@",placemark.postalCode);
        NSLog(@"inlandWater: %@",placemark.inlandWater);
        NSLog(@"ocean: %@",placemark.ocean);
        NSLog(@"areasOfInterest: %@",placemark.areasOfInterest);

    }];
    
    NSLog(@"<用户当前位置>纬度%f, 经度%f",location.coordinate.latitude,location.coordinate.longitude);
    
    
    [manager stopUpdatingLocation ];
    
}




// **************** 测试代码 **************

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    MainViewController *mainView = [[MainViewController alloc]init];
//    mainView.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
//    [self presentViewController:mainView animated:YES completion:nil];
//
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
