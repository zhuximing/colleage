//
//  LifeViewController.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LifeViewController.h"
#import "CommonUtil.h"
#import "YueBaHeader.h"
#import "YueCell.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LostDetail.h"
@interface LifeViewController ()

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"约起来";
    self.view.backgroundColor=[UIColor grayColor];
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"约吧"];
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
   
    //初始化数组
    yues=[[NSMutableArray alloc] init];
    
    //表格头部
    YueBaHeader *header=[[YueBaHeader alloc] init];
    header.frame=CGRectMake(0, 0, ScreenWidth, 200);
    self.tableView.tableHeaderView=header;
    //将导航控制器传给头部视图
    header.nav=self.navigationController;
    
    
    
    //弱引用
    __weak LifeViewController *weakSelf = self;
    
    // 设置下拉刷新
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf refresh];
    }];
    //进入该视图控制器自动下拉刷新
    [self.tableView triggerPullToRefresh];

    
    //初始化加载器
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    //self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

-(void)loadData{
    
    //获取数据
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    
    //请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:@"三峡大学",@"school", nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"yueba/get_yueba_top" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
        //加载到的数据
        NSArray *array=(NSArray*)json;
        //处理数据
        
        [yues addObjectsFromArray:array];
            
       
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
//显示吐司
-(void) showToast:(NSString*)info{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = info;
    [hud show:YES];
    [hud hide:YES afterDelay:0.7f];
}
//点击详情

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    LostDetail *lost=[story instantiateViewControllerWithIdentifier:@"LostDetail"];
    
    lost.lost_id=[yues[indexPath.row] objectForKey:@"yue_id"];
    lost.user_phone=[yues[indexPath.row] objectForKey:@"user_phone"];
    lost.HttpPath=@"yueba/yuefan_detail";
    [self.navigationController pushViewController:lost animated:YES];
}


//刷新
-(void)refresh{
    
    __weak LifeViewController *weakSelf = self;
    [weakSelf loadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return  yues.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
        static NSString *normalId=@"YueCell";
        YueCell *ycell=[tableView dequeueReusableCellWithIdentifier:normalId forIndexPath:indexPath];
        
        if (ycell==nil) {
            ycell=[[YueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalId];
        }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",HEADIMGURL,[yues[indexPath.row] objectForKey:@"user_img"]];
    NSLog(@"%@",url);
    [ycell.head_img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"setting_head"]];
    ycell.username.text=[yues[indexPath.row] objectForKey:@"user_name"];
    ycell.school.text=[yues[indexPath.row] objectForKey:@"user_school"];
    ycell.sex.text=[yues[indexPath.row] objectForKey:@"user_sex"];
    ycell.yue_title.text=[NSString stringWithFormat:@"标题:%@",[yues[indexPath.row] objectForKey:@"yue_title"]];
    ycell.yue_time.text=[NSString stringWithFormat:@"时间:%@",[yues[indexPath.row] objectForKey:@"yue_time"]];
    ycell.yue_address.text=[NSString stringWithFormat:@"地点:%@",[yues[indexPath.row] objectForKey:@"yue_address"]];

    ycell.publish_time.text=[NSString stringWithFormat:@"发布时间:%@",[yues[indexPath.row] objectForKey:@"yue_publish_time"]];
    
    return ycell;
    
}

/**
 section的头视图高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
   
        return 10;
    
}


/**
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}*/

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    //headerView.backgroundColor = RGB(239, 239, 244);
    
    headerView.backgroundColor = [UIColor grayColor];
    return headerView;
}
/**
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
    //footerView.backgroundColor = RGB(239, 239, 244);
        footerView.backgroundColor = [UIColor yellowColor];
    return footerView;
}
*/



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
