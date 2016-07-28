//
//  ListTableViewCell.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface ListTableViewCell : UITableViewCell

- (void)configWith:(DetailModel *)model;

@end
