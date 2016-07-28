//
//  MedicalClassView.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/14.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MedicalClassViewDelegate <NSObject>
//删除视图
- (void)deleteClassView;
//传入数值
- (void)changeClassView:(NSInteger)ids;


@end

@interface MedicalClassView : UIView

@property (nonatomic,strong) NSArray * classArr;

- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArr;

@property (nonatomic,weak) id<MedicalClassViewDelegate>delegate;

@end
