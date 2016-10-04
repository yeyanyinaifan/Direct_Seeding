//
//  CategoryModel.h
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CategoryModel : JSONModel
@property (nonatomic, copy) NSString *slug;

@property (nonatomic, copy) NSString *first_letter;

@property (nonatomic, assign) NSInteger status;
//id -> ID
@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger prompt;

@property (nonatomic, strong) NSURL *image;

@property (nonatomic, strong) NSURL *thumb;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, copy) NSString *name;
@end
