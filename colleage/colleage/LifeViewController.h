//
//  LifeViewController.h
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface LifeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *yues;
     MBProgressHUD *hud;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
