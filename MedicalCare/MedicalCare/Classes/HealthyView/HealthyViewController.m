//
//  HealthyViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "HealthyViewController.h"
#import "ClassView.h"

#import "HealthyModel.h"
#import "HealthyTableViewCell.h"

#define HEALTHY_API_INFO @"http://www.tngou.net/api/info/list?id=%ld&rows=%ld"
#define HEALTHY_API_DETAIL @""

@interface HealthyViewController ()<UITableViewDataSource,UITableViewDelegate,ClassViewDelegate>

@property (nonatomic,strong) UITableView * table;
@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) UISearchBar * searchBar;
@property (nonatomic,strong) UIScrollView * scroll;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger number;

@end

@implementation HealthyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    
    [self creatTabBarButton];
    [self CreatSearchBar];
    [self.view addSubview:self.table];
    [self getDataWithNumber:0 androw:10];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNightModel) name:@"NigthMode" object:nil];
}

- (void)changeNightModel{

    self.view.backgroundColor = [UIColor grayColor];
}

- (void)creatTabBarButton{
 
    ClassView * viewS = [[ClassView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    viewS.delegate = self;
    self.navigationItem.titleView = viewS;
}

- (void)changeCurrentData:(NSInteger)number{
    [self getDataWithNumber:number androw:10];
    self.number = number;
}

-(void)endRefresh{
    [self.table.footer endRefreshing];
}

- (void)getDataWithNumber:(NSInteger)number androw:(NSInteger)count{
    self.dataArr = [[NSMutableArray alloc]init];
    [[NetManager shareManager] requestUrl:[NSString stringWithFormat:@"http://www.tngou.net/api/info/list?id=%ld&rows=%ld",number,count] withSuccessBlock:^(id data) {

        for (NSDictionary * dic in data[@"tngou"]) {
            HealthyModel * model = [[HealthyModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
//        NSLog(@"%@",self.dataArr);
        dispatch_async(dispatch_get_main_queue(), ^{
             [self endRefresh];
            _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 200);
            for (int i = 0; i < 5; ++i) {
                UIImageView * backV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0,SCREEN_WIDTH, 200)];
              
                HealthyModel * model = self.dataArr[i];
                [backV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_API,model.img]]];

                [_scroll addSubview:backV];
            }

            [self.table reloadData];
        });
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (UIImage *)CoreImage:(UIImage *)image{

    CIContext * context = [CIContext contextWithOptions:nil];
    CIImage * imageCI = [CIImage imageWithCGImage:image.CGImage];
    CIFilter * filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:imageCI forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey:@"inputRadius"];
    CIImage * result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage:result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}

- (void)CreatSearchBar{
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _searchBar.placeholder = @"搜索";
    [self.view addSubview:_searchBar];

}

- (UITableView *)table{

    if (_table == nil) {
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
    
        _scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _scroll.pagingEnabled = YES;
        _table.tableHeaderView = _scroll;
    
        
        _table.footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
            [self getDataWithNumber:self.number androw:self.page * 10];
        }];
    }
    return _table;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"cellID";
    HealthyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HealthyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    HealthyModel * model = self.dataArr[indexPath.row];
    [cell configWithModel:model];
    return cell;
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
