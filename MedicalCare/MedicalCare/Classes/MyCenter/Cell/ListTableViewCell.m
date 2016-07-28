//
//  ListTableViewCell.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "ListTableViewCell.h"


#define IMAGE_WIDTH 80
#define IMAGE_HEIGHT 80

@interface ListTableViewCell ()

@property (nonatomic,strong) UILabel * titelL;
@property (nonatomic,strong) UIImageView * imageV;
@property (nonatomic,strong) UILabel * desL;

@property (nonatomic,strong) UILabel * keyL;

@end

@implementation ListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, IMAGE_WIDTH, IMAGE_HEIGHT)];
        [self.contentView addSubview:self.imageV];
        
        self.titelL = [[UILabel alloc]initWithFrame:CGRectMake(IMAGE_WIDTH + 10, 5, SCREEN_WIDTH - IMAGE_WIDTH - 10, 20)];
        self.titelL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titelL];
        
        self.keyL = [[UILabel alloc]initWithFrame:CGRectMake(IMAGE_WIDTH + 10, 25, SCREEN_WIDTH - IMAGE_WIDTH - 10, 20)];
        self.keyL.font = [UIFont systemFontOfSize:12];
        self.keyL.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.keyL];
        
        self.desL = [[UILabel alloc]initWithFrame:CGRectMake(IMAGE_WIDTH + 10, 45, SCREEN_WIDTH - IMAGE_WIDTH - 10, 40)];
        self.desL.font = [UIFont systemFontOfSize:15];
        self.desL.numberOfLines = 0;
        [self.contentView addSubview:self.desL];
        
    }
    return self;
}

- (void)configWith:(DetailModel *)model{
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_API,model.img]] placeholderImage:[UIImage imageNamed:@""]];
    
    self.titelL.text = model.name;
    
    self.keyL.text = [NSString stringWithFormat:@"关键字: %@",model.keywords];
    
    self.desL.text = model.descriptions;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
