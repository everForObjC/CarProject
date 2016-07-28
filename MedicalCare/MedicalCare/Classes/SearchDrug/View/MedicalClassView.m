//
//  MedicalClassView.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/14.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "MedicalClassView.h"
#import "MedicalClassModel.h"

#define BUTTON_WIDTH (SCREEN_WIDTH / 4 - 20)
#define BUTTON_HEIGHT BUTTON_WIDTH / 3

#define BUTTON_TAG 100

@interface MedicalClassView ()

@property (nonatomic,strong) NSArray * modelArr;

@end

@implementation MedicalClassView

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArr{

    if (self = [super initWithFrame:frame]) {
        self.modelArr = dataArr;
        UIView * backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
        backV.backgroundColor = [UIColor lightGrayColor];
        backV.alpha = 0.8;
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithBack)];
        [backV addGestureRecognizer:tap];
        [self addSubview:backV];
        
        UIView * btnBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        btnBack.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < dataArr.count; ++i){
            NSInteger hang = i/4;
            NSInteger lie = i%4;
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10 +lie * (10 + BUTTON_WIDTH), 10 + hang * (10 + BUTTON_HEIGHT), BUTTON_WIDTH , BUTTON_WIDTH / 3)];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor yellowColor].CGColor;
            btn.layer.cornerRadius = 10;
            btn.layer.masksToBounds = YES;
            MedicalClassModel * model = dataArr[i];
//            btn.titleLabel.text = model.title;
            [btn setTitle:model.title forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
            btn.tag = BUTTON_TAG + i;
            [btnBack addSubview:btn];
        }
        [self addSubview:btnBack];

    }
    return self;
}

- (void)tapWithBack{

    if (_delegate != nil && [_delegate respondsToSelector:@selector(deleteClassView)]) {
        [_delegate deleteClassView];
    }
}

- (void)pressBtn:(UIButton *)btn{
    NSInteger num = btn.tag - BUTTON_TAG;
    MedicalClassModel * model = self.modelArr[num];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(changeClassView:)]) {
        [_delegate changeClassView:[model.ids integerValue]];
    }
    
}

@end
