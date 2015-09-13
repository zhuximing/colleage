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
@interface CarList ()

@end

@implementation CarList

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"路线列表"];
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    NSLog(@"start%@",self.start_city);
    NSLog(@"end%@",self.end_city);
    
    // 数据
    self.classifys = @[@"美食",@"今日新单",@"电影",@"酒店"];
    self.cates = @[@"自助餐",@"快餐",@"火锅",@"日韩料理",@"西餐",@"烧烤小吃"];
    self.movices = @[@"内地剧",@"港台剧",@"英美剧"];
    self.hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    
   
    
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    NSLog(@"<<<<<<<<<<<>>>>>>>>>>>>>");
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CarCell";
    
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[CarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    //赋值
   // cell.lost_name.text=[losts[indexPath.row] objectForKey:@"lost_name"];
    
   // cell.school.text=[losts[indexPath.row] objectForKey:@"user_school"];
    
   // cell.lost_address.text=[losts[indexPath.row] objectForKey:@"lost_address"];
   // cell.publish_time.text=[losts[indexPath.row] objectForKey:@"lost_time"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取故事版
    //UIStoryboard *story=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //获取登陆后的个人中心的视图控制器
  //  LostDetail *lost=[story instantiateViewControllerWithIdentifier:@"LostDetail"];
    
  //  lost.lost_id=[losts[indexPath.row] objectForKey:@"lost_id"];
  //  lost.user_phone=[losts[indexPath.row] objectForKey:@"user_phone"];
  //  lost.HttpPath=@"lost/lost_detail";
  //  [self.navigationController pushViewController:lost animated:YES];
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
