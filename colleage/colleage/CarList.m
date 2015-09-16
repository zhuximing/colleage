//
//  CarList.m
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CarList.h"
#import "CarCell.h"
#import "CommonUtil.h"
#import "DOPDropDownMenu.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "LostDetail.h"
#import "PublishCar.h"
@interface CarList ()

@end

@implementation CarList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数组
    cars=[[NSMutableArray alloc] init];
    //初始化每页显示的数量
    pageSize=4;
    //初始化数据
    target_s=@"";
    time_s=@"";
    
    
    
    
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"路线列表"];
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    //右边的添加按钮
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(addcar) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    NSLog(@"start%@",self.start_city);
    NSLog(@"end%@",self.end_city);
    
    // 数据
    self.target = @[@"类型",@"车主找人",@"学生找车"];
    self.time = @[@"出发时间",@"今天"];
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
   
    
    //弱引用
    __weak CarList *weakSelf = self;
    
    // 设置下拉刷新
    [self.carList addPullToRefreshWithActionHandler:^{
        [weakSelf refresh];
    }];
    
    // 设置上拉加载
    [self.carList addInfiniteScrollingWithActionHandler:^{
        [weakSelf load];
    }];
    
    //刚开始隐藏上拉加载，因为不知道能加载到多少条
    self.carList.showsInfiniteScrolling = NO;
    //self.tableView.showsPullToRefresh = NO;
    //进入该视图控制器自动下拉刷新
    [self.carList triggerPullToRefresh];
    
    
    
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
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:pageSizeStr,@"pagesize",
        offset,@"offset",
        @"三峡大学",@"school",
        @"0",@"type",
        target_s,@"target_s",
        time_s,@"time_s",
        _start_city,@"pingche_start_city",
        _end_city,@"pingche_end_city",nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"pingche/getlist" params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
       // NSLog(@"%@",json);
        //加载到的数据
        NSArray *array=(NSArray*)json;
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [cars removeAllObjects];
            [cars addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
            [cars addObjectsFromArray:array];
            
        }
        
        
        
        //选择性开启上拉加载
        if (cars.count<pageSize) {
            //如果加载的数据小于于pageSize条 不让他可以上拉加载
            self.carList.showsInfiniteScrolling=NO;
        }else{
            //如果加载的数据大于pageSize条 让他可以上拉加载
            self.carList.showsInfiniteScrolling=YES;
        }
        //数据刷新到表格里面去
        [self.carList reloadData];
        
        //隐藏动画
        [self hide];
        [self.carList.pullToRefreshView stopAnimating ];
        [self.carList.infiniteScrollingView stopAnimating] ;
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        //隐藏动画
        [self hide];
        [self.carList.pullToRefreshView stopAnimating ];
        [self.carList.infiniteScrollingView stopAnimating];
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
}
//添加发布
-(void)addcar{
    PublishCar *publish=[[PublishCar alloc] init];
    [self.navigationController pushViewController:publish animated:YES];
    

}
//刷新
-(void)refresh{
    
    __weak CarList *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak CarList *weakSelf = self;
    [weakSelf loadData:@"more"];
    
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

       return cars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CarCell";
    
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[CarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    //赋值
    cell.path.text=[cars[indexPath.row] objectForKey:@"pingche_title"];
    cell.start_time.text=[NSString stringWithFormat:@"出发时间:%@",[cars[indexPath.row] objectForKey:@"pingche_start_time"]];
    cell.publish_time.text=[cars[indexPath.row] objectForKey:@"pingche_publish_time"];
    
    NSString *pingche_who=[cars[indexPath.row] objectForKey:@"pingche_who"];
    if ([pingche_who isEqualToString:@"车"]) {
        cell.persons.text=[NSString stringWithFormat:@"还有空位:%@",[cars[indexPath.row] objectForKey:@"pingche_persons"]];
        cell.flag.text=@"我是车主";
    }else{
        cell.persons.text=[NSString stringWithFormat:@"%@人要拼车",[cars[indexPath.row] objectForKey:@"pingche_persons"]];
        cell.flag.text=@"我是乘客";
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
     UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
     LostDetail *lost=[story instantiateViewControllerWithIdentifier:@"LostDetail"];
    
     lost.lost_id=[cars[indexPath.row] objectForKey:@"pingche_id"];
     lost.user_phone=[cars[indexPath.row] objectForKey:@"user_phone"];
     lost.HttpPath=@"pingche/pingche_detail";
     [self.navigationController pushViewController:lost animated:YES];
}

- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.target.count;
    }else {
        return self.time.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.target[indexPath.row];
    } else{
        return self.time[indexPath.row];
    }
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
  
    return 0;
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
   
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
//    if (indexPath.item >= 0) {
//        NSLog(@"点击了 %ld - %ld - %ld 项目",indexPath.column,indexPath.row,indexPath.item);
//    }else {
//        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
//    }
    //菊花
    [self showProgressing:@"正在加载"];
    
    if (indexPath.column==0) {
        target_s=self.target[indexPath.row];
        if ([target_s isEqualToString:@"类型"]) {
            target_s=@"";
        }else if([target_s isEqualToString:@"学生找车"]){
            target_s=@"车";
        }else if([target_s isEqualToString:@"车主找人"]){
            target_s=@"人";
        }
        
        [self loadData:@"refresh"];
    }
    if (indexPath.column==1) {
        time_s=self.time[indexPath.row];
        if ([time_s isEqualToString:@"出发时间"]) {
            time_s=@"";
        }
        [self loadData:@"refresh"];
    }
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
