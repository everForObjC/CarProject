//
//  SearchDrugViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "SearchDrugViewController.h"
#import "MedicalClassView.h"
#import "MedicalClassModel.h"
#import "DataModel.h"
#import "SearchCollectionViewCell.h"

#define MEDICAL_CLASS @"http://www.tngou.net/api/drug/classify"

@interface SearchDrugViewController ()<UISearchBarDelegate,MedicalClassViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
{
    BOOL isPress;
}
@property (nonatomic,strong) UISearchBar * search;
@property (nonatomic,strong) MedicalClassView * ClassView;
@property (nonatomic,strong) NSMutableArray * classArr;
@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) UICollectionView * collect;

@property (nonatomic,strong) UITextField * textFiel;

@end

@implementation SearchDrugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isPress = NO;
    _textFiel.delegate = self;
    [self getHttpDataWith:MEDICAL_CLASS];
    [self getHttpDataWithClass:@"http://www.tngou.net/api/drug/list"];
    [self.view addSubview:self.collect];
    [self CreatRightTabBar];
    [self CreatSearchBar];

}

- (UICollectionView *)collect{
    
    if (_collect == nil) {
        UICollectionViewFlowLayout * flowlay = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemW = SCREEN_WIDTH / 2;
        CGFloat itemH = itemW;
        flowlay.itemSize = CGSizeMake(itemW, itemH);
        flowlay.minimumInteritemSpacing = 0;
        flowlay.minimumLineSpacing = 0;
        
        _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + 40 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40 - 49) collectionViewLayout:flowlay];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.backgroundColor = [UIColor whiteColor];
        [_collect registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"cellColl"];
        
    }
    return _collect;
}

- (void)getHttpDataWith:(NSString *)str{
    self.classArr = [[NSMutableArray alloc]init];
    [[NetManager shareManager] requestUrl:str withSuccessBlock:^(id data) {
        
        for (NSDictionary * dic in data[@"tngou"]) {
            MedicalClassModel * model = [[MedicalClassModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.classArr addObject:model];
                 }
       
     } andFailedBlock:^(NSError *error) {
         NSLog(@"%@",error);
     }];
    
}

- (void)deleteClassView{
//    [_ClassView removeFromSuperview];
//    isPress = !isPress;
    [self pressRightBar];

}

- (void)changeClassView:(NSInteger)ids{
    [self deleteClassView];
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tngou.net/api/drug/list?id=%ld&rows=10",ids];
    NSLog(@"%@",urlStr);
    [self getHttpDataWithClass:urlStr];
}

- (void)getHttpDataWithClass:(NSString *)str{
   [[NetManager shareManager] requestUrl:str withSuccessBlock:^(id data) {
      
       self.dataArr = [[NSMutableArray alloc]init];
       if (data[@"msg"]) {
           [Alert showAlert:@"该类药品还未上架" onCtrl:self];
       }
       else{
       for (NSDictionary * dic in data[@"tngou"]) {
           DataModel * model = [[DataModel alloc]init];
           [model setValuesForKeysWithDictionary:dic];
           [self.dataArr addObject:model];
       }
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.collect reloadData];
       }) ;
       }
   } andFailedBlock:^(NSError *error) {
       NSLog(@"%@",error);
   }];
    
}

- (void)CreatClassView{
    
    _ClassView = [[MedicalClassView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) andDataArr:self.classArr];
    _ClassView.delegate = self;
    [self.view addSubview:_ClassView];

}

- (void)CreatRightTabBar{
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"indent_general_icon"] style:UIBarButtonItemStyleDone target:self action:@selector(pressRightBar)];
    rightBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)pressRightBar{
    if (isPress == NO) {
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor yellowColor];
        [self CreatClassView];
        
    }else{
     self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
        [_ClassView removeFromSuperview];
    }
    isPress = !isPress;
}

- (void)CreatSearchBar{
    _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _search.delegate = self;
    _search.placeholder = @"药品查询";
    
    [self.view addSubview:_search];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellColl" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    DataModel * model = self.dataArr[indexPath.row];
    [cell configWith:model];
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%@",searchText);
    NSString * str = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tngou.net/api/search?name=drug&keyword=%@&type=name,message",str];
    [self getHttpDataWithSearch:urlStr];
}

- (void)getHttpDataWithSearch:(NSString *)urlStr{
    [self.collect removeFromSuperview];
    [[NetManager shareManager] requestUrl:urlStr withSuccessBlock:^(id data) {
        
        self.dataArr = [[NSMutableArray alloc]init];
        if ([data[@"tngou"] count] == 0) {
            [Alert showAlert:@"未找到该类药品" onCtrl:self];
        }
        else{
            for (NSDictionary * dic in data[@"tngou"]) {
                DataModel * model = [[DataModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collect reloadData];
            }) ;
        }
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_search resignFirstResponder];
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
