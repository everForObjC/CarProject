//
//  LocationCollectionViewCell.h
//  MedicalCare
//
//  Created by qianfeng on 16/7/16.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface LocationCollectionViewCell : UICollectionViewCell

- (void)configWithModel:(LocationModel *)model;

@end
