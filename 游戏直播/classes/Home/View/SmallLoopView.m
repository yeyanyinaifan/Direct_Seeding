//
//  LoopView.m
//  轮播图
//
//  Created by tarena on 16/9/9.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "SmallLoopView.h"
@implementation SmallLoopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
   
        fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.cv = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:fl];
        self.cv.backgroundColor = [UIColor whiteColor];
        self.cv.delegate = self;
        self.cv.dataSource = self;
        [self addSubview:self.cv];
        
        [self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
       
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
      
        
       
        
          
    }
    return self;
}

-(void)moveAction{
    
    
    CGPoint offset = self.cv.contentOffset;
    offset.x+=1;
    
    self.cv.contentOffset = offset;
    
    
    
}



-(void)setRooms:(NSArray *)rooms{
    _rooms = rooms;
    //让cv开始时显示到中间的位置
    [self.cv selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:5000] animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
  
 
    
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
        iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 8, cell.bounds.size.width - 8, cell.bounds.size.width - 8)];
        [cell addSubview:iv];
        iv.layer.cornerRadius = (cell.bounds.size.width - 8)/2;
        iv.layer.masksToBounds = YES;
        iv.tag = 1;
    }
    UILabel *titleLaebl = [cell viewWithTag:2];
    if (!titleLaebl) {
        titleLaebl = [[UILabel alloc]initWithFrame:CGRectMake(0,cell.bounds.size.width, cell.bounds.size.width, 20)];
        titleLaebl.tag = 2;
        titleLaebl.font = [UIFont systemFontOfSize:14];
        titleLaebl.textColor = [UIColor blackColor];
        titleLaebl.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:titleLaebl];
    }
    
    RoomModel *room = self.rooms[indexPath.row];
    
    
    titleLaebl.text = room.nick;
    
    
    
    [iv sd_setImageWithURL:room.avatar placeholderImage:LoadingImage];
    
    return cell;
    
    
}

//控制显示大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    return CGSizeMake(80, self.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,10,0,0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    NSLog(@"停止timer");
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
      NSLog(@"重启timer");
}





@end
