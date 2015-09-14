//
//  HourseViewController.m
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "HourseViewController.h"
#import "CommonUtil.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "HourseTableViewCell.h"
#import "NSDate+TimeAgo.h"
#import "LostDetail.h"
#import "PublishHourseViewController.h"

@interface HourseViewController ()

@end

@implementation HourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"校园合租列表"];
    hourseArr=[[NSMutableArray alloc] init];
    pageSize=4;
    
    //右边的添加按钮
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(addHourse) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    //弱引用
    __weak HourseViewController *weakSelf = self;
    
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
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:pageSizeStr,@"pagesize",offset,@"offset",@"三峡大学",@"school", nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"share_house/get_houses_by_offset" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
        NSLog(@"%@",json);
        //加载到的数据
        NSArray *array=(NSArray*)json;
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [hourseArr removeAllObjects];
            [hourseArr addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
            [hourseArr addObjectsFromArray:array];
            
        }
        
        
        
        //选择性开启上拉加载
        if (hourseArr.count<pageSize) {
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
    
    __weak HourseViewController *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak HourseViewController *weakSelf = self;
    [weakSelf loadData:@"more"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//发布房屋
-(void)addHourse{
    PublishHourseViewController *publish =[self getViewController:@"PublishHourse"];
   [self.navigationController pushViewController:publish animated:YES];

}

#pragma  mark -tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return hourseArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HourseTableViewCell";
    
    HourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[HourseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.hourseImg.image=[UIImage imageNamed:[[hourseArr objectAtIndex:indexPath.row]objectForKey:@"sh_img" ]];
    cell.titlelbl.text=[[hourseArr objectAtIndex:indexPath.row] objectForKey:@"sh_title"];
    NSString *address=[[hourseArr objectAtIndex:indexPath.row] objectForKey:@"sh_address"];
    cell.addresslbl.text=[NSString stringWithFormat:@"地址：%@",address];
    
    NSString *price=[[hourseArr objectAtIndex:indexPath.row] objectForKey:@"sh_price"];
    cell.pricelbl.text=[NSString stringWithFormat:@"房价：%@",price];
    
    cell.schoollbl.text=[[hourseArr objectAtIndex:indexPath.row] objectForKey:@"user_school"];
    
    NSDate *date=(NSDate *)[[hourseArr objectAtIndex:indexPath.row] objectForKey:@"sh_time"];
    cell.timelbl.text=[[hourseArr objectAtIndex:indexPath.row] objectForKey:@"sh_time"];

    return cell;
}
//详情页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取登陆后的个人中心的视图控制器
    LostDetail *lost=[story instantiateViewControllerWithIdentifier:@"LostDetail"];
    
    lost.lost_id=[hourseArr[indexPath.row] objectForKey:@"share_house_id"];
    lost.user_phone=[hourseArr[indexPath.row] objectForKey:@"user_phone"];
    lost.HttpPath=@"share_house/go_to_detail";
    [self.navigationController pushViewController:lost animated:YES];
}




-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData:@"refresh"];

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
