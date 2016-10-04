//
//  TRCategoryCell.m
//  GameLive
//
//  Created by tarena on 16/8/1.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-30, self.bounds.size.width, 30)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLb];
    
       
    }
    return _titleLb;
}

- (UIImageView *)iconIV {
    if(_iconIV == nil) {
        _iconIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-30)];
        
        [self.contentView addSubview:_iconIV];
    
    }
    return _iconIV;
}


-(void)setCategory:(CategoryModel *)category{
    _category = category;
    
    self.titleLb.text = category.name;
    
    [self.iconIV sd_setImageWithURL:category.thumb placeholderImage:LoadingImage];
    
    
}
@end
