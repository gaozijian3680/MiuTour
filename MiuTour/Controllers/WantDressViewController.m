//
//  WantDressViewController.m
//  MiuTour
//
//  Created by Miutour on 15/7/20.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "WantDressViewController.h"
#import "HomeViewController.h"

#import "NSString+MD5Addition.h"

@interface WantDressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *arrayDatas;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *array;


@end

@implementation WantDressViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    [self httpDownloadDatas];
}

- (NSMutableArray *)array
{
    if (_array == nil){
        _array = [NSMutableArray array];
    }
    return _array;
}


// 请求数据
- (void)httpDownloadDatas
{
//    UIDevice *device = [[UIDevice alloc]init];
//    NSString *deviceToken = [device.identifierForVendor UUIDString];
//    NSLog(@"deviceToken : %@",deviceToken);
    
    NSString *signature = @"miutour.user.xyz~";
    signature = [[NSString string] md5:signature];
    NSLog(@"%@",signature);
    
    [[HttpDownloadManager manager]httpDownloadCountrysListWithURL:[NSString stringWithFormat:base_url ,@"/service/city"] withParameters:@{@"signature":signature} succeed:^(id response) {
        
        NSLog(@"response - %@",response);
        
        // 将response 转成字典 格式
        NSDictionary *dictTemp = response;
        
        // 取出 data 数据
        _arrayDatas = dictTemp[@"data"];
        
        for (NSDictionary *dict in _arrayDatas) {
            [_array addObject:[dict objectForKey:@"name"]];
        }
        // hot项的 目录替代字符
        [_array replaceObjectAtIndex:0 withObject:@"#"];
        
        
        // 刷新列表
        [_tableView reloadData];
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];


}


- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_arrayDatas[section] objectForKey:@"list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"wantCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if ( !cell ){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [[[_arrayDatas[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text = [[[_arrayDatas[indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"name_en"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 50)];
    label.backgroundColor = UIColor_RGB(233, 233, 233, 1);
    label.font = [UIFont systemFontOfSize:15];
    label.text = [NSString stringWithFormat:@"   %@",[_arrayDatas[section] objectForKey:@"name"]];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return self.array;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    homeVC.country_info = [[[_arrayDatas objectAtIndex:indexPath.section] objectForKey:@"list"] objectAtIndex:indexPath.row];
    [homeVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];     //测试,返回主页
//    
    [self presentViewController:homeVC animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
