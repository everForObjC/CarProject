//
//  QQLoginViewController.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blcok)(UIImage *,NSString *);

@interface QQLoginViewController : SmallViewController

@property (nonatomic,strong) blcok myImage;

@end
