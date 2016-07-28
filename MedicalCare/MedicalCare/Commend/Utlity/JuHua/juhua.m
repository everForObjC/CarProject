//
//  juhua.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "juhua.h"

@interface juhua ()

@property (nonatomic,strong) UIView * viewB;
@property (nonatomic,strong) UIView * blackB;
@property (nonatomic,strong) UIActivityIndicatorView * act;

@end


@implementation juhua

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.viewB = [[UIView alloc]initWithFrame:self.window.bounds];
        self.viewB.hidden = 1.;
        [self addSubview:self.viewB];
        
        self.blackB = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 70, SCREEN_HEIGHT / 2 - 40, 140, 80)];
        self.blackB.backgroundColor = [UIColor blackColor];
        self.blackB.layer.cornerRadius = 10;
        self.blackB.layer.masksToBounds = YES;
        [self addSubview:self.blackB];
        
        self.act = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(50, 20, 40, 40)];
        [self.act startAnimating];
        self.act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [self.blackB addSubview:self.act];
        
        
    }
    return self;
}



@end
