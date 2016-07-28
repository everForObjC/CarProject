//
//  Alert.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/15.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Alert : NSObject

+ (void)showAlert:(NSString *)msg onCtrl:(UIViewController *)vc;

@end
