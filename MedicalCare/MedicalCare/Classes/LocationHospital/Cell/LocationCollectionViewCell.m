//
//  LocationCollectionViewCell.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/16.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "LocationCollectionViewCell.h"

@interface LocationCollectionViewCell ()

@property (nonatomic,strong) UIImageView * backV;
@property (nonatomic,strong) UILabel * nameL;
@property (nonatomic,strong) UILabel * addL;
@property (nonatomic,strong) UILabel * telL;
@property (nonatomic,strong) UILabel * business;

@end

@implementation LocationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 180)];
        self.backV.layer.cornerRadius = 10;
        self.backV.layer.masksToBounds = YES;
        [self.contentView addSubview:self.backV];
        
        UILabel * nameBack = [[UILabel alloc]initWithFrame:CGRectMake(40, 18, SCREEN_WIDTH - 50, 40)];
        nameBack.backgroundColor = [UIColor lightGrayColor];
        nameBack.alpha = 0.6;
        [self.contentView addSubview:nameBack];
        
        self.nameL = [[UILabel alloc]initWithFrame:CGRectMake(70, 18, SCREEN_WIDTH - 70 - 10, 40)];
        self.nameL.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameL];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 60)];
        [btn setImage:[UIImage imageNamed:@"homepage_message_gcxx"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        NSArray * arr = @[@"homepage_me_state4",@"homepage_me_state3",@"homepage_me_state2"];
        
        for (int i = 0; i < 3; ++i) {
            UIImageView * imageV = [[UIImageView alloc]init];
            if (i == 0) {
            imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, i * (20 + 10) + 80, 120, 20)];
            }else if (i == 1 ){
             imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, i * (20 + 10) + 80,250, 20)];
            }else{
             imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, i * (20 + 10) + 80, 300, 20)];

            }
            imageV.alpha = 0.6;
            imageV.image = [UIImage imageNamed:arr[i]];
            [self.contentView addSubview:imageV];
        }
        
        self.telL = [[UILabel alloc]initWithFrame:CGRectMake(10, 0 * (20 + 10) + 80, 120, 20)];
        self.telL.textColor = [UIColor whiteColor];
//        self.telL.hidden = YES;
        [self.contentView addSubview:self.telL];
        
        self.addL = [[UILabel alloc]initWithFrame:CGRectMake(10, 1 * (20 + 10) + 80, 250, 20)];
        self.addL.textColor = [UIColor whiteColor];
//        self.addL.hidden = YES;
        [self.contentView addSubview:self.addL];
        
        self.business = [[UILabel alloc]initWithFrame:CGRectMake(10, 2 * (20 + 10) + 80, 300, 20)];
//        self.business.hidden = YES;
        self.business.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.business];
        
    }

    return self;
}

- (void)pressBtn{
    
//    self.telL.hidden = NO;
//    self.addL.hidden = NO;
//    self.business.hidden = NO;
    
}

- (void)configWithModel:(LocationModel *)model{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",IMAGE_API,model.img];

    [self.backV sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    self.nameL.text = model.name;
    
    self.telL.text = model.tel;
    
    self.addL.text = model.address;
    
    self.business.text = model.business;
}

@end
