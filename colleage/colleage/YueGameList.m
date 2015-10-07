//
//  YueGameList.m
//  colleage
//
//  Created by Apple on 15/9/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "YueGameList.h"
#import "CommonUtil.h"
#import "DOPDropDownMenu.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "YueGameCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LostDetail.h"
#import "PublishGame.h"
@interface YueGameList ()<DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
@property (nonatomic, strong) NSArray *gametypes;
@property (nonatomic, strong) NSArray *wangyou;
@property (nonatomic, strong) NSArray *yeyou;
@property (nonatomic, strong) NSArray *shouyou;
@property(nonatomic,strong) NSArray *jingji;
@property (nonatomic, strong) NSArray *target;
@property (nonatomic, strong) NSMutableArray *time;
@property (nonatomic, strong) NSMutableArray *yues;
@end

@implementation YueGameList

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    self.time=[[NSMutableArray alloc] init];
    self.yues=[[NSMutableArray alloc] init];
    pageNow=0;
    pageSize=10;
    game=@"";
    time_s=@"";
    target_s=@"";
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"一起玩游戏"];
    
    // 数据
    self.gametypes = @[@"游戏分类",@"网游",@"页游",@"手游",@"竞技"];
    self.wangyou = @[@"魔兽世界",@"天涯明月刀",@"地下城与勇士",@"剑灵",@"天龙八部",@"梦幻西游",@"笑傲江湖",@"问道",@"诛仙",@"传奇",@"完美世界",@"龙之谷",@"轩辕传奇"];
    self.yeyou = @[@"大天使之剑",@"传奇霸业",@"天书世界",@"火影忍者",@"苍穹变",@"雷霆之怒",@"烈焰",@"斩仙"];
    self.shouyou = @[@"刀塔传奇",@"梦幻西游",@"天天酷跑",@"魔灵召唤",@"天天来战",@"放开那三国"];
    self.jingji = @[@"英雄联盟",@"dota2",@"真三",@"群雄逐鹿",@"三国争霸"];
    self.target = @[@"邀约对象",@"男女不限",@"仅限女生",@"仅限男生"];
    [self getWeekDate];

    
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:44];
    
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    
    
    
    
    [self setUpTableView];
    
}

-(void)setUpTableView{
    //添加下拉的动画图片
    //设置下拉刷新回调
    [self.yueList addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    //设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd",i]];
        [idleImages addObject:image];
    }
    [self.yueList.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    //设置即将刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd",i]];
        [refreshingImages addObject:image];
    }
    [self.yueList.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    //设置正在刷新是的动画图片
    [self.yueList.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    
    //马上进入刷新状态
    [self.yueList.gifHeader beginRefreshing];
    
    
    //上拉刷新
    [self.yueList addGifFooterWithRefreshingTarget:self refreshingAction:@selector(load)];
    
    //隐藏状态文字
    //    self.tableView.footer.stateHidden = YES;
    //设置正在刷新的动画
    self.yueList.gifFooter.refreshingImages = refreshingImages;
    
    self.yueList.footer.hidden=YES;
    
    
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

-(void)publish{
    PublishGame *pg=[self getViewController:@"PublishGame"];
    [self.navigationController pushViewController:pg animated:YES];
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

//按钮点击代理
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 3;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return self.gametypes.count;
    }else if (column == 1){
        return self.target.count;
    }else {
        return self.time.count;
    }
}
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column
{
    if (column == 0) {
        if (row == 1) {
            return self.wangyou.count;
        } else if (row == 2){
            return self.yeyou.count;
        } else if (row == 3){
            return self.shouyou.count;
        }else if (row == 4){
            return self.jingji.count;
        }
    }
    return 0;
}
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        return self.gametypes[indexPath.row];
    } else if (indexPath.column == 1){
        return self.target[indexPath.row];
    } else {
        return self.time[indexPath.row];
    }
}



- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
        if (indexPath.row == 1) {
            return self.wangyou[indexPath.item];
        } else if (indexPath.row == 2){
            return self.yeyou[indexPath.item];
        } else if (indexPath.row == 3){
            return self.shouyou[indexPath.item];
        }else if(indexPath.row == 4){
        
            return self.jingji[indexPath.item];
        }
    }
    return nil;
}

- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    
    if (indexPath.column==0) {
        
        if (indexPath.row==0) {
            [self showProgressing:@"正在加载"];
            game=@"";
            [self loadData:@"refresh"];
        }else if (indexPath.row==1&&indexPath.item>=0){
           [self showProgressing:@"正在加载"];
            game=_wangyou[indexPath.item];
            [self loadData:@"refresh"];
        }else if (indexPath.row==2&&indexPath.item>=0){
            [self showProgressing:@"正在加载"];
            game=_yeyou[indexPath.item];
            [self loadData:@"refresh"];
        }else if (indexPath.row==3&&indexPath.item>=0){
            [self showProgressing:@"正在加载"];
            game=_shouyou[indexPath.item];
            [self loadData:@"refresh"];
        }else if (indexPath.row==4&&indexPath.item>=0){
            [self showProgressing:@"正在加载"];
            game=_jingji[indexPath.item];
            [self loadData:@"refresh"];
        }
        
        
    }else if (indexPath.column==1){
        [self showProgressing:@"正在加载"];
        target_s=_target[indexPath.row];
        if ([target_s isEqualToString:@"邀约对象"]) {
            target_s=@"";
        }
        [self loadData:@"refresh"];
    }else if(indexPath.column==2){
        [self showProgressing:@"正在加载"];
        time_s=_time[indexPath.row];
        if ([time_s isEqualToString:@"邀约时间"]) {
            time_s=@"";
        }
        [self loadData:@"refresh"];
    }
}


//表格代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.yues.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *normalId=@"YueGameCell";
    YueGameCell *ycell=[tableView dequeueReusableCellWithIdentifier:normalId forIndexPath:indexPath];
    
    if (!ycell) {
        ycell=[[YueGameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalId];
    }
    
    NSString *url=[NSString stringWithFormat:@"%@%@",HEADIMGURL,[_yues[indexPath.row] objectForKey:@"user_img"]];
    NSLog(@"%@",url);
    [ycell.head_img sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"setting_head"]];
    ycell.username.text=[_yues[indexPath.row] objectForKey:@"user_name"];
    ycell.school.text=[_yues[indexPath.row] objectForKey:@"user_school"];
    ycell.sex.text=[_yues[indexPath.row] objectForKey:@"user_sex"];
    ycell.yue_title.text=[NSString stringWithFormat:@"标题:%@",[_yues[indexPath.row] objectForKey:@"yue_title"]];
    ycell.yue_time.text=[NSString stringWithFormat:@"时间:%@",[_yues[indexPath.row] objectForKey:@"yue_time"]];
    ycell.yue_address.text=[NSString stringWithFormat:@"地点:%@",[_yues[indexPath.row] objectForKey:@"yue_address"]];
    
    ycell.yue_publish_time.text=[NSString stringWithFormat:@"发布时间:%@",[_yues[indexPath.row] objectForKey:@"yue_publish_time"]];
    return ycell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LostDetail *lost=[story instantiateViewControllerWithIdentifier:@"LostDetail"];
    
    lost.lost_id=[_yues[indexPath.row] objectForKey:@"yue_id"];
    lost.user_phone=[_yues[indexPath.row] objectForKey:@"user_phone"];
    lost.HttpPath=@"yueba/yuefan_detail";
    [self.navigationController pushViewController:lost animated:YES];
}


//刷新
-(void)refresh{
    
    __weak YueGameList *weakSelf = self;
    [weakSelf loadData:@"refresh"];
    
}
//加载更多
-(void)load{
    __weak YueGameList *weakSelf = self;
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
    
    //约主题的请求参数
    NSDictionary *parames=[NSDictionary  dictionaryWithObjectsAndKeys:      pageSizeStr,@"pagesize",
             offset,@"offset",
             @"三峡大学",@"school",
             game,@"yue_game",
             target_s,@"yue_target",
             time_s,@"yue_time",nil];
    
    
    NSString*url=@"yueba/get_yuegame_list";
    
    
    
    
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:url params:parames httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
        NSLog(@"%@",json);
        //加载到的数据
        NSArray *array=(NSArray*)json;
        //处理数据
        if ([@"refresh" isEqualToString:flag]) {
            //刷新，要先清空原有的数据
            [_yues removeAllObjects];
            [_yues addObjectsFromArray:array];
        }else{
            //加载更多显示的数据是之前的数据和加载的数据的和
            [_yues addObjectsFromArray:array];
            
        }
        
        
        
        //选择性开启上拉加载
        if (array.count<pageSize) {
            //如果加载的数据小于于pageSize条 不让他可以上拉加载
            self.yueList.footer.hidden=YES;
        }else{
            //如果加载的数据大于pageSize条 让他可以上拉加载
            self.yueList.footer.hidden=NO;
        }
        //数据刷新到表格里面去
        [self.yueList reloadData];
        
        //隐藏动画
        [self hide];
        [self.yueList.header endRefreshing];
        [self.yueList.footer endRefreshing];
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        //隐藏动画
        [self hide];
        [self.yueList.header endRefreshing];
        [self.yueList.footer endRefreshing];
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
