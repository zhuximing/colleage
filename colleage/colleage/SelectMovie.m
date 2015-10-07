//
//  SelectMovie.m
//  colleage
//
//  Created by Apple on 15/10/4.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SelectMovie.h"
#import "CommonUtil.h"
#import "HotMovieCell.h"
@interface SelectMovie (){
    NSMutableArray *hot_movies;

}


@end

@implementation SelectMovie

- (void)viewDidLoad {
    [super viewDidLoad];
    hot_movies=[[NSMutableArray alloc] init];
    // 标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"请选择电影"];
   
    
    //完成
    UIButton *rightBtn                     = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame                         = CGRectMake(0, 0, 50, 44);
    rightBtn.showsTouchWhenHighlighted     = YES;
    [rightBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    //[rightBtn setImage:[UIImage imageNamed:@"common_back"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButtonItem    = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    //异步获取数据
    [self loadData];
}
-(void)loadData{
    
   [self showProgressing:@"加载中..."];
    //获取数据
    MKNetworkEngine *engine=[[MKNetworkEngine alloc]
                             initWithHostName:BASEHOME
                             customHeaderFields:nil];
    //执行请求
    MKNetworkOperation *op=[engine operationWithPath:@"yueba/get_hot_films" params:nil httpMethod:@"POST"];
    //请求回调
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        
        
        id json=[completedOperation responseJSON];
        //加载到的数据
        NSArray *array=(NSArray*)json;
        [hot_movies addObjectsFromArray:array];
        //数据刷新到表格里面去
        [self.table_movie reloadData];
        [self hide];
      
    } onError:^(NSError *error) {
        [self showToast:@"网络异常"];
        [self hide];
       
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
}

#pragma mark - 表格代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return hot_movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HotMovieCell";
    
    HotMovieCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[HotMovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    //赋值
    cell.movie_name.text=[hot_movies[indexPath.row] objectForKey:@"film_name"];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tv_movie.text=[hot_movies[indexPath.row] objectForKey:@"film_name"];
}








-(void)finish{
    if (_tv_movie.text.length==0) {
        [self showToast:@"请选择影片"];
        
    }else{
        [self.delegate getMovie:_tv_movie.text];
        [self.navigationController popViewControllerAnimated:YES];
    
    }



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
