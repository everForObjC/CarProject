//
//  DeatilModel.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeatilModel : NSObject

@property (nonatomic,copy,setter=setDescription:) NSString * descriptions;
@property (nonatomic,assign,setter=setId:) NSInteger ids;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * keywords;

@end
