//
//  MyCenterViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "MyCenterViewController.h"
#import "ListView.h"
#import "ListTableViewCell.h"
#import "DetailModel.h"

@interface MyCenterViewController ()<UISearchBarDelegate,ListViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

    BOOL isOpen;
    
}

@property (nonatomic,strong)CAAnimationGroup * group ;
@property (nonatomic,strong) UISearchBar * search;

@property (nonatomic,strong) UITableView * table;
@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) ListView * viewV;
@property (nonatomic,strong) UIImageView * imageV;

@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isOpen = NO;
    [self.view addSubview:self.table];
    [self getDefaultData];
    [self CreatButton];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_imageV.layer addAnimation:_group forKey:nil];
}

- (void)getDefaultData{
    self.dataArr = [[NSMutableArray alloc]init];

    [[NetManager shareManager] requestUrl:[NSString stringWithFormat:@"http://www.tngou.net/api/symptom/list"] withSuccessBlock:^(id data) {
        
        for (NSDictionary * dic in data[@"list"]) {
            DetailModel * model = [[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    } andFailedBlock:^(NSError *error) {
        
    }];

}

- (UITableView *)table{

    if (_table == nil) {
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        
        _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
        _search.delegate = self;
        _search.placeholder = @"查询病状信息";
        
        _table.tableHeaderView = _search;
    }
    return _table;
}

- (void)CreatButton{
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _imageV.center = CGPointMake(SCREEN_WIDTH * 3 / 4 + 50, 100);
    _imageV.image = [UIImage imageNamed:@"icon_health"];
    _imageV.tag = 1000;
    
    CABasicAnimation * rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.toValue = @(M_PI);
    rotation.duration = 1;

    //闪烁
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.0];
    
    animation.autoreverses=YES;
    
    animation.duration=1;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    self.group = [CAAnimationGroup animation];
    _group.animations = @[rotation,animation];
    _group.duration = 1;
    _group.repeatCount = MAXFLOAT;
    
    
   //[_imageV.layer addAnimation:_group forKey:nil];
    
    
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithAnimation)];
    _imageV.userInteractionEnabled = YES;
    [_imageV addGestureRecognizer:tap];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panWithAnimation:)];
    [_imageV addGestureRecognizer:pan];
    
    [self.view addSubview:_imageV];
    
}

- (void)panWithAnimation:(UIPanGestureRecognizer *)pan{
    UIImageView * imgeV = [self.view viewWithTag:1000];
    CGPoint point = [pan translationInView:self.view];
    

        imgeV.transform = CGAffineTransformTranslate(imgeV.transform, point.x, point.y);
    
        [pan setTranslation:CGPointZero inView:imgeV];
}

- (void)tapWithAnimation{

    if (isOpen == NO) {
        
        _viewV = [[ListView alloc]initWithFrame:CGRectMake(0 , 64 , SCREEN_WIDTH, SCREEN_HEIGHT)];
        _viewV.delegate = self;
        _viewV.userInteractionEnabled = YES;
        
        [self.view addSubview:_viewV];
        
    }else if (isOpen == YES){
        
        [_viewV removeFromSuperview];
    }
    
    isOpen = !isOpen;
}


#pragma mark ListDelegate
- (void)changeDataWithDetail:(NSInteger)number{

    [self getDataWithList:number];
}

- (void)getDataWithList:(NSInteger)number{
    self.dataArr = [[NSMutableArray alloc]init];

    [[NetManager shareManager] requestUrl:[NSString stringWithFormat:@"http://www.tngou.net/api/symptom/place?id=%ld",number] withSuccessBlock:^(id data) {
        for (NSDictionary * dic in data[@"list"]) {
            DetailModel * model = [[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });

    } andFailedBlock:^(NSError *error) {
        
    } andView:self];
}


- (void)deleListView{

    [_viewV removeFromSuperview];
    isOpen = !isOpen;
}

#pragma mark TableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    DetailModel * model = self.dataArr[indexPath.row];
    [cell configWith:model];
    return cell;
}

#pragma mark Search
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

//    [self getDataWithLocationWithSearch];
    
}

- (void)getDataWithLocationWithSearch{
    self.dataArr = [[NSMutableArray alloc]init];
    NSString * str = [_search.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    [[NetManager shareManager] requestUrl:[NSString stringWithFormat:@"http://www.tngou.net/api/symptom/name?name=%@",str] withSuccessBlock:^(id data) {
        if ([data[@"status"] isEqualToString:@"true"]) {
            for (NSDictionary * dic in data) {
                DetailModel * model = [[DetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.table reloadData];
            });
            
        }else{
            [Alert showAlert:@"未找到" onCtrl:self];
        }
        
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } andView:self];
    
    
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
