//
//  NetManager.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/9.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "NetManager.h"
#import "juhua.h"

@interface NetManager ()

@property (nonatomic,strong) AFHTTPSessionManager * sessionManager;

@end

@implementation NetManager

+ (instancetype)shareManager{

    static NetManager * netManager = nil;
    if (netManager == nil) {
        netManager = [[NetManager alloc]init];
        netManager.sessionManager = [AFHTTPSessionManager manager];
        netManager.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        netManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return netManager;
}

- (void)requestUrl:(NSString *)url withSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB andView:(UIViewController *)vc{
    
    juhua * ju = [[juhua alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    [vc.view addSubview:ju];
    
    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successB([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
        [ju removeFromSuperview];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failB(error);
        [ju removeFromSuperview];
    }];

}

- (void)requestUrl:(NSString *)url withSuccessBlock:(SuccessBlock)successB andFailedBlock:(FailedBlock)failB {

    [self.sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successB([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil]);
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failB(error);
      
    }];

}
@end
