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
    
    //NavigationBar与UIViewController 重叠的问题
    if( IS_iOS7) {
        self.edgesForExtendedLayout= UIRectEdgeNone;
    }
    
    //用户名输入框的左边图片
    UIImage *image=[UIImage imageNamed:@"login_admin"];
    UIImageView *imageView=[[UIImageView alloc ] initWithImage:image];
    _loginTf.leftView=imageView;
    _loginTf.leftViewMode=UITextFieldViewModeAlways;
    
    //密码输入框的左边图片
    UIImage *image1=[UIImage imageNamed:@"login_key"];
    UIImageView *imageView1=[[UIImageView alloc ] initWithImage:image1];
    _pwdTf.leftView=imageView1;
    _pwdTf.leftViewMode=UITextFieldViewModeAlways;
    
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
