//
//  JobTableViewController.m
//  colleage
//
//  Created by Apple on 15/9/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "JobTableViewController.h"
#import "CommonUtil.h"
#import "JobTableViewCell.h"
#import "LostTableViewCell.h"

@interface JobTableViewController ()

@end

@implementation JobTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"校园兼职"];
    [self loadData];
//    static NSString *cellIdentifier = @"JobTableViewCell";
//    [self.tableView registerClass:[JobTableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

//加载数据
-(void)loadData{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:BASEHOME customHeaderFields:nil];
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:@"10",@"pagesize",@"0",@"offset",@"三峡大学",@"school", nil];

    MKNetworkOperation *op = [engine operationWithPath:@"job/get_job_by_offset" params:parames httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self hide];
        id json=[completedOperation responseJSON];
        jobArr=(NSArray *)json;
        NSLog(@"%@",jobArr);
        [self.tableView reloadData];
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        NSLog(@"加载失败");
        
    }];
    
    [engine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return jobArr.count;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"JobTableViewCell";
    
     JobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[JobTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.titlelbl.text=[jobArr[indexPath.row] objectForKey:@"job_title"];
    cell.companlbl.text=[NSString stringWithFormat:@"公司：%@",[jobArr[indexPath.row] objectForKey:@"c_name"]] ;
    cell.personscountlbl.text=[jobArr[indexPath.row] objectForKey:@"job_persons_count"];
    cell.moneylbl.text=[jobArr[indexPath.row] objectForKey:@"job_money"];
    cell.timelbl.text=[jobArr[indexPath.row] objectForKey:@"job_time"];
    return  cell;

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
