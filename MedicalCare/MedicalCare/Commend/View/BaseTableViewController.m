//
//  BaseTableViewController.m
//  MedicalCare
//
//  Created by qianfeng on 16/7/9.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "BaseTableViewController.h"

#define TABLE_ROW_HEIGHT 100

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * dataArr;
@property (nonatomic,strong) NSString * modelStr;
@property (nonatomic,strong) NSString * cellID;

@property (nonatomic,strong) UITableView * table;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)initWithData:(NSArray *)dataArr andCellModel:(NSString *)modelStr andCell:(NSString *)cellID{
    self.dataArr = dataArr;
    self.modelStr = modelStr;
    self.cellID = cellID;
}

- (UITableView *)table{
    if (_table == nil) {

        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TABLE_ROW_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * className = [NSString stringWithFormat:@"%@",self.cellID];
    Class myCell = NSClassFromString(className);
    UITableViewCell * cell = [[myCell alloc]init];
    cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        
        cell = [[myCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    
    NSString * classModel = [NSString stringWithFormat:@"%@",self.modelStr];
    Class modelClass = NSClassFromString(classModel);
    NSObject * model = [[modelClass alloc]init];
    model = self.dataArr[indexPath.row];
    
    
    return cell;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:in forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
