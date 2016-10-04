//
//  BaseWebUtils.h
//  游戏直播
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//
typedef void (^MyCallback)(id obj);
#import <Foundation/Foundation.h>

@interface BaseWebUtils : NSObject

+(void)Get:(NSString *)path andParams:(NSDictionary *)dic andCallback:(MyCallback)callback;
+(void)Post:(NSString *)path andParams:(NSDictionary *)dic andCallback:(MyCallback)callback;
@end
