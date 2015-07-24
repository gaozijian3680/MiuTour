//
//  HttpDownloadManager.h
//  MiuTour
//
//  Created by Miutour on 15/7/23.
//  Copyright (c) 2015年 Miutour. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SucceedBlock)(id response);
typedef void(^FailedBlock)(NSError *error);

@interface HttpDownloadManager : NSObject

// 下载任务列表
@property (nonatomic, strong) NSMutableArray *arrayTasks;

// 下载到的数据 存储位置
@property (nonatomic, strong) NSMutableDictionary *dictDatas;



#pragma mark - block 下载方法

/**
 *  登录接口
 */
- (void)httpLoginWithParameters:(NSDictionary *)parameters succeed:(SucceedBlock)succeed failed:(FailedBlock)failed;


/**
 * 下载国家列表
 */
- (void)httpDownloadCountrysListWithURL:(NSString *)URL withParameters:(NSDictionary *)parameters succeed:(SucceedBlock)succeed failed:(FailedBlock)failed;


+ (instancetype)manager;

@end
