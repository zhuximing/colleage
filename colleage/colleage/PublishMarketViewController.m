//
//  PublishMarketViewController.m
//  colleage
//
//  Created by Apple on 15/10/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishMarketViewController.h"
#import "CommonUtil.h"

@interface PublishMarketViewController ()

@end

@implementation PublishMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布二手物品"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
