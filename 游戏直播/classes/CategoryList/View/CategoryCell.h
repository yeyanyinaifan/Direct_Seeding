//
//  TRCategoryCell.h
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
@interface CategoryCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *iconIV;
@property (nonatomic,strong) UILabel *titleLb;

@property (nonatomic, strong)CategoryModel *category;
@end
