//
//  ListView.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/17.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "ListView.h"

#import "ListModel.h"
#import "DeatilModel.h"

@interface ListView ()<UITableViewDataSource,UITableViewDelegate>

{

    BOOL isOpen;
}

@property (nonatomic,strong) UITableView * table;
@property (nonatomic,strong) UITableView * tableD;

@property (nonatomic,strong) NSMutableArray * listArr;
@property (nonatomic,strong) NSMutableArray * listDetail;

@property (nonatomic,strong) UIView * backV;

@end

@implementation ListView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        isOpen = NO;
        
//        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//        imageV.center = CGPointMake(SCREEN_WIDTH * 3 / 4 + 50, 100);
//        imageV.image = [UIImage imageNamed:@"icon_health"];
//
//        
//        CABasicAnimation * rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        rotation.toValue = @(M_PI);
//        rotation.duration = 1;
////
////        CABasicAnimation * scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
////        scale.toValue = @(1.2);
////
//        
////        [UIView animateWithDuration:0.5 animations:^{
////        imageV.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
////                
////            }];
//        //闪烁
//        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
//        
//        animation.fromValue=[NSNumber numberWithFloat:1.0];
//        
//        animation.toValue=[NSNumber numberWithFloat:0.0];
//        
//        animation.autoreverses=YES;
//        
//        animation.duration=1;
//        
//        animation.repeatCount=FLT_MAX;
//        
//        animation.removedOnCompletion=NO;
//        
//        animation.fillMode=kCAFillModeForwards;
//        
//        CAAnimationGroup * group = [CAAnimationGroup animation];
//        group.animations = @[rotation,animation];
//        group.duration = 1;
//        group.repeatCount = MAXFLOAT;
//        
//        
//        [imageV.layer addAnimation:group forKey:nil];
//       
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithAnimation)];
//        imageV.userInteractionEnabled = YES;
//        [imageV addGestureRecognizer:tap];
//        
//        [self addSubview:imageV];
        _backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
        _backV.backgroundColor = [UIColor lightGrayColor];
        _backV.alpha = 0.7;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithAnimation)];
        _backV.userInteractionEnabled = YES;
        [_backV addGestureRecognizer:tap];
        [self addSubview:_backV];
        
        [self addSubview:self.table];
        [self addSubview:self.tableD];
        
        [self getListData];
        
    }
    return self;
}

- (void)tapWithAnimation{

    if (_delegate != nil && [_delegate respondsToSelector:@selector(deleListView)]) {
        [_delegate deleListView];
    }

}

- (void)getListData{
    self.listArr = [[NSMutableArray alloc]init];
    [[NetManager shareManager] requestUrl:@"http://www.tngou.net/api/place/all" withSuccessBlock:^(id data) {
        
        for (NSDictionary * dic in data[@"tngou"]) {
            ListModel * model = [[ListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.listArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    } andFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)CreatListTableView{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 1/4, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 40)];
    label.text = @"身体部位";
    _table.tableHeaderView = label;
    [self addSubview:_table];
}

- (UITableView *)table{

    if (_table == nil) {
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 1/4, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 4, 40)];
        label.text = @"身体部位";
        _table.tableHeaderView = label;
        
    }
    return _table;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _table) {
        return self.listArr.count;

    }else if (tableView == _tableD){
    
        return self.listDetail.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (tableView == _table) {
        ListModel * model = self.listArr[indexPath.row];
        cell.textLabel.text = model.name;
        
    }else if (tableView == _tableD){
        
        DeatilModel * model = self.listDetail[indexPath.row];
        cell.textLabel.text = model.name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _table) {
        self.listDetail = [[NSMutableArray alloc]init];
        ListModel * model = self.listArr[indexPath.row];
        for (NSDictionary * dic in model.places) {
            DeatilModel * modelS = [[DeatilModel alloc]init];
            [modelS setValuesForKeysWithDictionary:dic];
            [self.listDetail addObject:modelS];
        }
        self.tableD.frame = CGRectMake(SCREEN_WIDTH * 1/4 , 0, SCREEN_WIDTH * 1/4, 40 * self.listDetail.count);
        [self.tableD reloadData];
        
    }else if (tableView == _tableD){
        
        DeatilModel * model = self.listDetail[indexPath.row];
        
        if (_delegate != nil && [_delegate respondsToSelector:@selector(changeDataWithDetail:)]) {
            [_delegate changeDataWithDetail:model.ids];
        }
        if (_delegate != nil && [_delegate respondsToSelector:@selector(deleListView)]) {
            [_delegate deleListView];
        }

    }

}

- (void)CreatListDetailTableView{
   
    
}

- (UITableView *)tableD{
    if (_tableD == nil) {
        _tableD = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 1/4 , 0, SCREEN_WIDTH * 1/4, 40 * self.listDetail.count) style:UITableViewStyleGrouped];
        _tableD.delegate = self;
        _tableD.dataSource = self;
        [self addSubview:_tableD];

    }
       return _tableD;
}

- (void)deleteListTableView{
    
    
}

@end
