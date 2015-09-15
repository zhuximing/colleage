//
//  CarList.h
//  colleage
//
//  Created by Apple on 15/9/13.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"
#import "DOPDropDownMenu.h"
@interface CarList : NextViewController<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>{

    int pageNow;
    int pageSize;
    NSMutableArray *cars;

}
@property  NSString *start_city;//出发城市
@property NSString *end_city;   //目的城市

@property (nonatomic, strong) NSArray *target;
@property (nonatomic, strong) NSArray *time;

@property (weak, nonatomic) IBOutlet UITableView *carList;


@end
