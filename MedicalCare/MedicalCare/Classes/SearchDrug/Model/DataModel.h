//
//  DataModel.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/15.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy,setter=setDescription:) NSString * descriptions;
@property (nonatomic,assign) NSInteger fcount;
@property (nonatomic,assign,setter=setId:) NSInteger ids;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * keywords;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,assign) NSInteger price;
@property (nonatomic,assign) NSInteger rcount;
@property (nonatomic,copy) NSString * tag;
@property (nonatomic,copy) NSString * type;

@end
