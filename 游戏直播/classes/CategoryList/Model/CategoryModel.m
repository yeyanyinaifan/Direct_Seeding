//
//  CategoryModel.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"ID":@"id"}];
    
}

@end
