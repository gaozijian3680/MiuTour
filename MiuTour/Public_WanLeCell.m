//
//  ZuiIN_WanLeCell.m
//  MiuTour
//
//  Created by Miutour on 15/7/24.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "Public_WanLeCell.h"

@interface Public_WanLeCell ()

/**
 * 多少￥ /人起 */
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation Public_WanLeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 标签bg ImageView
        UIImageView *labelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 100, 150, 100, 40)];
        labelImageView.backgroundColor = [UIColor blueColor];
        [self.topImageView addSubview:labelImageView];
        
        // **人起 label
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 30, 15)];
        label.text = @"人起";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [labelImageView addSubview:label];
        
        _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 50, 20)];
        _moneyLabel.textColor = [UIColor whiteColor];
        [labelImageView addSubview:_moneyLabel];
        
        
        [self test0];
        
    }
    return self;
}


- (void)test0
{
    
    self.titleLabel.text = @"[半日游] 东京茶道体验";
    _moneyLabel.text = @"￥500";

}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"wanfaCell";
    Public_WanLeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if ( !cell ){
        cell = [[Public_WanLeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
