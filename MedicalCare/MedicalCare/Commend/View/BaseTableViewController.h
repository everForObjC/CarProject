//
//  BaseTableViewController.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/9.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

- (void)initWithData:(NSArray *)dataArr andCellModel:(NSString *)modelStr andCell:(NSString *)cellID;

@end
