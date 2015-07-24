//
//  HomeHeaderView.m
//  MiuTour
//
//  Created by Miutour on 15/7/20.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "HomeHeaderView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

// 四个并排图标的空隙
#define Space (ScreenWidth - 4 * 45) / 5

@interface HomeHeaderView ()

{
    // 数据
    int lastIndex;

}


//@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

@property (weak, nonatomic) IBOutlet UIButton *backGround;

@property (weak, nonatomic) IBOutlet UIButton *useCarBtn;

@property (weak, nonatomic) IBOutlet UIButton *wanfaBtn;

@property (weak, nonatomic) IBOutlet UIButton *gouwuBtn;

@property (weak, nonatomic) IBOutlet UIButton *meishiBtn;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *subLabel;

@end


@implementation HomeHeaderView

- (void)awakeFromNib
{

    for (UIView *view in self.subviews) {
        view.userInteractionEnabled = YES;
    }
    self.userInteractionEnabled = YES;
//    [_segmentView addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
//    [_segmentView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"推荐行程",@"正在拼车",@"说走就走"]];
    segment.frame = CGRectMake(23, 204, [UIScreen mainScreen].bounds.size.width - 46, 29);
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [self addSubview:segment];
    
    [self bringSubviewToFront:segment];
    [self bringSubviewToFront:_useCarBtn];
    [self bringSubviewToFront:_wanfaBtn];
    [self bringSubviewToFront:_gouwuBtn];
    [self bringSubviewToFront:_meishiBtn];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始值为1
        lastIndex = 0;
        
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews
{
    self.frame = CGRectMake(0, 0, ScreenWidth, 240);
    
    // 整体的背景图片View <现图片被取消,为后续版本加背景留用>
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
//    backImageView.image = [UIImage imageNamed:@"background"];
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    
    // 可改变透明度的背景
    _redBackView = [[UIView alloc]initWithFrame:backImageView.bounds];
    _redBackView.backgroundColor = [UIColor colorWithRed:225/255.0 green:1/255.0 blue:126/255.0 alpha:1];
    _redBackView.alpha = 0;
    [backImageView addSubview:_redBackView];
    
    
    // 扫一扫
    UIButton *saoSaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saoSaoBtn.frame = CGRectMake(20, 35, 23, 23);
    [saoSaoBtn addTarget:self action:@selector(saosaoAction:) forControlEvents:UIControlEventTouchUpInside];
    [saoSaoBtn setBackgroundImage:[UIImage imageNamed:@"icon_sao"] forState:UIControlStateNormal ];
    [backImageView addSubview:saoSaoBtn];
    
    // 行程
    UIButton *xingchengBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    xingchengBtn.frame = CGRectMake(ScreenWidth - 20 - 27, 35, 27, 27);
    [xingchengBtn addTarget:self action:@selector(xingchengAction:) forControlEvents:UIControlEventTouchUpInside];
    [xingchengBtn setBackgroundImage:[UIImage imageNamed:@"icon_xingcheng"] forState:UIControlStateNormal ];
    [backImageView addSubview:xingchengBtn];
    
    // 地点标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleLabel.center = CGPointMake(ScreenWidth * 0.5 , 70);
    titleLabel.text = @"东京 ";  // 接口数据
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:25];
    [backImageView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    // 地点副标题<英文>
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 57, 20)];
    subLabel.center = CGPointMake(ScreenWidth * 0.5, CGRectGetMaxY(titleLabel.frame) + 8);
    subLabel.text = @"Tokyo";
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.textColor = [UIColor lightGrayColor];
    subLabel.font = [UIFont systemFontOfSize:12];
    [backImageView addSubview:subLabel];
    _subLabel = subLabel;
    
    // 四个固定按钮
    NSArray *btnName = @[@"icon_yongche",@"icon_wanfa",@"icon_gouwu",@"icon_meishi"];
    NSArray *labelName = @[@"用车",@"最in玩法",@"旅游购",@"美食游"];
    for (int i = 0; i < 4; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setBackgroundImage:[UIImage imageNamed:btnName[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(Space * (i+1) + i * 45, CGRectGetMaxY(subLabel.frame) + 20, 45, 45);
        [backImageView addSubview:button];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = labelName[i];
        label.frame = CGRectMake(button.frame.origin.x, CGRectGetMaxY(button.frame) + 5, 45, 15);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [backImageView addSubview:label];
        
    }
    
    // segment 视图
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"推荐行程",@"正在拼车",@"说走就走"]];
    segment.frame = CGRectMake(23, 204, [UIScreen mainScreen].bounds.size.width - 46, 29);
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segment];

    
}

#pragma mark - 设置头部上的国家信息
- (void)setCountry_info:(NSDictionary *)country_info
{
    _country_info = country_info;
    
    _titleLabel.text = [country_info objectForKey:@"name"];
    
    _subLabel.text = [country_info objectForKey:@"name_en"];
    
}



- (void)segmentValueChanged:(UISegmentedControl *)seg
{
    if ([_delegate respondsToSelector:@selector(homeHeaderView:segmentValueDidChangedFromIndex:toIndex:)]){
        [_delegate homeHeaderView:self segmentValueDidChangedFromIndex:lastIndex toIndex:seg.selectedSegmentIndex];
    }
    lastIndex = seg.selectedSegmentIndex;
    
    NSLog(@"%d",seg.selectedSegmentIndex);
    
}

- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%d",sender.tag);  // 100 -- 103

    if ([_delegate respondsToSelector:@selector(homeHeaderView:arrayButtonActionToTurnWithSender:withTag:)]){
        [_delegate homeHeaderView:self arrayButtonActionToTurnWithSender:sender withTag:sender.tag];
    }

}


- (void)saosaoAction:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(homeHeaderView:saosaoActionToTurn:)]){
        [_delegate homeHeaderView:self saosaoActionToTurn:sender];
    }
    
}

- (void)xingchengAction:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(homeHeaderView:xingchengActionToTurn:)]){
        [_delegate homeHeaderView:self xingchengActionToTurn:sender];
    }
}

@end
