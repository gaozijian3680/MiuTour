//
//  HomeHeaderView.h
//  MiuTour
//
//  Created by Miutour on 15/7/20.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeHeaderView;

@protocol HomeHeaderViewDelegate <NSObject>

@optional
/**
 * segment按钮点击 */
- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView segmentValueDidChangedFromIndex:(NSInteger)index toIndex:(NSInteger)toIndex;

/**
 * 行程按钮点击 */
- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView xingchengActionToTurn:(UIButton *)sender;

/** 
 * 扫一扫按钮点击 */
- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView saosaoActionToTurn:(UIButton *)sender;

/** 
 *排列的一组按钮被点击 */
- (void)homeHeaderView:(HomeHeaderView *)homeHeaderView arrayButtonActionToTurnWithSender:(UIButton *)sender withTag:(NSUInteger)tag;


@end


@interface HomeHeaderView : UIView

// 设置国家信息
@property (nonatomic, strong) NSDictionary *country_info;

@property (nonatomic ,strong) UIView *redBackView;

@property (nonatomic ,assign) id<HomeHeaderViewDelegate> delegate;

@end
