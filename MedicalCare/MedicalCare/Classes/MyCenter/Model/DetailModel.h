//
//  DetailModel.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (nonatomic,copy) NSString * causetext;
@property (nonatomic,copy) NSString * checks;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,copy,setter=setDescription:) NSString * descriptions;
@property (nonatomic,copy) NSString * detailtext;
@property (nonatomic,copy) NSString * disease;
@property (nonatomic,copy) NSString * drug;
@property (nonatomic,assign,setter=setId:) NSInteger ids;
@property (nonatomic,copy) NSString * img;
@property (nonatomic,copy) NSString * keywords;
@property (nonatomic,copy) NSString * message;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * place;


@end
