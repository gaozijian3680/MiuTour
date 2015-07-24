//
//  cheyouViewController.h
//  MiuTour
//
//  Created by Miutour on 15/7/23.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cheyouViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// UI
@property (nonatomic ,retain) UITableView *tableView0;
@property (nonatomic ,retain) UITableView *tableView1;
@property (nonatomic ,retain) UITableView *tableView2;


@property (nonatomic, strong) UIView *topMoveLineView;

@property (nonatomic, strong) UIScrollView *scrollView;



// 装三个按钮的array
@property (nonatomic, strong) NSMutableArray *arrayButton;


@end
