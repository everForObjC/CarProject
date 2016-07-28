//
//  CustomTabBar.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blcok)(UIImage *,NSString *);

@interface CustomTabBar : UIViewController

@property (nonatomic,strong) blcok myImage;

@end
