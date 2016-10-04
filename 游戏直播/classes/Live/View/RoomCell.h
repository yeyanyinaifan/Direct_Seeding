//
//  RoomCell.h
//  游戏直播
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"
@interface RoomCell : UICollectionViewCell
@property (nonatomic, strong)RoomModel *room;

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *roomIV;
@property (nonatomic, strong)UIButton *userNameBtn;
@property (nonatomic, strong)UIButton *userCountBtn;
@property (nonatomic, strong)UIView *bgView;
@end
