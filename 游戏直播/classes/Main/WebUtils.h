//
//  WebUtils.h
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import <AFNetworking.h>
#import <Foundation/Foundation.h>
typedef void (^MyCallback)(id obj);
@interface WebUtils : NSObject
+(void)requestCategorysWithCallback:(MyCallback)callback;
+(void)requestRoomsWithPage:(int)page andCallback:(MyCallback)callback;
+(void)requestRoomsWithCategory:(NSString *)category andPage:(int)page andCallback:(MyCallback)callback;
+(void)requestRoomsWithName:(NSString *)name andCallback:(MyCallback)callback;
+(void)requestHomeInfoWithCallback:(MyCallback)callback;

@end
