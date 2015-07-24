//
//  ZuiIN_LuXianCell.m
//  MiuTour
//
//  Created by Miutour on 15/7/24.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "Public_LuXianCell.h"

@interface Public_LuXianCell ()


@end

@implementation Public_LuXianCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.frame = CGRectMake(0, 0, ScreenWidth, 260 );
        self.backgroundColor = [UIColor whiteColor];
    
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
        [self addSubview:_topImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _topImageView.frame.size.height + 10,  300, 20)];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
        
        _starImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame) + 5, 200, 15)];
        [self addSubview:_starImage];
        
        _buyLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, _starImage.frame.origin.y, 100, 15)];
        _buyLabel.font = [UIFont systemFontOfSize:11];
        _buyLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_buyLabel];
        
        _likeIcon = [UIButton buttonWithType:UIButtonTypeSystem];
        _likeIcon.frame = CGRectMake(5, 10, 50, 30);
        _likeIcon.titleLabel.font = [UIFont systemFontOfSize:10];
        [_topImageView addSubview:_likeIcon];
     
#warning test
#pragma mark - 测试方法
        // 测试方法
        [self test];
        
        
        
    }
    return self;
}

- (void)test
{
    _topImageView.image = [UIImage imageNamed:@"background"];
    _titleLabel.text = @"[一日游] 皇居+东京大学+东京塔";
    _buyLabel.text = @"155人已购买";
    _likeIcon.backgroundColor = [UIColor lightGrayColor];
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"luxianCell";
    Public_LuXianCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if ( !cell ){
        cell = [[Public_LuXianCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
