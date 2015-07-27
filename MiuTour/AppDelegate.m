//
//  AppDelegate.m
//  MiuTour
//
//  Created by Miutour on 15/7/20.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@property (nonatomic, copy, readonly) NSString *deviceToken;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self.window setBackgroundColor:[UIColor whiteColor]];

    self.window.rootViewController = [[MainViewController alloc]init];
    
    
    
    // 注册 推送服务
    [self registerAPNs:application];

    //调用接口
    [[HttpDownloadManager manager]httpLoginWithParameters:@{@"username":@"gaozijian",@"passwd":@"gaozijian",@"devicetoken":@"15f18a2bea039e1ae51584f909597d794337c61ab74524ccb74a12a0c10a972a",@"type":@"iOS",@"signature":@"miutour.user.xyz~"} succeed:^(id response) {
        NSLog(@"%@",response);
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    return YES;
}

#pragma mark - 1. 注册
-(void)registerAPNs:(UIApplication *)application
{
    
#ifdef __IPHONE_8_0
    //在IOS8下
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //注册远程消息推送
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    }
    else {
        //在IOS8之前的版本会执行
        //注册远程消息推送
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
    
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
    
}
//注册远程消息成功(APNs上注册成功)
#pragma mark - 回调 拿deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //将deviceToken装换成字符串
    _deviceToken = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];

    //规范格式
    _deviceToken = [_deviceToken substringWithRange:NSMakeRange(1, _deviceToken.length - 1)];
    _deviceToken = [_deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"deviceToken%@",_deviceToken);
    
#pragma mark - 把deviceToken发送后台
    //调用接口
    [[HttpDownloadManager manager]httpLoginWithParameters:@{@"username":@"gaozijian",@"passwd":@"gaozijian",@"devicetoken":_deviceToken,@"type":@"iOS",@"signature":@"miutour.user.xyz~"} succeed:^(id response) {
        NSLog(@"%@",response);
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}
//注册远程消息失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"远程推送注册失败: %@",error);
}

#pragma mark - 接受远程消息推送的数据
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    /*
     推送过来接收到得信息，其中aps中，alert，badge，sound是苹果固定的格式，不能修改，但是苹果推送消息，不能超过256字节(b)也就是128个汉字，输入超过，推送失败
     {
     aps =  {
     alert = "hello";//推送内容
     badge = 1;  //角标
     sound = default; //声音
     };
     }
     */
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
