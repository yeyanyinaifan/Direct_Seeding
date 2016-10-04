//
//  RoomViewController.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "RoomViewController.h"
#import "RoomCell.h"
#import <AVFoundation/AVFoundation.h>

@interface RoomViewController ()
@property (nonatomic, strong)AVPlayerLayer *layer;

@end

@implementation RoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建网络地址的播放项
    AVPlayerItem *webItem = [AVPlayerItem playerItemWithURL:self.playURL];
    
    //创建播放器对象
    AVPlayer *player = [AVPlayer playerWithPlayerItem:webItem];
    
    //创建播放的layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    layer.frame = CGRectMake(0, 20, kScreenW, 200);
    //设置填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //把播放layer 添加到界面中
    [self.view.layer addSublayer:layer];
    
    self.layer = layer;
    [player play];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}
//页面第一次显示时 和每次屏幕朝向发生改变的时候执行
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //判断设备 是否是横屏
    if ([UIDevice currentDevice].orientation==UIDeviceOrientationLandscapeLeft||[UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        
        self.layer.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        
    }else{
        self.layer.frame = CGRectMake(0, 20, kScreenW, 200);
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //
    NSLog(@"%@",self.navigationController.navigationBar.subviews);
    //让导航栏背景透明
    [self.navigationController.navigationBar.subviews firstObject].hidden = YES;
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //让导航栏背景不透明
    [self.navigationController.navigationBar.subviews firstObject].hidden = NO;
}


@end
