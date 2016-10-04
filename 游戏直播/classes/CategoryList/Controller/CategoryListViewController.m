//
//  CategoryListViewController.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryListViewController.h"
#import "CategoryCell.h"
#import "LiveListViewController.h"

@interface CategoryListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *categorys;
@end

@implementation CategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建CollectionView代码
    UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:fl];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //注册Cell
    [collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
    //请求数据
    [WebUtils requestCategorysWithCallback:^(id obj) {
        self.categorys = obj;
        [self.collectionView reloadData];
    }];
}
#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.categorys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.category = self.categorys[indexPath.row];
    return cell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveListViewController *vc = [LiveListViewController new];
    CategoryModel *c = self.categorys[indexPath.row];
    vc.slug = c.slug;
    [self.navigationController pushViewController:vc animated:YES];
}
//控制显示大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float size = (kScreenW-4*kMargin)/3;
    return CGSizeMake(size, size*1.5);
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


@end
