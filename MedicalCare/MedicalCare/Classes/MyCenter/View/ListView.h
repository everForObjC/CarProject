//
//  ListView.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ListViewDelegate <NSObject>

- (void)changeDataWithDetail:(NSInteger)number;
- (void)deleListView;

@end

@interface ListView : UIView

@property (nonatomic,weak) id<ListViewDelegate> delegate;

@end
