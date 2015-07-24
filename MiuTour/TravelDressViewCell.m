//
//  TravelDressViewCell.m
//  MiuTour
//
//  Created by Miutour on 15/7/22.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "TravelDressViewCell.h"

@implementation TravelDressViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self loadSubView];
        
    }
    return self;
}

- (void)loadSubView
{
    self.frame = CGRectMake(0, 0, ScreenWidth, 200);
    self.backgroundColor = [UIColor clearColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 198)];
    scrollView.contentSize = CGSizeMake(2 * ScreenWidth, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:scrollView];
    
    UIImageView *leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 198)];
    leftImageView.image = [UIImage imageNamed:@"bg  lvxing"];
    [scrollView addSubview:leftImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    titleLabel.center = CGPointMake(ScreenWidth * 0.5, 100);
    titleLabel.text = @"东京文化之旅";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:22];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:titleLabel];
    
    UIImageView *detailView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 200)];
    detailView.image = [UIImage imageNamed:@"bg  xiangqu"];
    [scrollView addSubview:detailView];

}


@end
