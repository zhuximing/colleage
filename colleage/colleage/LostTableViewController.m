//
//  LostTableViewController.m
//  colleage
//
//  Created by Apple on 15/9/8.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LostTableViewController.h"
#import "CommonUtil.h"
#import "LostTableViewCell.h"
#import "LostDetail.h"
@implementation LostTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"失物招领"];
   
    [self loadData];
}
//加载数据
-(void)loadData{
    [self showProgressing:@"加载中..."];
    //获取数据
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:@"10",@"pagesize",@"0",@"offset",@"三峡大学",@"school", nil];
    MKNetworkOperation *op=[engine operationWithPath:@"lost/get_lost_by_offset" params:parames httpMethod:@"POST"];
    
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
      
        [self hide];
         id json=[completedOperation responseJSON];
         losts=(NSArray*)json;
         [self.tableView reloadData];
        
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
    }];
    [engine enqueueOperation:op];




}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
      return losts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"LostTableViewCell";
    
    LostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[LostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    //赋值
    cell.lost_name.text=[losts[indexPath.row] objectForKey:@"lost_name"];
    
    cell.school.text=[losts[indexPath.row] objectForKey:@"user_school"];
    
    cell.lost_address.text=[losts[indexPath.row] objectForKey:@"lost_address"];
    cell.publish_time.text=[losts[indexPath.row] objectForKey:@"lost_time"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取登陆后的个人中心的视图控制器
    LostDetail *lost=[story instantiateViewControllerWithIdentifier:@"LostDetail"];

    lost.lost_id=[losts[indexPath.row] objectForKey:@"lost_id"];
    lost.user_phone=[losts[indexPath.row] objectForKey:@"user_phone"];
    [self.navigationController pushViewController:lost animated:YES];
}

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
