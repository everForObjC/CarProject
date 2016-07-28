//
//  AdRootViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "AdRootViewController.h"
#import "AdViewController.h"

#import "CustomTabBar.h"

@interface AdRootViewController ()

@end

@implementation AdRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self creatAdImageView];
}

- (void)creatAdImageView{
    UIImageView * adImageV = [[UIImageView alloc]initWithFrame:self.view.frame];
    adImageV.image = [UIImage imageNamed:@"guide_1_480.png"];
    adImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithAdImage)];
    [adImageV addGestureRecognizer:tap];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(300, 40, 50, 30)];
    label.text = @"广告";
    label.alpha = 0.5;
    label.backgroundColor = [UIColor grayColor];
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    [adImageV addSubview:label];
    
    [self.view addSubview:adImageV];
}

- (void)tapWithAdImage{
    
//    AdViewController * vc = [[AdViewController alloc]init];
    CustomTabBar * vc = [[CustomTabBar alloc]init];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
