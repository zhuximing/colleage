//
//  PublishHelp.m
//  colleage
//
//  Created by Apple on 15/9/12.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "PublishHelp.h"
#import "CommonUtil.h"
@interface PublishHelp ()

@end

@implementation PublishHelp

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //标题
    self.navigationItem.titleView=[CommonUtil navigationTitleViewWithTitle:@"发布需求"];
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
