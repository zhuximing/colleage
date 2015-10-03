//
//  CommonList.m
//  colleage
//
//  Created by Apple on 15/9/24.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CommonList.h"
#import "DOPDropDownMenu.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "CommonCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CommonUtil.h"
#import "LostDetail.h"
#import "PublishDinner.h"
@interface CommonList (){
    NSDictionary *parames;//请求参数
    NSString *url;        //请求地址
}
@end

@implementation CommonList

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    target_s=@"";
    time_s=@"";
    theme_s=@"";
    sport_s=@"";
    mudidi_s=@"";
    _time=[[NSMutableArray alloc] init];
    yues=[[NSMutableArray alloc] init];
    pageSize=4;
    parames=[[NSDictionary alloc] init];
   //标题
    if ([self.type isEqualToString:@"dinner"]) {
         self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"一起吃饭"];
    }else if([self.type isEqualToString:@"ktv"]){
         self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"一起唱歌"];
    }else if([self.type isEqualToString:@"movie"]){
         self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"一起看电影"];
    }else if([self.type isEqualToString:@"sport"]){
        self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"一起运动"];
    }else if([self.type isEqualToString:@"tour"]){
        self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"一起旅游"];
    }else if([self.type isEqualToString:@"theme"]){
        self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"主题约会"];
    }
    
    // 分类型查询
    self.target = @[@"邀约对象",@"男女不限",@"仅限女生",@"仅限男生"];
    self.sport=@[@"运动项目",@"足球",@"篮球",@"羽毛球",@"乒乓球"];
    self.mudidi=@[@"目的地",@"三亚",@"丽江",@"大理",@"马尔代夫",@"香港",@"西藏"];
    self.theme=@[@"约会主题",@"操场上闲聊",@"图书馆自习",@"互诉心事",@"钓鱼",@"逛街购物"];
    //时间补充未来一周的时间数据
    [self getWeekDate];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    
    //弱引用
    __weak CommonList *weakSelf = self;
    
    // 设置下拉刷新
    [self.yueList addPullToRefreshWithActionHandler:^{
        [weakSelf refresh];
    }];
    
    // 设置上拉加载
    [self.yueList addInfiniteScrollingWithActionHandler:^{
        [weakSelf load];
    }];
    
    //刚开始隐藏上拉加载，因为不知道能加载到多少条
    self.yueList.showsInfiniteScrolling = NO;
    //self.tableView.showsPullToRefresh = NO;
    //进入该视图控制器自动下拉刷新
    [self.yueList triggerPullToRefresh];
    
    
    
    //发布
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}

//发布
-(void)publish{
    PublishDinner *yue=[self getViewController:@"PublishDinner"];
    [self.navigationController pushViewController:yue animated:YES];

}


