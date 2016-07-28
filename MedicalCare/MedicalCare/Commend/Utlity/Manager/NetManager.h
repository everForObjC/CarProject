//
//  NetManager.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/9.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <UIKit/UIKit.h>

typedef void (^SuccessBlock) (id data);
typedef void (^FailedBlock) (NSError * error);

@interface NetManager : NSObject

+ (instancetype)shareManager;

- (void)requestUrl:(NSString *)url withSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB;

- (void)requestUrl:(NSString *)url withSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andView:(UIViewController *)vc;

@end
