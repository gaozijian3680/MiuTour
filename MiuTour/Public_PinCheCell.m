//
//  ZuiIN_PinCheCell.m
//  MiuTour
//
//  Created by Miutour on 15/7/24.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "Public_PinCheCell.h"

@interface Public_PinCheCell ()

@property (nonatomic ,assign) int waitPersonNumber;

@end

@implementation Public_PinCheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _waitPersonNumber = 2;
        
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self loadSubviews];
        
    }
    
    return self;
}


- (void)loadSubviews
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 0;
    view.clipsToBounds =YES;
    [self addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, view.frame.size.width , 130)];
    imageView.image = [UIImage imageNamed:@"bg2x"];
    [view addSubview:imageView];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, view.frame.size.width - 10, 20)];
    topLabel.font = [UIFont systemFontOfSize:13];
    topLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    topLabel.text = @"【拼车一日游】皇居+东京大学+台湾海滨公园";
    [view addSubview:topLabel];
    
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"icon-heart-2x"] forState:UIControlStateNormal];
    likeBtn.frame = CGRectMake(10, 10, 20, 20);
    [imageView addSubview:likeBtn];
    
    // 磨砂效果 图层 <会出现卡顿现象,暂时取消模糊操作>
    //    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    //    visualEffect.frame = CGRectMake(200, 0, ScreenWidth - 200, 130);
    //    visualEffect.alpha = 0.7;
    //    visualEffect.contentView.backgroundColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:0.7];
    //    [imageView addSubview:visualEffect];
    
    // 模糊效果图层
    UIView *visualEffectView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth - 120, 0, 120, 130)];
    visualEffectView.backgroundColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:0.7];
    [imageView addSubview:visualEffectView];
    
    // 出发日期
    UILabel *goTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 20)];
    goTime.text = @"出发日期";
    goTime.textColor = [UIColor whiteColor];
    goTime.font = [UIFont systemFontOfSize:10];
    [visualEffectView addSubview:goTime];
    
    UILabel *goTimeDetail = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 30)];
    goTimeDetail.text = @"2015-10-10";
    goTimeDetail.textColor = [UIColor whiteColor];
    goTimeDetail.font = [UIFont systemFontOfSize:16];
    [visualEffectView addSubview:goTimeDetail];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, imageView.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [visualEffectView addSubview:lineView];
    
    // 等待拼车
    UILabel *waitPerson = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 50, 10)];
    waitPerson.text = @"等待拼车";
    waitPerson.font = [UIFont systemFontOfSize:10];
    waitPerson.textColor = [UIColor whiteColor];
    [visualEffectView addSubview:waitPerson];
    
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        if (_waitPersonNumber > i){
            imageView.image = [UIImage imageNamed:@"icon-person-1x"];
        }else {
            imageView.image = [UIImage imageNamed:@"icon-person-grey-1x"];
        }
        
        imageView.frame = CGRectMake(8 + 8 * i, 100, 7, 15);
        [visualEffectView addSubview:imageView];
    }
    
    // 还差 几人 <段落特性,第三个数字大写> 未处理
    
    UILabel *lastPersonNum = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 50, 20)];
    lastPersonNum.text = @"还差 2人";
    lastPersonNum.textColor = [UIColor whiteColor];
    lastPersonNum.font = [UIFont systemFontOfSize:11];
    [visualEffectView addSubview:lastPersonNum];
    
    // "拼车截止时间"
    UIImageView *overTime = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame) + 8, 10, 10)];
    overTime.image = [UIImage imageNamed:@"icon-shijian-1x"];
    [view addSubview:overTime];
    
    UILabel *overTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, overTime.frame.origin.y , 100, 10)];
    overTimeLabel.text = @"拼车截止时间";
    overTimeLabel.font = [UIFont systemFontOfSize:10];
    overTimeLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:overTimeLabel];
    
    
    // "拼车价格"
    UIImageView *findMoney= [[UIImageView alloc]initWithFrame:CGRectMake(115, CGRectGetMaxY(imageView.frame) + 8, 10, 10)];
    findMoney.image = [UIImage imageNamed:@"icon-shijian-1x"];
    [view addSubview:findMoney];
    
    UILabel *findMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, overTime.frame.origin.y , 100, 10)];
    findMoneyLabel.text = @"拼车价格";
    findMoneyLabel.font = [UIFont systemFontOfSize:10];
    findMoneyLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:findMoneyLabel];
    
    // "参与拼车"
    UIButton *comeInBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    comeInBtn.frame = CGRectMake(210, 180, 80, 30);
    comeInBtn.layer.cornerRadius = 3;
    comeInBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    comeInBtn.clipsToBounds = YES;
    comeInBtn.backgroundColor = [UIColor colorWithRed:0 green:160/255.0 blue:234/255.0 alpha:1];
    [comeInBtn setTitle:@"参与拼车" forState:0];
    [comeInBtn setTitleColor:[UIColor whiteColor] forState:0];
    [view addSubview:comeInBtn];
    
    
    // 截止时间 <改变, 具体时间>
    UILabel *overTimes = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(overTimeLabel.frame) + 5, 50, 20)];
    overTimes.text = @"04:59";
    overTimes.textColor = [UIColor darkGrayColor];
    overTimes.font = [UIFont systemFontOfSize:15];
    [view addSubview:overTimes];
    
    // 钱数 <red>
    UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(115, overTimes.frame.origin.y, 30, 20)];
    moneyLabel.text = @"￥50";
    moneyLabel.textColor = [UIColor redColor];
    moneyLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:moneyLabel];
    
    // "/人起"
    UILabel *renqi = [[UILabel alloc]initWithFrame:CGRectMake(150, overTimes.frame.origin.y, 50, 20)];
    renqi.text = @"/人起";
    renqi.textColor = [UIColor darkGrayColor];
    renqi.font = [UIFont systemFontOfSize:10];
    [view addSubview:renqi];
    
    
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"MainCell";
    Public_PinCheCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if ( !cell ){
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}


@end
