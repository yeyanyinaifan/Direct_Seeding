//
//  HomeTopCell.h
//  游戏直播
//
//  Created by tarena on 16/9/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoopView.h"
#import "SmallLoopView.h"
@interface HomeTopCell : UICollectionViewCell
@property (nonatomic, strong)SmallLoopView *slv;
@property (nonatomic, strong)NSArray *userRooms;


@property (nonatomic, strong)LoopView *lv;
@property (nonatomic, strong)NSArray *rooms;


@end
