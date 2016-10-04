//
//  HomeViewController.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import "LiveListViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "HomeSectionHeaderView.h"
#import <SVPullToRefresh.h>
#import "HomeViewController.h"
#import "SearchingViewController.h"
#import "RoomCell.h"
#import "RoomModel.h"
#import "HomeTopCell.h"
#import "RoomViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,LoopViewDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSDictionary *homeInfoDic;
@property (nonatomic, strong)NSArray *listArr;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"搜索_默认"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    
    
    
    //创建CollectionView代码
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:fl];
    collectionView.backgroundColor = kRGBA(240, 240, 240, 1);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
   
    //注册Cell
    [collectionView registerClass:[HomeTopCell class] forCellWithReuseIdentifier:@"topCell"];
    
    //注册Cell
    [collectionView registerClass:[RoomCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
 __weak typeof (self) weakSelf = self;
    //添加下拉刷新
    [self.collectionView addPullToRefreshWithActionHandler:^{
        
       [WebUtils requestHomeInfoWithCallback:^(id obj) {
          
           weakSelf.homeInfoDic = obj;
           weakSelf.listArr = obj[@"list"];
           
           [weakSelf.collectionView reloadData];
           [collectionView.pullToRefreshView stopAnimating];
       }];
        
        
        
    }];

    [self.collectionView triggerPullToRefresh];
    //注册组头
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeSectionHeaderView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionView"];
    
}

-(void)searchAction{
    SearchingViewController *vc = [SearchingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//


#pragma mark UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //因为字典中有多余的数据 所以需要-2
    return self.homeInfoDic.count-2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    
    if (section==2) {
        return 4;
    }
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HomeTopCell *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        topCell.rooms = self.homeInfoDic[@"mobile-index"];
        topCell.lv.delegate = self;
        topCell.userRooms = self.homeInfoDic[@"mobile-star"];
        return topCell;
        
    }
    //得到目录里面相对应的字典
    NSDictionary *dic = self.listArr[indexPath.section+1];
    //取到key
    NSString *key = dic[@"slug"];
//    通过key得到字典中对应的房间数组
    NSArray *rooms = self.homeInfoDic[key];
    RoomModel *room = nil;
    
 
    
    if (indexPath.section==1) {//如果是推荐 随机取
        room = rooms[arc4random()%rooms.count];
        
    }else{//除了推荐 是从数组中挨个取
        room = rooms[indexPath.row];
    }
    RoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.room = room;

 
   
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.listArr[indexPath.section+1];
    //取到key
    NSString *key = dic[@"slug"];
    //    通过key得到字典中对应的房间数组
    NSArray *rooms = self.homeInfoDic[key];
    RoomModel *room = rooms[indexPath.row];
    
    //需要导入<AVFoundation> 和AVKit
    RoomViewController *vc = [RoomViewController new];
    vc.playURL = room.playURL;
    //隐藏tabbar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:nil];
    
}

//控制显示大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return CGSizeMake(kScreenW, 210+110);
    }
    
    float size = (kScreenW-3*kMargin)/2;
    return CGSizeMake(size, size*.8);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kMargin;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HomeSectionHeaderView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionView" forIndexPath:indexPath];
        NSDictionary *dic = self.listArr[indexPath.section+1];
        view.titleLabel.text = dic[@"name"];
        
        if ([view.titleLabel.text isEqualToString:@"精彩推荐"]) {
            [view.rightBtn setTitle:@"换一换" forState:UIControlStateNormal];
            [view.rightBtn setImage:[UIImage imageNamed:@"换一换"] forState:UIControlStateNormal];
        }else{
            [view.rightBtn setTitle:@"更多" forState:UIControlStateNormal];
            [view.rightBtn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        }
        
        view.rightBtn.tag = indexPath.section+1;
        //给组头里面的按钮添加点击事件
        [view.rightBtn addTarget:self action:@selector(sectionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
       
        return view;
    
    }
    
    return view;
}

-(void)sectionBtnAction:(UIButton *)btn{
    
    
    if ([[btn titleForState:UIControlStateNormal] isEqualToString:@"换一换"]) {
        //重新刷新推荐这一组
         [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        
        
    }else{
    NSDictionary *dic = self.listArr[btn.tag];
    
    NSString *slug = dic[@"category_slug"];
    
    
    LiveListViewController *vc = [LiveListViewController new];
    
    vc.slug = slug;
    
    [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section > 0) {
        return CGSizeMake(0, 40); //宽度无用, 永远与collectionView同宽
    }
    return CGSizeZero;
}
#pragma mark LoopViewDelegate
-(void)didTapItemWithRoomPath:(NSURL*)path{
    
    //需要导入<AVFoundation> 和AVKit
    RoomViewController *vc = [RoomViewController new];
    vc.playURL = path;
    //隐藏tabbar
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:nil];
}
//是否支持旋转
- (BOOL)shouldAutorotate
{
    return NO;
}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //只支持竖屏
    return UIInterfaceOrientationMaskPortrait;
}

@end
