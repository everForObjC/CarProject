//
//  HealthyModel.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "HealthyModel.h"

@implementation HealthyModel

+(JSONKeyMapper *)keyMapper
{
    JSONKeyMapper *mapper = [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"newsId",@"description":@"descriptions"}];
    return mapper;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

@end
