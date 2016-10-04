//
//  BaseWebUtils.m
//  游戏直播
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "BaseWebUtils.h"

@implementation BaseWebUtils
+(void)Get:(NSString *)path andParams:(NSDictionary *)dic andCallback:(MyCallback)callback{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callback(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        callback(nil);
    }];
    
    
    
    
}

+(void)Post:(NSString *)path andParams:(NSDictionary *)dic andCallback:(MyCallback)callback{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager new];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:path parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        callback(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        callback(nil);
    }];
}@end
