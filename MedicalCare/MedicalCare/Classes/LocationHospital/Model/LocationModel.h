//
//  LocationModel.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/16.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic,copy) NSString * address;
@property (nonatomic,assign) NSInteger area;
@property (nonatomic,copy) NSString * business;
@property (nonatomic,copy) NSString * charge;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger createdate;
@property (nonatomic,assign,setter=setId:) NSInteger ids;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * number;
@property (nonatomic,copy) NSString * tel;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * waddress;


@end
