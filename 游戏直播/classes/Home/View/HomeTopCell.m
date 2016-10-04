//
//  HomeTopCell.m
//  游戏直播
//
//  Created by tarena on 16/9/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "HomeTopCell.h"

@implementation HomeTopCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lv = [[LoopView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 210)];
        [self addSubview:self.lv];
        
        
        self.slv = [[SmallLoopView alloc]initWithFrame:CGRectMake(0, 210, self.bounds.size.width,100)];
//        self.slv.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.slv];
        
        
        
        
    }
    return self;
}
-(void)setUserRooms:(NSArray *)userRooms{
    _userRooms = userRooms;
    self.slv.rooms = userRooms;
}

-(void)setRooms:(NSArray *)rooms{
    _rooms = rooms;
    
    self.lv.rooms = rooms;
    
    
}
@end
