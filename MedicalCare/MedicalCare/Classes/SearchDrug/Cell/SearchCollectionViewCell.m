//
//  SearchCollectionViewCell.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/15.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "SearchCollectionViewCell.h"
#define CELL_WIDTH SCREEN_WIDTH/2
#define CELL_HEIGHT CELL_WIDTH*1.5
#define FREE_WIDTH 20
#define FREE_HEIGHT 20

@interface SearchCollectionViewCell ()

@property (nonatomic,strong) UIImageView * imageV;
@property (nonatomic,strong) UILabel * titleL;
@property (nonatomic,strong) UILabel * subTitle;

@end
@implementation SearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CELL_WIDTH-40, CELL_WIDTH-40)];
        [self.contentView addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(FREE_WIDTH, CELL_WIDTH-40, CELL_WIDTH - 2*FREE_WIDTH, 20)];
        self.titleL.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.titleL];
        
        self.subTitle = [[UILabel alloc]initWithFrame:CGRectMake(FREE_WIDTH,  CELL_WIDTH - 20, CELL_WIDTH - 2*FREE_WIDTH, 20)];
        self.subTitle.textAlignment = NSTextAlignmentCenter;
        self.subTitle.textColor = [UIColor lightGrayColor];
        self.subTitle.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.subTitle];
    }
    return self;
}

- (void)configWith:(DataModel *)model{
    
    NSString * imageUrl = [NSString stringWithFormat:@"%@%@",IMAGE_API,model.img];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    self.titleL.text = model.name;
    self.subTitle.text = model.tag;
}



@end
