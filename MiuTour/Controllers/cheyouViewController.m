//
//  cheyouViewController.m
//  MiuTour
//
//  Created by Miutour on 15/7/23.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "cheyouViewController.h"
#import "Public_LuXianCell.h"
#import "Public_PinCheCell.h"
#import "Public_WanLeCell.h"

#import "MainViewCell.h"

#define ButtonWidth 80

@interface cheyouViewController () 

@end

@implementation cheyouViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTopView];
    
    [self createScrollView];
    
    
    // 初始启动 tableView0
    [self createTableView0];
}

- (NSMutableArray *)arrayButton
{
    if (_arrayButton == nil){
        _arrayButton = [NSMutableArray array];
    }
    return _arrayButton;
}

- (void)createTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 44)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    NSArray *array = @[@"车游路线",@"正在拼车",@"当地玩乐"];
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake((ScreenWidth - 3 * ButtonWidth) / 4 + ((ScreenWidth - 3 * ButtonWidth) / 4 + ButtonWidth) * i , 12, ButtonWidth, 20);
        button.tag = i;
        [button setTitle:array[i] forState:0];
        [button setTitleColor:[UIColor darkGrayColor] forState:0];
        [button addTarget:self action:@selector(topButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.arrayButton addObject:button];
        [topView addSubview:button];
        
    }
    
    // 顶部的线段移动动画
    _topMoveLineView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth - 3 * ButtonWidth) / 4 , 40, ButtonWidth, 3)];
    _topMoveLineView.backgroundColor = UIColor_RGB(225, 1, 126, 1);
    [topView addSubview:_topMoveLineView];
    
}

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, ScreenWidth, ScreenHeight - 108)];
    _scrollView.contentSize = CGSizeMake(3 * ScreenWidth, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = UIColor_RGB(233, 233, 233, 1);
    [self.view addSubview:_scrollView];
    
    
}
#pragma mark - tableView的创建及协议方法
- (void)createTableView0
{
    _tableView0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _scrollView.frame.size.height)  style:UITableViewStylePlain];
    
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    
    _tableView0.rowHeight = 260;
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView0];
    
    // 设置tableView 的偏移量在HeaderView的下部
    _tableView0.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    _tableView0.contentOffset = CGPointMake(0, -10);
    
    
}

- (void)createTableView1
{
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
    
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    
    _tableView1.rowHeight = 230;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView1.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView1];
    
    // 设置tableView 的偏移量在HeaderView的下部
    _tableView1.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    _tableView1.contentOffset = CGPointMake(0, -10);

    
}

- (void)createTableView2
{
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, _scrollView.frame.size.height) style:UITableViewStylePlain];
    
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    
    _tableView2.rowHeight = 260;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView2];
    
    // 设置tableView 的偏移量在HeaderView的下部
    _tableView2.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    _tableView2.contentOffset = CGPointMake(0, -10);

    
}

// 懒加载 每个tableVIew
- (void)loadTableViewsAtIndex:(NSInteger)index
{
    switch (index) {
        case 0: {
            if (_tableView0 == nil){
                [self createTableView0];
            }
        }
            break;
            
        case 1: {
            if (_tableView1 == nil){
                [self createTableView1];
            }
        }
            break;
            
        case 2: {
            if (_tableView2 == nil){
                [self createTableView2];
            }
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark - tableView 的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableView0){
        Public_LuXianCell *cell = [Public_LuXianCell cellWithTableView:tableView];
        
        return cell;
    }
    
    if (tableView == _tableView2){
        Public_WanLeCell *cell = [Public_WanLeCell cellWithTableView:tableView];
    
        return cell;
    }
    
    Public_PinCheCell *cell = [Public_PinCheCell cellWithTableView:tableView];
    
    return cell;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self changePageAtScrollView:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changePageAtScrollView:scrollView];
}

- (void)changePageAtScrollView:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView){
        
        NSInteger index = scrollView.contentOffset.x / ScreenWidth;
        
        // 加载 tableView
        [self loadTableViewsAtIndex:index];
        
        
        CGRect frame = _topMoveLineView.frame;
        UIButton *button = _arrayButton[index];
        frame.origin.x = button.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            _topMoveLineView.frame = frame;
        }];
        
    }
}




- (void)topButtonDidClicked:(UIButton *)sender
{
    // 顶部的线段移动动画
    CGRect frame = _topMoveLineView.frame;
    frame.origin.x = sender.frame.origin.x;
    [UIView animateWithDuration:0.25 animations:^{
        _topMoveLineView.frame = frame;
    }];
    
    // 根据sender 绑定的值 切换scrollView 位置
    [_scrollView setContentOffset:CGPointMake(sender.tag * ScreenWidth, 0) animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
