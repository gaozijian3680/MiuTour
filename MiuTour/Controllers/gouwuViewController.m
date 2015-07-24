//
//  gouwuViewController.m
//  MiuTour
//
//  Created by Miutour on 15/7/23.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "gouwuViewController.h"

#import "Public_LuXianCell.h"
#import "Public_WanLeCell.h"
#import "Public_PinCheCell.h"

@interface gouwuViewController ()

@end

@implementation gouwuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#warning 重写 父类方法
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}

#warning 重写 父类方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.tableView0 == tableView){
        Public_LuXianCell *cell = [Public_LuXianCell cellWithTableView:tableView];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"购物游";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
