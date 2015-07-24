//
//  ZuiIN_LuXianCell.h
//  MiuTour
//
//  Created by Miutour on 15/7/24.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Public_LuXianCell : UITableViewCell

/**
 *  背景图片 */
@property (nonatomic, strong) UIImageView *topImageView;

/**
 *  主标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  星星数 */
@property (nonatomic, strong) UIImageView *starImage;

/**
 *  购买人数 */
@property (nonatomic, strong) UILabel *buyLabel;

/**
 *  喜欢图标 */
@property (nonatomic, strong) UIButton *likeIcon;



+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
