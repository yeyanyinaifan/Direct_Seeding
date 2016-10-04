//
//  SearchingViewController.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SearchingViewController.h"
#import <SVPullToRefresh.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "RoomModel.h"
#import "RoomCell.h"

@interface SearchingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *rooms;
@property (nonatomic)int page;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UISearchBar *sb;
@end

@implementation SearchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UISearchBar *sb = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    sb.placeholder = @"请输入搜索的内容";
    self.sb = sb;
    //添加到导航栏的中间
    self.navigationItem.titleView = sb;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索_默认"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    
    self.page = 1;
    
    //创建CollectionView代码
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:fl];
    collectionView.backgroundColor = kRGBA(240, 240, 240, 1);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //注册Cell
    [collectionView registerClass:[RoomCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索_默认"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    
}

-(void)searchAction{
    [WebUtils requestRoomsWithName:self.sb.text andCallback:^(id obj) {
        
        self.rooms = obj;
        [self.collectionView reloadData];
        
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.rooms.count==0) {
        [self.collectionView triggerPullToRefresh];
    }
}
#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.rooms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.room = self.rooms[indexPath.row];
    return cell;
    
    
}

//控制显示大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float size = (kScreenW-3*kMargin)/2;
    return CGSizeMake(size, size*.8);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(kMargin, kMargin, 0, kMargin);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //需要导入<AVFoundation> 和AVKit
    RoomModel *room = self.rooms[indexPath.row];
    
    AVPlayerViewController *vc = [AVPlayerViewController new];
    vc.player = [AVPlayer playerWithURL:room.playURL];
    [vc.player play];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
