//
//  LoopView.h
//  轮播图
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"
@interface SmallLoopView : UIView<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong)UICollectionView *cv;
@property (nonatomic, strong)NSArray *rooms;
@property (nonatomic, strong)NSTimer *timer;
 
 
@end
