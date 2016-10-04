//
//  LoopView.m
//  轮播图
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//
#import "RoomModel.h"
#import "LoopView.h"
@implementation LoopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
   
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.cv = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:fl];
        
        self.cv.delegate = self;
        self.cv.dataSource = self;
        [self addSubview:self.cv];
        
        [self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.cv.pagingEnabled = YES;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
      
        
        UIView *bgView= [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = .3;
        [self addSubview:bgView];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.bounds.size.width-120, bgView.frame.origin.y, 120, 20)];
        self.pageControl.userInteractionEnabled = NO;
        [self addSubview:self.pageControl];
    
    }
    return self;
}

-(void)moveAction{
    
    //NSLog(@"=======");
    NSIndexPath *currentIndex = [[self.cv indexPathsForSelectedItems]lastObject];
    
    NSInteger row = currentIndex.row + 1;
    NSInteger section = currentIndex.section;
    if (row==self.rooms.count) {
        row = 0;
        section+=1;
    }
    
    [self.cv selectItemAtIndexPath: [NSIndexPath indexPathForRow:row inSection:section] animated:YES scrollPosition:UICollectionViewScrollPositionRight];
    
    
    
}



-(void)setRooms:(NSArray *)rooms{
    _rooms = rooms;
    
    //让cv开始时显示到中间的位置
    [self.cv selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:5000] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
  
    self.pageControl.numberOfPages = rooms.count;
    
}


#pragma mark UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10000;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.rooms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *iv = [cell viewWithTag:1];
    if (!iv) {
        iv = [[UIImageView alloc]initWithFrame:cell.bounds];
        [cell addSubview:iv];
        iv.tag = 1;
    }
    UILabel *titleLaebl = [cell viewWithTag:2];
    if (!titleLaebl) {
        titleLaebl = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.height-20, self.bounds.size.width-120, 20)];
        titleLaebl.tag = 2;
        titleLaebl.font = [UIFont systemFontOfSize:14];
        titleLaebl.textColor = [UIColor whiteColor];
        [cell addSubview:titleLaebl];
    }
    
    RoomModel *room = self.rooms[indexPath.row];
    
    titleLaebl.text =room.title;
    
    [iv sd_setImageWithURL:room.thumb placeholderImage:LoadingImage];
    
    
    return cell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RoomModel *room = self.rooms[indexPath.row];
    [self.delegate didTapItemWithRoomPath:room.playURL];
    
    
}
//控制显示大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    return self.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0,0,0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    //NSLog(@"停止timer");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
    //NSLog(@"重启timer");
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    当滚动停止的时候
    //取到当前显示的cell
    UICollectionViewCell *cell = [self.cv.visibleCells lastObject];
//    获取cell的位置
    NSIndexPath *index = [self.cv indexPathForCell:cell];
//    选中到 获取的位置
    [self.cv selectItemAtIndexPath:index animated:NO scrollPosition:UICollectionViewScrollPositionRight];
//    0 1 2 3 4 5 6 7
//    0 1 2 3 4 0 1 2
    
    self.pageControl.currentPage = index.row;
    
    
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSLog(@"%@",self.cv.visibleCells);
    //取到当前显示的cell
    NSIndexPath *index = [[self.cv indexPathsForSelectedItems]lastObject];
   

     self.pageControl.currentPage = index.row;
    
}

@end
