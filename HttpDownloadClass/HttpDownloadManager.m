//
//  HttpDownloadManager.m
//  MiuTour
//
//  Created by Miutour on 15/7/23.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import "HttpDownloadManager.h"
#import "AFNetworking.h"

@interface HttpDownloadManager ()
{

    
}

@end

@implementation HttpDownloadManager

//- (void)addDownloadWithURLString:(NSString *)url withType:(DownloadURLType)type
//{
////    NSLog(@"%@",self.dictDatas);
//    // 如果任务列表中存在任务,则直接返回消息,不进行下载
//    if ([_arrayTasks containsObject:url]){
//        [[NSNotificationCenter defaultCenter]postNotificationName:url object:self];
//        return;
//    }
//    
//    // 下载好数据后 的处理事件
//    
//
//}

- (void)httpLoginWithParameters:(NSDictionary *)parameters succeed:(SucceedBlock)succeed failed:(FailedBlock)failed
{
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:base_url,@"/user/login"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succeed(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
    }];

}

- (void)httpDownloadCountrysListWithURL:(NSString *)URL withParameters:(NSDictionary *)parameters succeed:(SucceedBlock)succeed failed:(FailedBlock)failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succeed(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(error);
    }];

    // 设置请求超时时间 :
    manager.requestSerializer.timeoutInterval = 10;
    
    
    
    
}


+ (instancetype)manager
{
    static HttpDownloadManager *manager = nil;
    if (manager == nil){
        manager = [[HttpDownloadManager alloc]init];
    }
    return manager;
}

@end
