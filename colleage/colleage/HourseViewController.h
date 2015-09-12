//
//  HourseViewController.h
//  colleage
//
//  Created by Apple on 15/9/9.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NextTableViewController.h"

@interface HourseViewController : NextTableViewController
{
    NSMutableArray *hourseArr;
    int pageNow;
    int pageSize;
}
@end
