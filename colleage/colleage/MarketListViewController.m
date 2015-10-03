//
//  MarketListViewController.m
//  colleage
//
//  Created by Apple on 15/9/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "MarketListViewController.h"
#import "CommonUtil.h"
#import "MarketListTableViewCell.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "NSDate+TimeAgo.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MarketListViewController ()

@end

@implementation MarketListViewController
@synthesize typetitle;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSString *title= [NSString stringWithFormat:@"%@列表",self.typetitle];
   self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:title];
    marketArr=[[NSMutableArray alloc] init];
    pageSize=5;
    //弱引用
    __weak MarketListViewController *weakSelf = self;
    
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
    
    // NSLog(@"pagenow%d",pageNow);
    
    
    //[self showProgressing:@"加载中..."];
    //获取数据
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:pageSizeStr,@"pagesize",offset,@"offset",@"三峡大学",@"school",self.typetitle,@"type",nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"sale/get_sale_by_offset" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
        //NSLog(@"%@",json);
        //加载到的数据
        NSArray *array=(NSArray*)json;
        
        NSLog(@"%@",array);
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [marketArr removeAllObjects];
            [marketArr addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
            [marketArr addObjectsFromArray:array];
            
        }
        
        
        
        //选择性开启上拉加载
        if (marketArr.count<pageSize) {
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
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        //隐藏动画
        [self.tableView.pullToRefreshView stopAnimating ];
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
    
    [engine enqueueOperation:op];
    
}


//刷新
-(void)refresh{
    
    __weak MarketListViewController *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak MarketListViewController *weakSelf = self;
    [weakSelf loadData:@"more"];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return marketArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MarketListCell";
    
    MarketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[MarketListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    //赋值
    
    NSString *t=[[marketArr objectAtIndex:indexPath.row] objectForKey:@"sale_title"];
    cell.title.text=[NSString stringWithFormat:@"标题：%@",t];
    
    NSString *time=[[marketArr objectAtIndex:indexPath.row] objectForKey:@"sale_publish_time"];
    cell.time.text=[CommonUtil getTimeAgo:time];
    NSString *s=[[marketArr objectAtIndex:indexPath.row] objectForKey:@"user_school"];
    cell.school.text=[NSString stringWithFormat:@"学校：%@",s];
    
    NSString *p=[[marketArr objectAtIndex:indexPath.row] objectForKey:@"sale_sale_price"];
    cell.price.text=[NSString stringWithFormat:@"价格：¥%@",p];
    NSString *imgPath=[[marketArr objectAtIndex:indexPath.row] objectForKey:@"sale_brief_pic"];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:@"setting_head"]];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@",marketArr);
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
