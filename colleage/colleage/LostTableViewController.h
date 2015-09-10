//
//  LostTableViewController.h
//  colleage
//
//  Created by Apple on 15/9/8.
//  Copyright (c) 2015年 Apple. All rights reserved.
//
#import "NextTableViewController.h"
#import <UIKit/UIKit.h>

@interface LostTableViewController : NextTableViewController
{
    NSMutableArray *losts;
    int pageNow;
    int pageSize;
}
@end
