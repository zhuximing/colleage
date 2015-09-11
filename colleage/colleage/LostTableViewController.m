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
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "PublishLost.h"
@implementation LostTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数组
    losts=[[NSMutableArray alloc] init];
    //初始化每页显示的数量
    pageSize=4;
    
    
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"失物招领"];
    
    
    //右边的添加按钮
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(addlost) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    //弱引用
    __weak LostTableViewController *weakSelf = self;
    
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
    MKNetworkOperation *op=[engine operationWithPath:@"lost/get_lost_by_offset" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
      
        
        id json=[completedOperation responseJSON];
        //加载到的数据
        NSArray *array=(NSArray*)json;
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [losts removeAllObjects];
            [losts addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
             [losts addObjectsFromArray:array];
        
        }
        
        
        
        //选择性开启上拉加载
        if (losts.count<pageSize) {
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

     __weak LostTableViewController *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak LostTableViewController *weakSelf = self;
    [weakSelf loadData:@"more"];

}

//发布失物招领
-(void)addlost{
    PublishLost *publish=[self getViewController:@"PublishLost"];
    [self.navigationController pushViewController:publish animated:YES];
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
    lost.HttpPath=@"lost/lost_detail";
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
