//
//  Alert.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/15.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "Alert.h"

@implementation Alert

+ (void)showAlert:(NSString *)msg onCtrl:(UIViewController *)vc{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * ctrl = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        [ctrl addAction:action];
        
        [vc presentViewController:ctrl animated:YES completion:nil];
    });
    
    
    
    
}


@end
