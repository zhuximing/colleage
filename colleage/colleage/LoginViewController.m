//
//  LoginViewController.m
//  colleage
//
//  Created by Apple on 15/9/1.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonUtil.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = [CommonUtil navigationTitleViewWithTitle:@"登陆"];
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
