//
//  SaoyiSaoViewController.m
//  MiuTour
//
//  Created by Miutour on 15/7/22.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "SaoyiSaoViewController.h"

#import <AVFoundation/AVFoundation.h>



@interface SaoyiSaoViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

{
    NSTimer *animaTimer;
    //UIImageView *animaView;
}

//二维码信息Label
@property (weak, nonatomic) IBOutlet UILabel *QRCodeInfolabel;

//二维码生成的会话
@property (nonatomic, strong) AVCaptureSession *mySession;

//二维码生成的图层
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *myPreviewLayer;

@end

@implementation SaoyiSaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self saoyisaoAnimation];

    [self startTimer];
    
    [self readQRcode];

    // 初始化 下部的两个按钮
    [self createButtonItems];
    
}

- (void)startTimer
{
    animaTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(saoyisaoAnimation) userInfo:nil repeats:YES];
}


- (void)createButtonItems
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.frame = CGRectMake(20, ScreenHeight - 100, 50, 50);
    [button setTitle:@"back" forState:0];
    button.layer.cornerRadius = 25;
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:button];

}

-(void)readQRcode
{
    
    //1、获取摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    
    //2、设置输入
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        NSLog(@"没有摄像头：%@", error.localizedDescription);
        return;
    }
    
    
    //3、设置输出（metadata 元数据）
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
    //4、创建拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    //添加session的输入和输出
    [session addInput:input];
    [session addOutput:output];
    
    // 4.1 设置输出的格式
    // 提示：一定要先设置会话的输出为output之后，再指定输出的元数据类型！
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode,
                                     AVMetadataObjectTypeCode39Code,
                                     AVMetadataObjectTypeCode128Code,
                                     AVMetadataObjectTypeCode39Mod43Code,
                                     AVMetadataObjectTypeEAN13Code,
                                     AVMetadataObjectTypeEAN8Code,
                                     AVMetadataObjectTypeCode93Code]];
    
    
    // 5. 设置预览图层（用来让用户能够看到扫描情况）
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    
    // 5.1 设置preview图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    // 5.2 设置preview图层的大小
    [preview setFrame:self.view.bounds];
    
    // 5.3 将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
    
    // 5.4 添加图层上控件
    UIImageView *showLayerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, ScreenWidth - 60, ScreenWidth - 60)];
    showLayerImageView.layer.borderWidth = 2;
    showLayerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [preview addSublayer:showLayerImageView.layer];
    
    UILabel *showLayerLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(showLayerImageView.frame) + 20, 200, 20)];
    showLayerLabel.text = @"请将二维码放到框框中";
    showLayerLabel.font = [UIFont systemFontOfSize:12];
    showLayerLabel.textColor = [UIColor whiteColor];
    showLayerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLayerLabel];
    
    // 6. 启动会话
    [session startRunning];
    
    
    self.myPreviewLayer = preview;
    self.mySession = session;
    
    
}

- (void)saoyisaoAnimation
{
    UIView *animaView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 100, ScreenWidth - 60, 1)];
    animaView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:animaView];

    [UIView animateWithDuration:2 animations:^{
        animaView.frame = CGRectMake(30, 100 + ScreenWidth - 60, ScreenWidth - 60, 1);
    }completion:^(BOOL finished) {
        [animaView removeFromSuperview];
        
        // [self performSelectorOnMainThread:@selector(saoyisaoAnimation) withObject:nil waitUntilDone:YES];
    }];

}


#pragma  mark - 输出代理方法
// 此方法是在识别到QRCode，并且完成转换
// QRCode的内容越大，转换需要的时间就越长
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.mySession stopRunning];
    
    // 2. 删除预览图层
    //[self.myPreviewLayer removeFromSuperlayer];
    
    // 3. 暂停计时器
    [animaTimer invalidate];
    animaTimer = nil;
    
    NSString *resultString = [metadataObjects.firstObject valueForKey:@"stringValue"];
    
    NSLog(@"%@",resultString);
    
    NSLog(@"%@", metadataObjects);
    
    
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        //将扫描到的文字显示
        _QRCodeInfolabel.text = obj.stringValue;
        
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:resultString delegate:self cancelButtonTitle:@"重新扫描" otherButtonTitles:@"返回", nil];
        [aler show];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        [_myPreviewLayer removeFromSuperlayer];
        _myPreviewLayer = nil;
        [self readQRcode];
        [self startTimer];
        
    }
    else{
        
        [self backAction];
    }
}


- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark - 扫描二维码Action
- (IBAction)scanQRCodeAction:(id)sender {
    
    //扫描二维码
    [self readQRcode];
    
}

@end
