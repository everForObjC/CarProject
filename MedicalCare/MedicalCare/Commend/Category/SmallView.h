//
//  SmallView.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SmallViewDelegate <NSObject>

- (void)pushNumberView:(NSInteger)number;
- (void)deledateSmallView;

@end

@interface SmallView : UIView


@property (nonatomic,strong) id<SmallViewDelegate>delegate;

@end
