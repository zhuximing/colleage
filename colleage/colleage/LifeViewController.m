//
//  LifeViewController.m
//  colleage
//
//  Created by Apple on 15/8/30.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LifeViewController.h"
#import "CommonUtil.h"
@interface LifeViewController ()

@end

@implementation LifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"生活";
   self.view.backgroundColor=[UIColor grayColor];
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"生活"];
    
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
