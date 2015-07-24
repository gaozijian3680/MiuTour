//
//  MainViewController.m
//  MiuTour
//
//  Created by Miutour on 15/7/20.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "MainViewController.h"
#import "WantDressViewController.h"
#import "MainSmallView.h"
#import "HomeViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define FontSize 23
#define LogoSize 50  // Logo 的宽和高

@interface MainViewController () //<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic ,retain) NSArray *arrayDress;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createMainImageViews];
    
    _arrayDress = @[@"东京",@"大阪",@"普吉岛",@"清迈",@"长滩岛",@"京都"];
    
}

- (void)createMainImageViews
{
    // 创建三个 imageView
    UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.333 * ScreenHeight)];
    firstImage.userInteractionEnabled = YES;
    firstImage.backgroundColor = [UIColor whiteColor];
    firstImage.image = [UIImage imageNamed:@"bg  行程"];
    [self.view addSubview:firstImage];
    
    UIImageView *secondImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 ,CGRectGetMaxY(firstImage.frame) + 1, ScreenWidth, 0.333 * ScreenHeight)];
    secondImage.userInteractionEnabled = YES;
    secondImage.image = [UIImage imageNamed:@"bg  lvxing"];
    [self.view addSubview:secondImage];
    
    UIImageView *thirdImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 ,CGRectGetMaxY(secondImage.frame) + 1,  ScreenWidth, 0.333 * ScreenHeight)];
    thirdImage.userInteractionEnabled = YES;
    [thirdImage addGestureRecognizer:[self createTapGes]];
    thirdImage.image = [UIImage imageNamed:@"bg  xiangqu"];
    [self.view addSubview:thirdImage];
    
    
    // 创建imageView 上的imageView以及label
    UIImageView *firstLogo = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, LogoSize, LogoSize)];
    firstLogo.center = CGPointMake(0.5 * ScreenWidth, 0.5 * firstImage.frame.size.height - 10);
    firstLogo.image = [UIImage imageNamed:@"icon xingcheng"];
    [firstImage addSubview:firstLogo];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    firstLabel.center = CGPointMake(0.5 * ScreenWidth, firstLogo.center.y + LogoSize );
    firstLabel.textAlignment = NSTextAlignmentCenter;
    firstLabel.textColor = [UIColor whiteColor];
    firstLabel.text = @"查看我的旅行";
    firstLabel.font = [UIFont systemFontOfSize:FontSize];
    [firstImage addSubview:firstLabel];
    
    
    
    UIImageView *secondLogo = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, LogoSize, LogoSize)];
    secondLogo.center = CGPointMake(0.5 * ScreenWidth, 0.5 * secondImage.frame.size.height- 30);   // 设置logo的向上偏移量
    secondLogo.image = [UIImage imageNamed:@"icon lvxing"];
    [secondImage addSubview:secondLogo];
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    secondLabel.center = CGPointMake(0.5 * ScreenWidth, secondLogo.center.y + LogoSize - 10);
    secondLabel.textAlignment = NSTextAlignmentCenter;
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.text = @"我在旅行中";
    secondLabel.font = [UIFont systemFontOfSize:FontSize];
    [secondImage addSubview:secondLabel];
    
    UIButton *locationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 40)];
    locationBtn.center = CGPointMake(0.5 * ScreenWidth, secondLabel.center.y + 40);
    locationBtn.backgroundColor = [UIColor clearColor];
    locationBtn.layer.cornerRadius = 20;
    locationBtn.layer.borderWidth = 1.5;
    
    // 添加 两种状态的点击事件
    [locationBtn addTarget:self action:@selector(locationDressAtNowUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [locationBtn addTarget:self action:@selector(locationDressAtNowDown:) forControlEvents:UIControlEventTouchDown];
    
    locationBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [locationBtn setTitle:@"立即定位" forState:UIControlStateNormal];
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [secondImage addSubview:locationBtn];
    
    
    UIImageView *thirdLogo = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, LogoSize, LogoSize)];
    thirdLogo.center = CGPointMake(0.5 * ScreenWidth, 0.5 * firstImage.frame.size.height - 40);
    thirdLogo.image = [UIImage imageNamed:@"icon xiangqu"];
    [thirdImage addSubview:thirdLogo];
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    thirdLabel.center = CGPointMake(0.5 * ScreenWidth, secondLogo.center.y + 35);
    thirdLabel.textAlignment = NSTextAlignmentCenter;
    thirdLabel.textColor = [UIColor whiteColor];
    thirdLabel.text = @"我想要去...";
    thirdLabel.font = [UIFont systemFontOfSize:FontSize];
    [thirdImage addSubview:thirdLabel];
    
    MainSmallView *dressView = [[NSBundle mainBundle]loadNibNamed:@"MainSmallView" owner:nil options:nil].lastObject;
    dressView.frame = CGRectMake(0, 0, 250, 43);
    dressView.center = CGPointMake(0.5 * ScreenWidth, thirdLabel.center.y + 35);
    [thirdImage addSubview:dressView];

    //UITableView *pickerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 60, 100) style:UITableViewStylePlain];
    
//    pickerTableView
    
    
//    UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 100, 300)];
//    pickerView.center = CGPointMake(0.5 * ScreenWidth, CGRectGetMaxY(thirdLabel.frame) - 100);
//    
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
//    [thirdImage addSubview:pickerView];
//    
}

//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return 6;
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return _arrayDress[row];
//}

#pragma mark - 创建立即定位的点击事件 <实现点击的变化效果>

- (void)locationDressAtNowUpInside:(UIButton *)sender
{
    sender.backgroundColor = [UIColor clearColor];
    
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    [self presentViewController:homeVC animated:YES completion:nil];
    
    
}

- (void)locationDressAtNowDown:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
}




#pragma mark - 创建三个单击手势
- (UITapGestureRecognizer *)createTapGes
{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesAction:)];
    tapGes.numberOfTapsRequired = 1;
    return tapGes;
}

- (void)tapGesAction:(UITapGestureRecognizer *)ges
{
    WantDressViewController *wantVC = [[WantDressViewController alloc]init];
    [self presentViewController:wantVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
