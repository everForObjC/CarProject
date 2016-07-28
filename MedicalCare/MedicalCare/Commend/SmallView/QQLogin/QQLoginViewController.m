//
//  QQLoginViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/11.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "QQLoginViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "MySetUp.h"

@interface QQLoginViewController ()<TencentSessionDelegate>
{
    TencentOAuth *tencentOAuth;
}
@end

@implementation QQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self toLogin];
}

- (void)toLogin
{
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"1105260675" andDelegate:self];
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"get_simple_userinfo", @"add_t", nil];
    [tencentOAuth authorize:permissions inSafari:YES];
}
#pragma TencentSessionDelegate
- (void)tencentDidLogin
{
    [tencentOAuth getUserInfo];
}

- (void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"%@",response);
    ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:response.jsonResponse[@"figureurl_qq_2"]]]];
        NSString * name = [NSString stringWithFormat:@"%@",response.jsonResponse[@"nickname"]];
        
        if (self.myImage) {
            self.myImage(img,name);
        }
    });
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
