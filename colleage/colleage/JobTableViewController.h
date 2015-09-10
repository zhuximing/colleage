//
//  JobTableViewController.h
//  colleage
//
//  Created by Apple on 15/9/10.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "NextTableViewController.h"
#import <UIKit/UIKit.h>
#import "JobTableViewCell.h"

@interface JobTableViewController : NextTableViewController{
    NSMutableArray *jobArr;
    int pageNow;
    int pageSize;
}

@end