//获取未来一周的时间，并生成数组
-(void) getWeekDate{
    
    NSDate *today=[NSDate date];
    [self.time addObject:@"邀约时间"];
    [self.time addObject:@"任意时间"];
    [self.time addObject:@"周末"];
    NSDateFormatter *format1=[[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"yyyy-MM-dd"];
    for(int i=0;i<7;i++){
        NSDate *item=[NSDate dateWithTimeInterval:60 * 60 * 24*i sinceDate:today];
        NSString *itemString=[format1 stringFromDate:item];
        [self.time addObject:itemString];
        
    }
    
}

//菜单按钮的代理
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    if ([self.type isEqualToString:@"dinner"]||[self.type isEqualToString:@"ktv"]||[self.type isEqualToString:@"movie"]) {
        return 2;
    }else{
        return 3;
    }
    
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if ([self.type isEqualToString:@"dinner"]||[self.type isEqualToString:@"ktv"]||[self.type isEqualToString:@"movie"]) {
        if (column==0) {
            return self.target.count;
        }else{
        
            return self.time.count;
        }
    }else if ([self.type isEqualToString:@"sport"]){
        if (column==0) {
            return self.sport.count;
        }
        else if (column==1) {
            return self.target.count;
        }
        
        else if (column==2) {
            return self.time.count;
        }else{
            return 0;
            
        }

    
    }else if ([self.type isEqualToString:@"tour"]){
        if (column==0) {
            return self.mudidi.count;
        }
        else if (column==1) {
            return self.target.count;
        }
        
        else if (column==2) {
            return self.time.count;
        }else{
            return 0;
            
        }
    
    }else if ([self.type isEqualToString:@"theme"]){
        if (column==0) {
            return self.theme.count;
        }
        else if (column==1) {
            return self.target.count;
        }
        
        else if (column==2) {
            return self.time.count;
        }else{
            return 0;
        }
        
    }else{
    
        return 0;
    }

    
   
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if ([self.type isEqualToString:@"dinner"]||[self.type isEqualToString:@"ktv"]||[self.type isEqualToString:@"movie"]) {
        if (indexPath.column == 0) {
            return self.target[indexPath.row];
        } else{
            return self.time[indexPath.row];
        }
    }else if([self.type isEqualToString:@"sport"]){
        if (indexPath.column==0) {
            return  self.sport[indexPath.row];
        }else if (indexPath.column==1){
        
            return self.target[indexPath.row];
        }
        else if (indexPath.column==2){
            return self.time[indexPath.row];
        
        }else{
        
            return @"";
        
        }
    
    
    }
    else if([self.type isEqualToString:@"tour"]){
        if (indexPath.column==0) {
            return  self.mudidi[indexPath.row];
        }else if (indexPath.column==1){
            
            return self.target[indexPath.row];
        }
        else if (indexPath.column==2){
            return self.time[indexPath.row];
            
        }else{
            
            return @"";
            
        }
        
        
    }
    else if([self.type isEqualToString:@"theme"]){
        if (indexPath.column==0) {
            return  self.theme[indexPath.row];
        }else if (indexPath.column==1){
            
            return self.target[indexPath.row];
        }
        else if (indexPath.column==2){
            return self.time[indexPath.row];
            
        }else{
            
            return @"";
            
        }
        
        
    }
    else{
    
        return @"";
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

//点击发送请求
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    [self showProgressing:@"正在加载"];
    //最终的饭局、唱歌、看电影
    if ([self.type isEqualToString:@"dinner"]||[self.type isEqualToString:@"ktv"]||[self.type isEqualToString:@"movie"]) {
        if (indexPath.column==0) {
            target_s=self.target[indexPath.row];
            if ([target_s isEqualToString:@"邀约对象"]) {
                target_s=@"";
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
    //最终的运动项目
    else if ([self.type isEqualToString:@"sport"]){
    
        if (indexPath.column==0) {
            sport_s=self.sport[indexPath.row];
            if ([sport_s isEqualToString:@"运动项目"]) {
                sport_s=@"";
            }
            
            [self loadData:@"refresh"];
        }
        if (indexPath.column==1) {
            target_s=self.target[indexPath.row];
            if ([target_s isEqualToString:@"邀约对象"]) {
                target_s=@"";
            }
            
            [self loadData:@"refresh"];
        }
        if (indexPath.column==2) {
            time_s=self.time[indexPath.row];
            if ([time_s isEqualToString:@"出发时间"]) {
                time_s=@"";
            }
            [self loadData:@"refresh"];
        }
    
    }
    //最终的目的地
    else if ([self.type isEqualToString:@"tour"]){
        
        if (indexPath.column==0) {
            mudidi_s=self.mudidi[indexPath.row];
            if ([mudidi_s isEqualToString:@"目的地"]) {
                mudidi_s=@"";
            }
            
            [self loadData:@"refresh"];
        }
        if (indexPath.column==1) {
            target_s=self.target[indexPath.row];
            if ([target_s isEqualToString:@"邀约对象"]) {
                target_s=@"";
            }
            
            [self loadData:@"refresh"];
        }
        if (indexPath.column==2) {
            time_s=self.time[indexPath.row];
            if ([time_s isEqualToString:@"出发时间"]) {
                time_s=@"";
            }
            [self loadData:@"refresh"];
        }
        
    }
    //最终的主题
    else if ([self.type isEqualToString:@"theme"]){
        
        if (indexPath.column==0) {
            theme_s=self.theme[indexPath.row];
            if ([theme_s isEqualToString:@"约会主题"]) {
                theme_s=@"";
            }
            
             [self loadData:@"refresh"];
        }
        if (indexPath.column==1) {
            target_s=self.target[indexPath.row];
            if ([target_s isEqualToString:@"邀约对象"]) {
                target_s=@"";
            }
            
            [self loadData:@"refresh"];
        }
        if (indexPath.column==2) {
            time_s=self.time[indexPath.row];
            if ([time_s isEqualToString:@"出发时间"]) {
                time_s=@"";
            }
            [self loadData:@"refresh"];
        }
        
    }



}
//表格代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return  yues.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *normalId=@"CommonCell";
    CommonCell *ycell=[tableView dequeueReusableCellWithIdentifier:normalId forIndexPath:indexPath];
    
    if (!ycell) {
        ycell=[[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalId];
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
    
    __weak CommonList *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak CommonList *weakSelf = self;
    [weakSelf loadData:@"more"];
    
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
    
    
    
    
    
    if ([self.type isEqualToString:@"dinner"]||[self.type isEqualToString:@"ktv"]||[self.type isEqualToString:@"movie"]) {
        //约饭、唱歌、看电影的请求参数
        parames=[NSDictionary  dictionaryWithObjectsAndKeys:      pageSizeStr,@"pagesize",
                 offset,@"offset",
                 @"三峡大学",@"school",
                 self.type,@"yue_type",
                 target_s,@"yue_target",
                 time_s,@"yue_time",nil];
        url=@"yueba/get_yue_list";
    }else if ([self.type isEqualToString:@"sport"]){
        
        //约运动的请求参数
        parames=[NSDictionary  dictionaryWithObjectsAndKeys:      pageSizeStr,@"pagesize",
                 offset,@"offset",
                 @"三峡大学",@"school",
                 sport_s,@"yue_sport",
                 target_s,@"yue_target",
                 time_s,@"yue_time",nil];
        url=@"yueba/get_yuesport_list";
        
        
        
    }else if ([self.type isEqualToString:@"tour"]){
        
        //约旅游的请求参数
        parames=[NSDictionary  dictionaryWithObjectsAndKeys:      pageSizeStr,@"pagesize",
                 offset,@"offset",
                 @"三峡大学",@"school",
                 mudidi_s,@"yue_address",
                 target_s,@"yue_target",
                 time_s,@"yue_time",nil];
        url=@"yueba/get_yuetour_list";
        
        
    }else if ([self.type isEqualToString:@"theme"]){
        //约主题的请求参数
        parames=[NSDictionary  dictionaryWithObjectsAndKeys:      pageSizeStr,@"pagesize",
                 offset,@"offset",
                 @"三峡大学",@"school",
                 theme_s,@"yue_theme",
                 target_s,@"yue_target",
                 time_s,@"yue_time",nil];
        
        
        url=@"yueba/get_yuetheme_list";
        
    }
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:url params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
        //NSLog(@"%@",json);
        //加载到的数据
        NSArray *array=(NSArray*)json;
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [yues removeAllObjects];
            [yues addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
            [yues addObjectsFromArray:array];
            
        }
        
        
        
        //选择性开启上拉加载
        if (array.count<pageSize) {
            //如果加载的数据小于于pageSize条 不让他可以上拉加载
            self.yueList.showsInfiniteScrolling=NO;
        }else{
            //如果加载的数据大于pageSize条 让他可以上拉加载
            self.yueList.showsInfiniteScrolling=YES;
        }
        //数据刷新到表格里面去
        [self.yueList reloadData];
        
        //隐藏动画
        [self hide];
        [self.yueList.pullToRefreshView stopAnimating ];
        [self.yueList.infiniteScrollingView stopAnimating] ;
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        //隐藏动画
        [self hide];
        [self.yueList.pullToRefreshView stopAnimating ];
        [self.yueList.infiniteScrollingView stopAnimating];
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
}


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
