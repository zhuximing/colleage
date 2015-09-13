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

@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;
@property (weak, nonatomic) IBOutlet UITableView *carList;


@end
