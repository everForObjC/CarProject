//
//  SmallView.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "SmallView.h"
#import "BaseTableViewController.h"

#define BUTTON_WIDTH 40 
#define BUTTON_FREE 20
#define BUTTON_TAG 100

#define SMALLVIEW_WIDTH 200
#define SMALLVIEW_HEIDTH 150

@implementation SmallView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self creatSmallView];
    }
    return self;
}

- (void)creatSmallView{

    UIView * backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithBack)];
    [backV addGestureRecognizer:tap];
    [self addSubview:backV];
    
    NSArray * image = @[@"camera",@"icon_timeline",@"icon_session"];
    NSArray * title = @[@"扫一扫",@"分享",@"第三方登录"];
    UIView * smallV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SMALLVIEW_WIDTH, SMALLVIEW_HEIDTH)];
    smallV.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 + 230);
    smallV.backgroundColor = [UIColor blackColor];
    smallV.alpha = 0.8;
    smallV.userInteractionEnabled = YES;
    smallV.layer.cornerRadius = 10.;
    smallV.layer.masksToBounds = YES;
    [backV addSubview:smallV];
    
    for (int i = 0; i < 3; ++i) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(100 + (BUTTON_FREE + BUTTON_WIDTH)*i + BUTTON_FREE, 550, BUTTON_WIDTH, BUTTON_WIDTH)];
        [btn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:image[i]] forState:UIControlStateNormal];
        btn.tag = BUTTON_TAG + i;
        [self addSubview:btn];
    }


}

- (void)pressButton:(UIButton *)btn{

    NSString * number = [NSString stringWithFormat:@"%ld",btn.tag - BUTTON_TAG];
//    NSDictionary * dic = @{@"number":number};
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNewView" object:nil userInfo:dic];
    if (_delegate != nil && [_delegate respondsToSelector:@selector(pushNumberView:)]) {
        [_delegate pushNumberView:[number integerValue]];
    }
    
    [self removeFromSuperview];
}

- (void)tapWithBack{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(deledateSmallView)]) {
        [_delegate respondsToSelector:@selector(deledateSmallView)];
    }
    
}

@end
