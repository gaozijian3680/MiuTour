//
//  TabBarController.m
//  MiuTour
//
//  Created by Miutour on 15/7/23.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "TabBarController.h"
#import "meishiViewController.h"
#import "gouwuViewController.h"
#import "cheyouViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化隐藏 tabbar
    self.tabBar.hidden = YES;
    
    [self createTopView];
    
    [self addSubViewControllers];
    
}

- (void)createTopView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    topView.backgroundColor = UIColor_RGB(225, 1, 126, 1);
    [self.view addSubview:topView];
    
    UISegmentedControl *segmentView = [[UISegmentedControl alloc]initWithItems:@[@"最in车游",@"购物游",@"美食游"]];
    segmentView.frame = CGRectMake(0, 0, ScreenWidth * 0.7, 29);
    segmentView.center = CGPointMake(ScreenWidth * 0.5, 44);
    segmentView.tintColor = [UIColor whiteColor];
    segmentView.selectedSegmentIndex = 0;
    [segmentView addTarget:self action:@selector(segmentValueDidChanged:) forControlEvents:UIControlEventValueChanged];
    [topView addSubview:segmentView];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(10, 30, 40, 22);
    [backButton setTitle:@"back" forState:0];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleColor:[UIColor whiteColor] forState:0];
    [topView addSubview:backButton];
    
    
}

- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)addSubViewControllers
{
    self.viewControllers = @[[[cheyouViewController alloc]init],[[gouwuViewController alloc]init],[[meishiViewController alloc]init]];

}

- (void)segmentValueDidChanged:(UISegmentedControl *)segment
{
    self.selectedIndex = segment.selectedSegmentIndex;

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
