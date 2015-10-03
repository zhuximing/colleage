//
//  MarketListViewController.h
//  colleage
//
//  Created by Apple on 15/9/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextViewController.h"

@interface MarketListViewController : NextViewController<UITableViewDataSource,UITableViewDelegate>{
        NSMutableArray *marketArr;
        int pageNow;
        int pageSize;
}
@property(strong,nonatomic) NSString *typetitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
