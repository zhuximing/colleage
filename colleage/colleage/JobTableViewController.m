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
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "JobDetail.h"

@interface JobTableViewController ()

@end

@implementation JobTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    jobArr=[[NSMutableArray alloc] init];
    
    
    //初始化每页显示的数量
    pageSize=4;
     self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"校园兼职"];
    
    
    //弱引用
    __weak JobTableViewController *weakSelf = self;
    
    // 设置下拉刷新
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refresh];
    }];
    
    // 设置上拉加载
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf load];
    }];
    
    //刚开始隐藏上拉加载，因为不知道能加载到多少条
    self.tableView.showsInfiniteScrolling = NO;
    //self.tableView.showsPullToRefresh = NO;
    //进入该视图控制器自动下拉刷新
    [self.tableView triggerPullToRefresh];

}

//加载数据 flag参数是告诉它是下啦加载数据还是上拉加载数据
-(void)loadData:(NSString*)flag{
    if ([@"refresh" isEqualToString:flag]) {
        //刷新 当前页归零，也就是第一页
        pageNow=0;
    }else{
        //加载更多,让当前页++
        pageNow++;
    }
    
    //计算偏移量 同时把他转变成字符串
    NSString *offset=[NSString stringWithFormat:@"%d",pageNow*pageSize];
    //将pagesize转变成字符场
    NSString *pageSizeStr=[NSString stringWithFormat:@"%d",pageSize];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:BASEHOME customHeaderFields:nil];
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:@"10",@"pagesize",@"0",@"offset",@"三峡大学",@"school", nil];

    MKNetworkOperation *op = [engine operationWithPath:@"job/get_job_by_offset" params:parames httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self hide];
        id json=[completedOperation responseJSON];
        NSLog(@"%@",json);
        NSArray *array=(NSArray*)json;
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [jobArr removeAllObjects];
            [jobArr addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
            [jobArr addObjectsFromArray:array];
            
        }
        
        
        
        //选择性开启上拉加载
        if (jobArr.count<pageSize) {
            //如果加载的数据小于于pageSize条 不让他可以上拉加载
            self.tableView.showsInfiniteScrolling=NO;
        }else{
            //如果加载的数据大于pageSize条 让他可以上拉加载
            self.tableView.showsInfiniteScrolling=YES;
        }
        //数据刷新到表格里面去
        [self.tableView reloadData];
        
        //隐藏动画
        [self.tableView.pullToRefreshView stopAnimating ];
        [self.tableView.infiniteScrollingView stopAnimating] ;
        
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [self showToast:@"网络异常"];
        //隐藏动画
        [self.tableView.pullToRefreshView stopAnimating ];
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
    
    [engine enqueueOperation:op];
}


//刷新
-(void)refresh{
    
    __weak JobTableViewController *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak JobTableViewController *weakSelf = self;
    [weakSelf loadData:@"more"];
    
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
    cell.personscountlbl.text=[NSString stringWithFormat:@"招聘人数：%@",[jobArr[indexPath.row] objectForKey:@"job_persons_count"]];
    cell.moneylbl.textColor=[UIColor redColor];
    cell.moneylbl.text=[NSString stringWithFormat:@"%@元/天",[jobArr[indexPath.row] objectForKey:@"job_money"]];
    
    cell.timelbl.text=[jobArr[indexPath.row] objectForKey:@"job_time"];
    return  cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取登陆后的个人中心的视图控制器
    JobDetail *job=[story instantiateViewControllerWithIdentifier:@"LostDetail"];
    
    job.lost_id=[jobArr[indexPath.row] objectForKey:@"job_id"];
    job.user_phone=[jobArr[indexPath.row] objectForKey:@"job_phone"];
    job.HttpPath=@"job/job_detail";
    [self.navigationController pushViewController:job animated:YES];
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
