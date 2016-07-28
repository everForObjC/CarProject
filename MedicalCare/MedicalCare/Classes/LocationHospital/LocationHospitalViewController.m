//
//  LocationHospitalViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/8.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "LocationHospitalViewController.h"
#import <MapKit/MapKit.h>
#import "LocationModel.h"
#import "LocationCollectionViewCell.h"

@interface LocationHospitalViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    BOOL isPress;
}
@property (nonatomic,strong) CLGeocoder * geoCoder;
@property (nonatomic,strong) UISearchBar * search;
@property (nonatomic,strong) NSMutableArray * dataArr;

@property (nonatomic,strong) UICollectionView * collect;

@property (nonatomic,strong) CLPlacemark * mark;

@end

@implementation LocationHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isPress = NO;
    [self CreatRightTabBar];
    [self.view addSubview:self.collect];
    [self getDataWithStr:@"http://www.tngou.net/api/store/location?x=116.405&y=39.90"];
    [self CreatSearchBar];
}

- (void)CreatSearchBar{
    _search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _search.delegate = self;
    _search.placeholder = @"输入地址";
    
    [self.view addSubview:_search];
}

- (UICollectionView *)collect{
    
    if (_collect == nil) {
        UICollectionViewFlowLayout * flowlay = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemW = SCREEN_WIDTH ;
        CGFloat itemH = 200;
        flowlay.itemSize = CGSizeMake(itemW, itemH);
        flowlay.minimumInteritemSpacing = 0;
        flowlay.minimumLineSpacing = 0;
        
        _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64 + 40 , SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40 - 49) collectionViewLayout:flowlay];
        _collect.delegate = self;
        _collect.dataSource = self;
        _collect.backgroundColor = [UIColor whiteColor];
        [_collect registerClass:[LocationCollectionViewCell class] forCellWithReuseIdentifier:@"cellColl"];
        
    }
    return _collect;
}

#pragma mark -- 地理编码
- (void)getLocation{
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    
    self.geoCoder = [[CLGeocoder alloc] init] ;
    //地理编码
    [self.geoCoder geocodeAddressString:self.search.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        _mark = [placemarks lastObject] ;
        
        label.text = [NSString stringWithFormat:@"%f---%f",_mark.location.coordinate.latitude,_mark.location.coordinate.longitude] ;
        
        NSLog(@"%@",label.text);
      
    }] ;
   
}


- (void)CreatRightTabBar{
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"dizhi"] style:UIBarButtonItemStyleDone target:self action:@selector(pressRightBar)];
    rightBar.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBar;
}
#pragma mark 定位
- (void)pressRightBar{
    if (isPress == NO) {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor yellowColor];
        [Alert showAlert:@"正在定位您的位置" onCtrl:self];
        MapPosition * map = [[MapPosition alloc]init];
        CLLocationCoordinate2D c2d = [map getLocation];
        [self getDataWithLocation:c2d];
    }else{
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
  
    }
    isPress = !isPress;
}

#pragma mark 获取数据
- (void)getDataWithLocation:(CLLocationCoordinate2D)c2d{
    self.dataArr = [[NSMutableArray alloc]init];
    
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tngou.net/api/store/location?x=%ld&y=%ld",(NSInteger)c2d.latitude,(NSInteger)c2d.longitude];
    [[NetManager shareManager] requestUrl:urlStr withSuccessBlock:^(id data) {
        for (NSDictionary * dic in data[@"tngou"]) {
            LocationModel * model = [[LocationModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collect reloadData];
        });
        
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)getDataWithStr:(NSString *)urlStr{

    self.dataArr = [[NSMutableArray alloc]init];
    [[NetManager shareManager] requestUrl:urlStr withSuccessBlock:^(id data) {
        for (NSDictionary * dic in data[@"tngou"]) {
            LocationModel * model = [[LocationModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collect reloadData];
        });
        
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];


}
#pragma mark collection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LocationCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellColl" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    LocationModel * model = self.dataArr[indexPath.row];
    [cell configWithModel:model];
    return cell;
}

#pragma mark search
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

//    [self getLocation];
//    [self getDataWithLocationWithSearch];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [self getLocation];
    [self getDataWithLocationWithSearch];

}

- (void)getDataWithLocationWithSearch{
    self.dataArr = [[NSMutableArray alloc]init];
    NSString * urlStr = [NSString stringWithFormat:@"http://www.tngou.net/api/store/location?x=%f&y=%f",_mark.location.coordinate.latitude,_mark.location.coordinate.longitude];
    [[NetManager shareManager] requestUrl:urlStr withSuccessBlock:^(id data) {
        for (NSDictionary * dic in data[@"tngou"]) {
            LocationModel * model = [[LocationModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collect reloadData];
        });
        
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_search endEditing:YES] ;
//    [_search resignFirstResponder];
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
