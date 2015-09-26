//
//  YueGameList.h
//  colleage
//
//  Created by Apple on 15/9/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"

@interface YueGameList : NextViewController{
    int pageNow;
    int pageSize;
    NSString *game;
    NSString *target_s;
    NSString *time_s;
}
@property (weak, nonatomic) IBOutlet UITableView *yueList;

@end
