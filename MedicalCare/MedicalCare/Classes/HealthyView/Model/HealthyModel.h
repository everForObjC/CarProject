//
//  HealthyModel.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HealthyModel : JSONModel

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy) NSString * descriptions;
@property (nonatomic,assign) NSInteger fcount;
@property (nonatomic,assign) NSInteger newsId;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * keywords;
@property (nonatomic,assign) NSInteger infoclass;
@property (nonatomic,assign) NSInteger rcount;
@property (nonatomic,assign) NSInteger time;
@property (nonatomic,copy) NSString * title;

@end
