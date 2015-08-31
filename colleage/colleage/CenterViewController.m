//
//  CenterViewController.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "CenterViewController.h"
#import "CommonUtil.h"
@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人中心";
    self.view.backgroundColor=[UIColor orangeColor];
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"个人中心"];
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
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
