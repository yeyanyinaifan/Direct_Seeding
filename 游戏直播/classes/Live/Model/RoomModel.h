//
//  RoomModel.h
//  游戏直播
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RoomModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *default_image;

@property (nonatomic, copy) NSString<Optional> *slug;

@property (nonatomic, copy) NSString<Optional> *weight;

@property (nonatomic, copy) NSString<Optional> *status;

@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *category_name;

@property (nonatomic, assign) NSNumber<Optional> *hidden;

@property (nonatomic, copy) NSString<Optional> *intro;

@property (nonatomic, copy) NSString<Optional> *category_slug;

@property (nonatomic, copy) NSString<Optional> *recommend_image;

@property (nonatomic, copy) NSString<Optional> *play_at;

@property (nonatomic, copy) NSString<Optional> *app_shuffling_image;

@property (nonatomic, copy) NSString<Optional> *level;

@property (nonatomic, copy) NSString<Optional> *uid;

@property (nonatomic, copy) NSString<Optional> *announcement;

@property (nonatomic, copy) NSString<Optional> *nick;

@property (nonatomic, copy) NSString<Optional> *grade;

@property (nonatomic, strong) NSURL<Optional> *thumb;

@property (nonatomic, copy) NSString<Optional> *create_at;

@property (nonatomic, copy) NSString<Optional> *video_quality;

@property (nonatomic, copy) NSString<Optional> *avatar;

@property (nonatomic, copy) NSString<Optional> *view;

@property (nonatomic, copy) NSString<Optional> *start_time;

@property (nonatomic, copy) NSString<Optional> *category_id;

@property (nonatomic, assign) NSNumber<Optional> *follow;
//Ignore  使用此关键字修饰的话  解析跟它没关系
@property (nonatomic, strong)NSURL<Ignore> *playURL;

@end
