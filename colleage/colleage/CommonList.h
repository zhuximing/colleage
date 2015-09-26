//
//  CommonList.h
//  colleage
//
//  Created by Apple on 15/9/24.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "DOPDropDownMenu.h"

@interface CommonList : NextViewController<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>{
    NSString *target_s;  //邀约对象
    NSString *time_s;   //出发时间
    NSString *sport_s;  //体育项目
    NSString *mudidi_s;   //目的地
    NSString *theme_s;  //主题约会
    int pageNow;
    int pageSize;
    NSMutableArray *yues;
}
@property(nonatomic,strong) NSArray *mudidi;
@property(nonatomic,strong) NSArray *theme;
@property(nonatomic,strong) NSArray *sport;
@property (nonatomic, strong) NSArray *target;
@property (nonatomic, strong) NSMutableArray *time;
@property (weak, nonatomic) IBOutlet UITableView *yueList;
@property(nonatomic ,strong)NSString *type;//邀约类型
@end
