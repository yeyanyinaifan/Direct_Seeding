//
//  RoomModel.m
//  游戏直播
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel
-(NSURL<Ignore> *)playURL{
    if (!_playURL) {
        _playURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://hls.quanmin.tv/live/%@/playlist.m3u8",self.uid]];
    }
    
    return _playURL;
}
@end
