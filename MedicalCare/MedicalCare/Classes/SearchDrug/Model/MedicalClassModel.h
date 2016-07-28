//
//  MedicalClassModel.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/15.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicalClassModel : NSObject

@property (nonatomic,copy,setter=setDescription:) NSString * descriptions;
@property (nonatomic,copy) NSString * drugclass;
@property (nonatomic,copy,setter=setId:) NSString * ids;
@property (nonatomic,copy) NSString * keywords;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * seq;
@property (nonatomic,copy) NSString * title;

@end
